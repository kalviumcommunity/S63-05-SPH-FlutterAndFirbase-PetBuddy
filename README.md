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
