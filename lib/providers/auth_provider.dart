import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

enum AuthStatus {
  initial,
  authenticating,
  authenticated,
  unauthenticated,
  error,
}

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  AuthStatus _status = AuthStatus.initial;
  UserModel? _userProfile;
  String? _errorMessage;
  bool _needsRoleSelection = false;
  bool _isAuthenticating = false; // Prevents race conditions

  AuthStatus get status => _status;
  UserModel? get userProfile => _userProfile;
  UserModel? get user => _userProfile; // Alias for compatibility
  String? get errorMessage => _errorMessage;
  bool get needsRoleSelection => _needsRoleSelection;
  User? get currentUser => _authService.currentUser;
  bool get isAuthenticated => _status == AuthStatus.authenticated;

  AuthProvider() {
    _init();
  }

  Future<void> _init() async {
    _authService.authStateChanges.listen((user) async {
      // Skip if we're in the middle of a sign-in/sign-up operation
      if (_isAuthenticating) return;

      if (user != null) {
        await _loadUserProfile(user.uid);
      } else {
        _status = AuthStatus.unauthenticated;
        _userProfile = null;
        _needsRoleSelection = false;
        notifyListeners();
      }
    });
  }

  Future<void> _loadUserProfile(String uid) async {
    try {
      _userProfile = await _authService.getUserProfile(uid);
      if (_userProfile != null) {
        _status = AuthStatus.authenticated;
        _needsRoleSelection = false;
      } else {
        // User exists in Auth but not in Firestore yet
        _needsRoleSelection = true;
        _status = AuthStatus.authenticated;
      }
    } catch (e) {
      // On Firestore error, still allow user through since Firebase Auth succeeded
      // They may need to select a role or profile will be created later
      _needsRoleSelection = true;
      _status = AuthStatus.authenticated;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  /// Sign up with email and password
  Future<bool> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      _isAuthenticating = true;
      _status = AuthStatus.authenticating;
      _errorMessage = null;
      notifyListeners();

      final credential = await _authService.signUp(
        email: email,
        password: password,
        fullName: fullName,
      );

      if (credential.user != null) {
        _needsRoleSelection = true;
        _status = AuthStatus.authenticated;
        _isAuthenticating = false;
        notifyListeners();
        return true;
      }
      _isAuthenticating = false;
      return false;
    } catch (e) {
      _isAuthenticating = false;
      _status = AuthStatus.unauthenticated;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  /// Sign in with email and password
  Future<bool> signIn({required String email, required String password}) async {
    try {
      _isAuthenticating = true;
      _status = AuthStatus.authenticating;
      _errorMessage = null;
      notifyListeners();

      final credential = await _authService.signIn(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        await _loadUserProfile(credential.user!.uid);
        _isAuthenticating = false;
        return true;
      }
      _isAuthenticating = false;
      return false;
    } catch (e) {
      _isAuthenticating = false;
      _status = AuthStatus.unauthenticated;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  /// Complete registration with role selection
  Future<bool> completeRegistration(UserRole role) async {
    try {
      final user = _authService.currentUser;
      if (user == null) {
        debugPrint('[AuthProvider] completeRegistration: No current user');
        return false;
      }

      debugPrint('[AuthProvider] completeRegistration: Creating profile for ${user.uid}...');

      try {
        await _authService.createUserProfile(
          uid: user.uid,
          email: user.email ?? '',
          fullName: user.displayName ?? '',
          role: role,
        ).timeout(
          const Duration(seconds: 10),
          onTimeout: () {
            debugPrint('[AuthProvider] completeRegistration: Firestore write TIMED OUT after 10s');
            debugPrint('[AuthProvider] This usually means Firestore security rules are blocking writes.');
            debugPrint('[AuthProvider] Please deploy your firestore.rules to your Firebase project.');
            throw TimeoutException('Firestore write timed out. Check your Firestore security rules.');
          },
        );
        debugPrint('[AuthProvider] completeRegistration: Profile created successfully');
      } on TimeoutException catch (e) {
        _errorMessage = e.message;
        // Even if Firestore write fails, unblock navigation so the user isn't stuck
        _needsRoleSelection = false;
        _status = AuthStatus.authenticated;
        notifyListeners();
        return false;
      }

      debugPrint('[AuthProvider] completeRegistration: Loading profile...');
      await _loadUserProfile(user.uid).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          debugPrint('[AuthProvider] completeRegistration: Profile load timed out');
        },
      );

      _needsRoleSelection = false;
      notifyListeners();
      debugPrint('[AuthProvider] completeRegistration: Done. needsRoleSelection=false');
      return true;
    } catch (e) {
      debugPrint('[AuthProvider] completeRegistration ERROR: $e');
      _errorMessage = e.toString();
      // Unblock the user even on error
      _needsRoleSelection = false;
      notifyListeners();
      return false;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    await _authService.signOut();
    _status = AuthStatus.unauthenticated;
    _userProfile = null;
    _needsRoleSelection = false;
    _errorMessage = null;
    notifyListeners();
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Refresh user profile
  Future<void> refreshProfile() async {
    final user = _authService.currentUser;
    if (user != null) {
      await _loadUserProfile(user.uid);
    }
  }

  /// Update user profile
  Future<bool> updateProfile({String? fullName, String? photoUrl}) async {
    try {
      final user = _authService.currentUser;
      if (user == null) {
        _errorMessage = 'User not authenticated';
        notifyListeners();
        return false;
      }

      // Update Firebase Auth display name
      if (fullName != null && fullName.trim().isNotEmpty) {
        await user.updateDisplayName(fullName.trim());
      }

      // Update Firestore user profile
      await _authService.updateUserProfile(
        uid: user.uid,
        fullName: fullName,
        photoUrl: photoUrl,
      );

      // Reload profile
      await _loadUserProfile(user.uid);
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}
