# PetBuddy

![PetBuddy Logo](assets/images/dog.avif)

**A Trusted Pet Care Discovery & Monitoring Platform**

---

## 📋 Table of Contents

1. [Project Overview](#project-overview)
2. [Problem Statement](#problem-statement)
3. [Core Features](#core-features)
4. [How It Works](#how-it-works)
5. [Data Models](#data-models)
6. [Technical Stack](#technical-stack)
7. [Project Structure](#project-structure)
8. [Key Functionalities](#key-functionalities)
9. [Firebase Integration](#firebase-integration)
10. [User Roles & Workflows](#user-roles--workflows)
11. [Installation & Setup](#installation--setup)
12. [Development Progress](#development-progress)

---

## 🎯 Project Overview

**PetBuddy** is a cross-platform mobile application designed to bridge the gap between pet owners and trusted pet caregivers. The app enables pet owners to securely discover qualified caregivers, schedule pet care services (especially dog walks), and monitor their pets in real-time. Caregivers, in turn, can build their professional reputation through a trust-score system and establish a reliable client base.

**App Description:**  
_A trusted pet care discovery and monitoring app for pet owners and caregivers_

**Project Status:** In Active Development (Version 1.0.0)  
**Target Platforms:** Android, iOS, Web  
**Development Framework:** Flutter + Firebase

---

## ❌ Problem Statement

Pet owners face critical challenges:
- **Trust & Safety Concerns:** Finding reliable, verified caregivers is difficult and risky
- **Communication Gaps:** Limited ways to monitor their pets while away
- **Quality Assurance:** No standardized way to track caregiver credentials or performance
- **Scheduling Friction:** Coordinating care services with multiple providers is cumbersome

**PetBuddy's Solution:**
- **Verified Caregiver Network:** Background-checked, trust-scored professionals
- **Real-Time Monitoring:** Live location tracking, photo/status updates during pet care
- **Transparent Feedback System:** Reviews, ratings, and completed-walk tracking
- **Streamlined Booking:** One-tap service requests with instant acceptance/rejection

---

## ⭐ Core Features

### For Pet Owners
1. **Pet Profile Management**
   - Register multiple pets (dogs, cats, other)
   - Store breed, age, medical notes
   - Upload pet photos for caregiver identification

2. **Caregiver Discovery**
   - Browse qualified caregivers with trust scores
   - View caregiver ratings, reviews, and completed walks
   - See distance to caregiver location

3. **Care Request System**
   - Request walk sessions or pet care services
   - Specify date/time preferences and special instructions
   - Real-time status updates (pending → accepted → in progress → completed)

4. **Real-Time Monitoring**
   - Live location tracking during walks
   - Photo updates from the caregiver
   - Text/status messages during care sessions
   - Activity history log

5. **Profile & Account**
   - Manage pet portfolio
   - Edit preferences and notification settings
   - Verify account for safety
   - Review completed walks and leave feedback

### For Caregivers
1. **Professional Profile**
   - Build verifiable caregiver profile
   - Track completed walks and services
   - Accumulate trust score through successful jobs
   - Showcase certifications or special skills

2. **Job Discovery**
   - View incoming pet care requests
   - Accept/reject requests based on availability
   - See pet details and owner requirements
   - Track pet preferences and medical alerts

3. **Session Management**
   - Start/end walk sessions
   - Share location, photos, and real-time updates
   - Log activity notes for pet owners
   - Complete jobs and receive feedback

4. **Earnings & Reputation**
   - Track completed walks
   - Build trust score (impacts visibility to owners)
   - Access review history
   - Monitor activity earnings (future payment integration)

---

## 🔄 How It Works

### Workflow: Owner Perspective
```
1. Sign Up & Create Pet Profiles
2. Browse Available Caregivers
3. Send Care Request (with date/time/instructions)
4. Caregiver Accepts → Real-Time Notifications
5. Monitor Walk in Real-Time (location + photos + updates)
6. Walk Completes → Receive Activity Summary
7. Leave Feedback & Rate Caregiver
```

### Workflow: Caregiver Perspective
```
1. Sign Up & Create Professional Profile
2. Accept Service Requests from Pet Owners
3. Review Pet Details & Special Requirements
4. Start Session → Share Location & Photos
5. End Session → Provide Activity Summary
6. Earn Trust Score & Collect Feedback
7. Build Reputation for Future Bookings
```

---

## 📊 Data Models

### **UserModel**
Represents both pet owners and caregivers with role-based distinction.
```dart
class UserModel {
  - uid: String (Firebase Auth UID)
  - email: String
  - fullName: String
  - role: enum { owner, caregiver }
  - photoUrl: String? (profile photo)
  - completedWalks: int (career total)
  - trustScore: int (0-100, caregiver reputation)
  - createdAt: DateTime
  - isVerified: bool (safety verification)
}
```

### **PetModel**
Stores all pet information owned by an owner.
```dart
class PetModel {
  - id: String (Firestore doc ID)
  - ownerId: String (reference to owner)
  - name: String
  - type: enum { dog, cat, other }
  - breed: String?
  - age: int
  - gender: enum { male, female }
  - photoUrl: String? (pet photo)
  - createdAt: DateTime
}
```

### **WalkSessionModel**
Records each individual pet walk/care session.
```dart
class WalkSessionModel {
  - id: String (Firestore doc ID)
  - petId: String (reference to pet)
  - caregiverId: String (reference to caregiver)
  - ownerId: String (reference to owner)
  - startTime: DateTime
  - endTime: DateTime?
  - status: enum { scheduled, inProgress, completed, cancelled }
  - location: GeoPoint (real-time tracking)
  - updates: List<WalkUpdate> (messages, photos, timestamps)
  - notes: String? (session summary)
  - createdAt: DateTime
}
```

### **RequestModel**
Represents a pet care request from owner to caregiver.
```dart
class RequestModel {
  - id: String (Firestore doc ID)
  - petOwnerId: String
  - caregiverId: String
  - petName: String
  - petType: String { dog, cat, other }
  - ownerName: String
  - caregiverName: String
  - requestedDate: DateTime
  - requestedTime: String?
  - status: enum { pending, accepted, rejected, completed }
  - distance: double? (kilometers between owner and caregiver)
  - notes: String? (special instructions)
  - createdAt: DateTime
}
```

### **ActivityLogModel**
Tracks all user activities for audit and history.
```dart
class ActivityLogModel {
  - id: String
  - userId: String
  - action: String (e.g., "walk_completed", "request_accepted")
  - details: Map (context-specific data)
  - timestamp: DateTime
}
```

---

## 🛠️ Technical Stack

### **Frontend**
- **Framework:** Flutter 3.x with Dart ^3.10.8
- **UI Design:** Material Design 3 (custom theming with Poppins font)
- **State Management:** Provider 6.1.2 with ChangeNotifier pattern

### **Backend & Database**
- **Authentication:** Firebase Authentication (email/password)
- **Database:** Cloud Firestore (real-time NoSQL)
- **Storage:** Firebase Storage (images/documents)
- **API Integration:** Firestore REST APIs via SDKs

### **Additional Libraries**
- **google_fonts:** Custom typography (Poppins)
- **image_picker:** Camera & gallery access for pet/session photos
- **intl:** Date/time localization and formatting
- **shimmer:** Loading state placeholders
- **cupertino_icons:** iOS-style icons

### **Android Stack**
- **Language:** Kotlin (DSL for Gradle configuration)
- **Java Version:** Java 17
- **NDK:** Android NDK 28.2.13676358 (native compilation)
- **Build System:** Gradle with Flutter and Google Play Services plugins
- **Min SDK:** Flutter default, Target SDK: Flutter default

### **iOS Stack**
- **Language:** Swift
- **Dependency Manager:** CocoaPods
- **Minimum Deployment:** iOS 11+

### **Version Control & DevOps**
- **Git:** Version control
- **Firebase Console:** Real-time monitoring, security rules, database inspection
- **Firestore Rules:** Custom security rules for role-based access control

---

## 📁 Project Structure

```
petbuddy/
├── lib/
│   ├── main.dart                     # App entry point
│   ├── app.dart                      # Material app config & theme
│   ├── firebase_options.dart         # Firebase initialization
│   │
│   ├── models/                       # Data models
│   │   ├── user_model.dart
│   │   ├── pet_model.dart
│   │   ├── walk_session_model.dart
│   │   ├── request_model.dart
│   │   └── activity_log_model.dart
│   │
│   ├── providers/                    # State management (Provider pattern)
│   │   ├── auth_provider.dart
│   │   ├── pets_provider.dart
│   │   ├── walks_provider.dart
│   │   ├── request_provider.dart
│   │   └── activity_provider.dart
│   │
│   ├── services/                     # Business logic & data layer
│   │   ├── auth_service.dart
│   │   ├── firestore_service.dart
│   │   ├── pet_service.dart
│   │   ├── caregiver_service.dart
│   │   ├── request_service.dart
│   │   └── activity_service.dart
│   │
│   ├── screens/                      # UI screens
│   │   ├── login_screen.dart         # Authentication
│   │   ├── signup_screen.dart
│   │   ├── role_selection_screen.dart
│   │   ├── home_screen.dart          # Main dashboard
│   │   ├── pets_screen.dart          # Pet management (owner)
│   │   ├── add_pet_screen.dart
│   │   ├── edit_pet_screen.dart
│   │   ├── caregiver_list_screen.dart # Caregiver discovery
│   │   ├── caregiver_job_screen.dart # Job management (caregiver)
│   │   ├── activity_screen.dart      # Activity/walk history
│   │   ├── profile_screen.dart       # User profile & settings
│   │   ├── edit_profile_screen.dart
│   │   ├── role_based_dashboard.dart
│   │   └── [demo screens]            # Flutter UI samples
│   │
│   ├── widgets/                      # Reusable UI components
│   │   └── [custom widgets]
│   │
│   └── services/                     # Utilities & API handling
│       └── [service implementations]
│
├── android/                           # Android build & configuration
│   ├── app/
│   │   ├── build.gradle.kts          # App-level config
│   │   ├── src/
│   │   │   └── debug/
│   │   │       └── google-services.json  # Firebase Android config
│   │   └── AndroidManifest.xml
│   ├── build.gradle.kts              # Project-level config
│   └── gradle.properties
│
├── ios/                               # iOS build & configuration
│   ├── Runner/
│   │   └── Info.plist
│   ├── Podfile                       # CocoaPods config
│   └── [Xcode project files]
│
├── assets/                            # Static assets
│   ├── images/
│   │   └── dog.avif
│   └── [additional images]
│
├── pubspec.yaml                       # Flutter project manifest
├── analysis_options.yaml              # Dart linter rules
├── firebase.json                      # Firebase CLI config
├── firestore.rules                    # Firestore security rules
├── firestore.indexes.json             # Firestore indexes
└── README.md                          # Project documentation
```

---

## 🎮 Key Functionalities

### 1. **Authentication & Authorization**
- Email/password signup and login via Firebase Auth
- Role-based access control (owner vs. caregiver)
- Profile creation with role-specific fields
- Session management and logout

### 2. **Pet Management (Owner)**
- Add multiple pets with photos and details
- Edit pet information
- Upload pet photos to Firebase Storage
- View personal pet portfolio

### 3. **Caregiver Discovery (Owner)**
- Browse caregiver list with filters (distance, trust score, specialty)
- View caregiver profiles, ratings, and completed walks
- Calculate distance to caregiver location
- Request services directly from caregiver profiles

### 4. **Care Request Workflow**
- Create request: pet selection, date/time, special notes
- Real-time status updates (pending → accepted → rejected)
- Caregiver notifications on new requests
- Accept/reject interface for caregivers

### 5. **Real-Time Walk Monitoring**
- Live geolocation tracking during walk sessions
- Photo upload from caregiver phone during session
- Status message updates and chat-like communication
- Estimated completion time
- Activity log saved to Firestore

### 6. **Activity & History**
- Complete walk history with timestamps
- Activity feed for owners (walk completed, request accepted, etc.)
- Downloadable activity summaries
- Filter by date, pet, or caregiver

### 7. **Trust & Reputation System**
- Trust score calculation based on completed walks
- Caregiver ratings and reviews
- Verification status badge
- Profile confidence score

### 8. **Responsive UI**
- Mobile-first design (works on phones & tablets)
- Adaptive layouts using MediaQuery and Expanded widgets
- Efficient scrolling with ListView.builder and GridView.builder
- Material Design components for consistency

---

## 🔥 Firebase Integration

### **Authentication**
- **Method:** Email/password with Firebase Auth
- **User Storage:** Firestore `users` collection
- **Session:** Persistent via Firebase Auth token

### **Firestore Collections**
```
users/
  └─ {uid}
     ├─ email: string
     ├─ fullName: string
     ├─ role: "owner" | "caregiver"
     ├─ completedWalks: integer
     ├─ trustScore: integer
     └─ isVerified: boolean

pets/
  └─ {petId}
     ├─ ownerId: string (users/{uid})
     ├─ name: string
     ├─ type: "dog" | "cat" | "other"
     ├─ breed: string
     ├─ age: integer
     └─ photoUrl: string (Firebase Storage path)

requests/
  └─ {requestId}
     ├─ petOwnerId: string
     ├─ caregiverId: string
     ├─ petName: string
     ├─ status: "pending" | "accepted" | "rejected" | "completed"
     ├─ requestedDate: timestamp
     └─ notes: string

walkSessions/
  └─ {sessionId}
     ├─ petId: string
     ├─ caregiverId: string
     ├─ ownerId: string
     ├─ status: "scheduled" | "inProgress" | "completed" | "cancelled"
     ├─ startTime: timestamp
     ├─ endTime: timestamp?
     └─ updates: array of {message, photoUrl, location, timestamp}

activityLog/
  └─ {logId}
     ├─ userId: string
     ├─ action: string
     ├─ details: map
     └─ timestamp: timestamp
```

### **Storage Structure**
```
gs://petbuddy-fb980.firebasestorage.app/
├─ users/{uid}/profile.jpg
├─ pets/{petId}/photo.jpg
└─ walkSessions/{sessionId}/updates/{timestamp}.jpg
```

### **Security Rules**
- Read/write access restricted by user role and ownership
- Owners can only view their own pets and requests
- Caregivers can only accept/view requests assigned to them
- Public read access for verified caregiver profiles (search/discovery)

---

## 👥 User Roles & Workflows

### **Pet Owner**
**Intent:** Find trusted caregivers and monitor their pets remotely

**Workflow:**
1. Sign up → select "Pet Owner" role
2. Create pet profiles (name, breed, age, photo)
3. Browse caregiver listings with trust scores
4. Send care request → receive notifications
5. Monitor walk live with location + photos
6. Leave feedback after completion

**Dashboard Elements:**
- Pet carousel/list
- Upcoming care requests
- Live walk map
- Activity history feed

### **Caregiver**
**Intent:** Build a client base and earn income through trusted pet care

**Workflow:**
1. Sign up → select "Caregiver" role
2. Build professional profile
3. View incoming pet care requests
4. Accept/reject requests
5. During session: share location, send photo updates
6. Complete session → record activity summary
7. Earn trust points and collect reviews

**Dashboard Elements:**
- New job requests
- Current walk session (with map)
- Job history with earnings
- Client reviews and ratings
- Trust score progress

---

## 🚀 Installation & Setup

### **Prerequisites**
- Flutter SDK ^3.10.8
- Dart SDK ^3.10.8
- Android Studio / Xcode
- Git
- Firebase account (Google Cloud project)

### **Step 1: Clone the Repository**
```bash
git clone <repository_url>
cd petbuddy
```

### **Step 2: Install Dependencies**
```bash
flutter pub get
```

### **Step 3: Firebase Configuration**
- Download `google-services.json` from Firebase Console
- Place in `android/app/`
- Download `GoogleService-Info.plist` for iOS (if building iOS)
- Place in `ios/Runner/`

### **Step 4: Run the App**
```bash
flutter run -d "SM A736B"  # Android device example
# OR
flutter run -d "iPhone"    # iOS emulator example
```

### **Step 5: Connect to Firebase**
The app auto-initializes Firebase on startup via `firebase_options.dart`. Ensure your Google Cloud project allows:
- Firebase Authentication (Email provider)
- Cloud Firestore (with security rules enabled)
- Firebase Storage (for image uploads)

---

## 📈 Development Progress

### ✅ **Completed Tasks**

**Task 3.10: Firebase Integration**
- ✓ Firebase Authentication (signup/login/logout)
- ✓ User data storage in Firestore
- ✓ Real-time data synchronization
- ✓ CRUD operations tested and verified
- ✓ Security rules configured

**Core Architecture**
- ✓ Provider-based state management
- ✓ Service layer for Firestore operations
- ✓ Model serialization (to/from Firestore)
- ✓ Role-based UI rendering

**UI Screens**
- ✓ Login & Signup screens
- ✓ Role selection screen
- ✓ Pet management screens (add, edit, view)
- ✓ Home dashboard (role-specific)
- ✓ Profile & settings screens
- ✓ Responsive layouts and scrollable views
- ✓ Form validation and error handling

### 🔄 **In Progress**

- Real-time walk session monitoring with geolocation
- Live photo upload during walks
- Chat/messaging between owner and caregiver
- Advanced caregiver discovery filters
- Payment integration (Stripe/PayPal)

### 📋 **Planned Features**

- Push notifications for requests/updates
- In-app messaging system
- Subscription plans for caregivers
- Vet clinic integrations
- Pet health record storage
- Insurance partnerships
- Caregiver background check API integration
- API rate limiting and usage analytics

---

## 📝 License

This project is proprietary software. Unauthorized copying or distribution is prohibited.

---

## 💬 Questions & Support

For issues, feature requests, or questions:
- Create an issue in the repository
- Contact the development team
- Review Firebase Console for real-time error logs

---

**Last Updated:** April 6, 2026  
**Version:** 1.0.0  
**Status:** Active Development
