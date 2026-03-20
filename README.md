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
