# PetBuddy Welcome App

## Short Description
This project is a simple Flutter app that demonstrates a basic widget structure and state updates using a `StatefulWidget`. The Welcome screen shows a title, an icon, and a button that changes its text and color using `setState()`.

## Folder Structure
Inside `lib/`:
- `lib/screens/`: App screens (UI pages).  
  - `welcome_screen.dart`
- `lib/widgets/`: Reusable UI widgets.  
  - `welcome_icon.dart`
- `lib/services/`: Empty for now (reserved for future logic).  

## Setup Steps
1. Install Flutter (if not installed) and set up Android tooling (refer to Flutter official setup guide).
2. Check Flutter setup:
   - `flutter doctor`
3. Get project dependencies:
   - `flutter pub get`
4. Run the app:
   - `flutter run`

## Reflection
In this assignment, I learned:
- How Flutter builds UI using a widget tree (`MaterialApp` -> `Scaffold` -> widgets).
- How a `StatefulWidget` updates the UI immediately by calling `setState()`.
- How separating code into `screens/` and `widgets/` keeps the project clean and beginner-friendly.

## Screenshot
Add your screenshot here:

`(screenshot_placeholder.png)`

