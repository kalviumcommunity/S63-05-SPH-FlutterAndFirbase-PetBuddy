# Flutter Core UI Components Demo

## Overview
This project contains three distinct screens demonstrating core Flutter UI concepts as requested by the assignment:
1. **Responsive Layout** mapping device width to Row/Column.
2. **Scrollable Views** managing large item quantities.
3. **User Input Form** validating user text.

---

## 1. Responsive Layout
### Short Explanation
Showcases how to make layouts adapt to screen sizes. It uses `MediaQuery` to fetch the exact device screen width. When the width exceeds 600 pixels, sections are displayed side-by-side (`Row`). Otherwise, they stack vertically (`Column`). `Expanded` widgets act as springs to proportionally stretch the views to fill out the remaining screen safely.

### Code Snippet
```dart
final isLargeScreen = MediaQuery.of(context).size.width > 600;

return Expanded(
  child: isLargeScreen 
      ? Row(children: [ Expanded(child: LeftSection()), Expanded(child: RightSection()) ])
      : Column(children: [ Expanded(child: TopSection()), Expanded(child: BottomSection()) ]),
)
```

### Screens
![Responsive Screen Layout](placeholder_responsive.png)

---

## 2. Scrollable Views
### Short Explanation
Demonstrates dealing with large collections of data. 
- **ListView.builder** is utilized for a horizontal scrolling list of dynamically generated items.
- **GridView.builder** is utilized to show an unbounded, vertically scrollable 2-column grid setup across the rest of the screen. 
Using `.builder` rather than the standard `.children` property makes scrolling extremely efficient because Flutter lazily renders only the widgets currently visible on screen.

### Code Snippet
```dart
GridView.builder(
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2, 
    crossAxisSpacing: 8, 
    mainAxisSpacing: 8
  ),
  itemCount: 24,
  itemBuilder: (context, index) => Container(child: Text('Grid Item $index')),
)
```

### Screens
![Scrollable Views Screen](placeholder_scrollable.png)

---

## 3. User Input Form
### Short Explanation
Demonstrates securely capturing and validating string input. It uses a `Form` widget paired with a `GlobalKey<FormState>` to orchestrate the validation logic over its nested `TextFormField`. If the `TextFormField` is deemed null or completely empty upon attempting to evaluate it through `_formKey.currentState!.validate()`, it will cancel the submission and display a helper error string. When valid, a temporary `SnackBar` notification flashes at the screen's bottom confirming the operation.

### Code Snippet
```dart
void _submitForm() {
  if (_formKey.currentState!.validate()) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Processing Data for ${_nameController.text}')),
    );
  }
}
```

### Screens
![User Input Form](placeholder_form.png)

---

## Reflection
Building these three core concepts forms a very solid baseline for production-ready Flutter apps. 
- **Responsiveness** prevents layout overflow errors on obscure hardware profiles, allowing true "write-once, deploy-anywhere" behavior.
- **Scrollable builders** highlight Flutter's native 60fps performance tricks; dealing with lists manually would chew up memory, whereas `.builder` methods keep the memory footprint low.
- Finally, centralizing **Forms and Form Validation** under `GlobalKey` references decreases the headache of manually watching variables and ensures reliable API payloads.

---

## 3.12 Project Structure

Understanding the Flutter project structure is essential for organizing code, managing assets, and building scalable applications. A well-structured project makes development faster, cleaner, and easier to maintain—especially when working in teams.

The **`lib/`** folder is the core of the application where all Dart code resides. It includes the main entry point (`main.dart`) along with screens, widgets, services, and models. This is where the majority of development work happens, and keeping it organized with sub-folders like `screens/`, `widgets/`, `services/`, and `models/` ensures the codebase remains clean and navigable as the project grows.

The **`android/`** folder contains all Android-specific configuration files, Gradle build scripts, and native code required to run the app on Android devices. Files like `build.gradle`, `AndroidManifest.xml`, and `google-services.json` (for Firebase) live here. Most of the time Flutter handles this folder automatically, but it may need manual edits for things like permissions, deep linking, or adding native plugins.

The **`ios/`** folder holds iOS-specific configurations and files used by Xcode to build and deploy the app on iOS devices. This includes the `Info.plist` for app metadata, the `Runner.xcworkspace` for Xcode project settings, and CocoaPods-related files for managing native iOS dependencies. Similar to the Android folder, it is largely auto-managed but may require manual changes for platform-specific features.

The **`assets/`** folder stores static resources like images, fonts, and JSON files. These must be declared in `pubspec.yaml` under the `flutter` section to be bundled with the app. Organizing assets into sub-folders (e.g., `assets/images/`, `assets/fonts/`) is a best practice that keeps things tidy and makes referencing them in code straightforward.

The **`test/`** folder includes test files for unit testing and widget testing to ensure the app functions correctly. Writing tests here helps catch bugs early, prevents regressions, and improves overall code reliability. Flutter provides a rich testing framework out of the box that supports unit tests, widget tests, and integration tests.

The **`pubspec.yaml`** file is the most important configuration file in a Flutter project. It is used to manage dependencies (external packages from pub.dev), declare assets and custom fonts, set the app version, and configure environment settings. Any package added via `flutter pub add` or manually will appear here, and running `flutter pub get` fetches them.

The **`.gitignore`** file specifies files and folders that should not be tracked by Git. This typically includes build outputs, IDE-specific files, and sensitive configuration files like API keys or Firebase credentials (`google-services.json`, `firebase_options.dart`). A proper `.gitignore` keeps the repository clean and prevents accidental leaks of sensitive data.

The **`README.md`** file contains project documentation, setup instructions, and important details for developers. It serves as the first point of reference for anyone cloning or contributing to the project, providing an overview of the app, how to set it up locally, and any other relevant information needed to get started.

**3.10**
Completed Firebase Authentication and Firestore integration (Task 3.10). Implemented user signup, login, and logout using Firebase Auth. Connected Cloud Firestore to store and retrieve user data in real time. Tested CRUD operations successfully and verified data in Firebase Console. Faced minor issues with configuration and async handling during setup.
