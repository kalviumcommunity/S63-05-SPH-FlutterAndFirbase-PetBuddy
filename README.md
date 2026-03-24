# Flutter Environment Setup and First App Run

## Project title + short description
**Project Title:** PetBuddy Widget Tree Demo  
**Short Description:** A simple Flutter app that demonstrates a clear widget tree structure and one interactive UI change using `setState()` (button text and color toggle).

## Folder structure summary
- `lib/`: main app code (Dart files)
- `android/`: Android build configuration
- `ios/`: iOS build configuration
- `assets/`: images/fonts and other static files (if used)
- `test/`: test files
- `pubspec.yaml`: dependencies and project configuration

Link: `PROJECT_STRUCTURE.md`

## Widget tree diagram (indent format)
MaterialApp  
  └─ WelcomeScreen (StatefulWidget)  
     └─ Scaffold  
        ├─ AppBar  
        └─ body: Center  
           └─ Padding  
              └─ Column  
                 ├─ Text (title)  
                 ├─ SizedBox  
                 ├─ Icon (via `WelcomeIcon`)  
                 ├─ SizedBox  
                 └─ ElevatedButton (onPressed → `setState()`)

## Explanation
### What is widget tree
The widget tree is the nested structure of widgets in a Flutter app. Each widget is a parent or child of another widget, forming a tree that describes the UI layout.

### How reactive UI works
Flutter builds the UI by calling `build()` methods. When state changes (via `setState()`), Flutter rebuilds the affected part of the widget tree to reflect the new values.

### Why Flutter updates only parts of UI
When you call `setState()`, Flutter re-runs `build()` for that widget and its subtree, not the entire app. This keeps updates efficient and the UI responsive.

## Steps followed
- Installation of Flutter SDK
  - Downloaded the Flutter SDK.
  - Extracted it and added Flutter to the system PATH.
- Setting up Android Studio or VS Code
  - Installed Android Studio or VS Code.
  - Installed Flutter and Dart plugins/extensions.
- Running flutter doctor
  - Ran `flutter doctor` to check if everything is configured correctly.
  - Fixed any issues until all checks showed green.
- Creating and running first Flutter app
  - Created a new Flutter project.
  - Started an Android emulator.
  - Ran the app using `flutter run`.

## Screenshots
### Before state (initial UI)
`(before_state_screenshot.png)`

### After state (after button press / state change)
`(after_state_screenshot.png)`

### Flutter Doctor output (all green checks)
`(flutter_doctor_screenshot.png)`

### Running app on emulator
`(first_app_run_screenshot.png)`

## Reflection
- Challenges faced during installation
  - Setting the PATH correctly and ensuring tools were detected by `flutter doctor`.
  - Making sure the emulator/device was available for running the app.
- How this setup helps in building and testing mobile apps
  - Flutter setup allows quick app creation and testing on an emulator/device.
  - `flutter doctor` helps verify the environment so development is smoother.

