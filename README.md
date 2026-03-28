# Flutter Responsive Layout Demo

## Short explanation
This project demonstrates how to build a responsive user interface in Flutter using `MediaQuery` and `Expanded` widgets along with Flexbox layouts (`Row` and `Column`).
- A static header is created using a `Container` block at the top.
- We check the available screen width using `MediaQuery.of(context).size.width`.
- If the app is opened on a larger screen (width > 600px), it lays out the two body sections horizontally side-by-side utilizing a `Row`.
- On smaller screens (width <= 600px), it stacks the exact same two section widgets vertically on top of each other utilizing a `Column`.

## Code snippet

### Controlling Layout using MediaQuery
```dart
final screenWidth = MediaQuery.of(context).size.width;
final isLargeScreen = screenWidth > 600;

return Expanded(
  child: isLargeScreen 
      ? Row(
          children: [
            Expanded(child: LeftSectionWidget()),
            Expanded(child: RightSectionWidget()),
          ],
        )
      : Column(
          children: [
            Expanded(child: TopSectionWidget()),
            Expanded(child: BottomSectionWidget()),
          ],
        ),
);
```

## Screenshot section

### Large Screen (Side-by-Side)
![Large Screen Placeholder](placeholder_large_screen.png)  
*(Shows the header at the top and the two content sections placed left-to-right using a Row)*

### Small Screen (Stacked)
![Small Screen Placeholder](placeholder_small_screen.png)  
*(Shows the header at the top and the two content sections ordered top-to-bottom using a Column)*

## Reflection
Building responsive interfaces correctly from the start is invaluable in Flutter due to its multi-platform nature (mobile, tablet, desktop, web). 
`MediaQuery` provides dynamic device-specific data to alter the widget tree cleanly, serving as a powerful structural tool. Similarly, the `Expanded` widget is crucial here because it efficiently sizes child widgets proportionally to fit available space, ensuring the UI elements fill the screen fully without overflowing off the edge.
