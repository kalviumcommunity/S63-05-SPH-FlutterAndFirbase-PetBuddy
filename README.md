# Flutter Navigation Demo

## Short explanation of navigation
In Flutter, navigation is handled by the `Navigator` widget, which manages a stack of `Route` objects to display different screens.
- **Pushing** a route (`Navigator.pushNamed`) adds a new screen to the top of the stack, transitioning the user forwarding.
- **Popping** a route (`Navigator.pop`) removes the current screen from the stack, smoothly returning the user to the previous screen.
By using Named Routes configured in `main.dart`, we keep the navigation structure centralized and easy to read.

## Code snippets

### 1. Defining Routes in `main.dart`
```dart
initialRoute: '/',
routes: {
  '/': (context) => const HomeScreen(),
  '/second': (context) => const SecondScreen(),
},
```

### 2. Navigating Forward (`HomeScreen`)
```dart
Navigator.pushNamed(context, '/second');
```

### 3. Navigating Backwards (`SecondScreen`)
```dart
Navigator.pop(context);
```

## Screenshot section

### Home Screen
![Home Screen Placeholder](placeholder_home_screen.png)  
*(Shows the Home screen with "Go to Second Screen" button)*

### Second Screen
![Second Screen Placeholder](placeholder_second_screen.png)  
*(Shows the Second screen with "Go Back" button)*

## Reflection
Using named routes (`initialRoute` and `routes`) provides a very organized way to handle application navigation compared to defining routes on the fly within the screens themselves. 
Because the routes are centralized in `main.dart`, the flow of the application is immediately visible to anyone reading the main application entry point. Furthermore, using `Navigator.pushNamed()` decouples screens from one another: `HomeScreen` doesn't need to import `SecondScreen` to navigate to it; it only needs to know the route string (`'/second'`). This keeps the code clean and strictly modular.
