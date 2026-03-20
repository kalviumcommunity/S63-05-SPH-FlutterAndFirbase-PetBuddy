# Flutter Widget Demo (Stateless + Stateful)

## StatelessWidget vs StatefulWidget
`StatelessWidget` is used when the UI does not change over time due to internal state. Its `build()` method returns widgets based only on the current inputs (like constructor values). If you need to change the displayed data, you typically create a new widget instance from the parent.

`StatefulWidget` is used when the UI depends on data that can change after the widget is created (for example, a counter). A `StatefulWidget` contains a separate `State` object. When something changes inside the `State`, you call `setState()`, which tells Flutter to rebuild the widget tree so the UI updates.

## Flutter Widget Tree and Reactive UI
Flutter builds the UI as a *widget tree*. Each widget’s `build()` method describes what the UI should look like at that moment.

This makes Flutter *reactive*: when the state changes (for example, after calling `setState()`), Flutter automatically re-runs the affected `build()` methods and updates what’s needed on the screen.

## Why Dart is suitable for Flutter
Dart is a good fit for Flutter because it provides:
- Strong, practical typing that helps catch mistakes early.
- Null safety, so non-nullable variables are handled safely.
- Fast development with JIT compilation (debug) and good performance for production builds.
- Modern language features like `async/await` for asynchronous work (useful in real apps).

## Demo App Notes (What this project shows)
- `MaterialApp` sets up the app entry and loads the main screen.
- The stateless part is `StatelessExample`, which shows a simple text UI using a `StatelessWidget`.
- The stateful part is `CounterExample`, which demonstrates a counter using a `StatefulWidget`.
- Pressing the `FloatingActionButton` increments the counter by calling `setState()`, so the centered `Text` widget updates immediately.


## Firebase Setup (Brief)
1. Create a Firebase project in the Firebase Console.
2. Add an Android app to Firebase and download `google-services.json`.
3. Place `google-services.json` here: `android/app/google-services.json`.
4. Ensure your Android `applicationId` matches the package name inside `google-services.json`.
5. Add Firebase dependencies to `pubspec.yaml` (`firebase_core`, `firebase_auth`, `cloud_firestore`).
6. Initialize Firebase in `main.dart` using `Firebase.initializeApp()`.

## Firestore Real-time Sync (How it works)
- This demo uses the Firestore collection `tasks`.
- `tasksStream` uses `.snapshots()` to create a real-time stream of documents.
- The UI uses `StreamBuilder` to listen to that stream.
- When `addTask()` adds a new document, Firestore sends updated snapshots to the stream, and `StreamBuilder` rebuilds the list automatically.

## Notes About Implementation
- Each task document stores:
  - `title`: the task text
  - `createdAt`: a server timestamp
- For real apps, you must configure Firestore Security Rules to allow the intended reads/writes.

