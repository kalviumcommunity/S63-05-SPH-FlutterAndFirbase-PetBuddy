# Project Structure (Flutter)

## Introduction
This document explains the folder and file structure of this Flutter project, so it’s easier to understand where code and configuration live.

## Folder and File Explanations

### `lib/`
- Main Dart source code for the app.
- Usually contains `main.dart` (entry point) and your screens/widgets/services/models.

### `android/`
- Android-specific project files used to build and run the app on Android.
- Contains Gradle configuration and Android app settings.

### `ios/`
- iOS-specific project files used to build and run the app on iOS.
- Contains Xcode project configuration and iOS app settings.

### `assets/`
- Static files such as images, icons, and fonts used by the app.
- Assets are typically referenced in `pubspec.yaml` before use in Flutter.

### `test/`
- Automated tests for the app (unit tests and widget tests).
- Helps confirm features work correctly as the app grows.

### `pubspec.yaml`
- Project configuration file for Flutter.
- Includes:
  - App name and description
  - Dependencies
  - Asset declarations
  - Fonts (if used)

### Others (common examples)
- `.dart_tool/`, `build/`: generated files created by Flutter tools (usually not edited manually).
- `analysis_options.yaml`: lint rules and code quality settings.
- `README.md`: project documentation.

## Reflection
- A clear structure makes the project easier to maintain and understand.
- As the app grows, organizing code into folders helps scalability (adding new features without confusion).
- In teamwork, a consistent structure helps everyone find files quickly and reduces merge conflicts.

