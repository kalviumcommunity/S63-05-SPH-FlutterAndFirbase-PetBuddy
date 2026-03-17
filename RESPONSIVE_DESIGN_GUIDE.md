# Responsive Design Implementation Guide

## Overview

This document provides a comprehensive guide to the responsive design implementation in the PetBuddy Flutter application.

---

## Table of Contents

1. [Core Concepts](#core-concepts)
2. [Device Classification](#device-classification)
3. [Responsive Components](#responsive-components)
4. [Best Practices](#best-practices)
5. [Troubleshooting](#troubleshooting)

---

## Core Concepts

### 1. **MediaQuery**

`MediaQuery` provides access to the device's physical properties and screen dimensions.

```dart
// Access screen dimensions
final screenSize = MediaQuery.of(context).size;
final screenWidth = screenSize.width;
final screenHeight = screenSize.height;

// Get device pixel ratio (screen density)
final pixelRatio = MediaQuery.of(context).devicePixelRatio;

// Check orientation
final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

// Get padding (safe area)
final padding = MediaQuery.of(context).padding;

// Get viewInsets (keyboard size, notches, etc.)
final viewInsets = MediaQuery.of(context).viewInsets;
```

### 2. **LayoutBuilder**

`LayoutBuilder` provides the constraints available to a widget, allowing dynamic layout based on actual space.

```dart
LayoutBuilder(
  builder: (BuildContext context, BoxConstraints constraints) {
    if (constraints.maxWidth > 600) {
      return horizontalLayout();
    } else {
      return verticalLayout();
    }
  },
)
```

**Key Difference from MediaQuery:**
- `MediaQuery` → Device/screen level information
- `LayoutBuilder` → Actual available space in a widget

### 3. **Flexible & Expanded Widgets**

These widgets allow child widgets to take up available space intelligently.

```dart
// Expanded - takes all available space
Expanded(
  child: Widget(),
)

// Flexible - takes available space with flex ratio
Flexible(
  flex: 2,
  child: Widget(),
)

// Example: Split 3:1 ratio
Row(
  children: [
    Flexible(flex: 3, child: Widget1()),
    Flexible(flex: 1, child: Widget2()),
  ],
)
```

### 4. **AspectRatio Widget**

Maintains a specific width-to-height ratio for child widgets.

```dart
AspectRatio(
  aspectRatio: 16 / 9,  // 16:9 video
  child: Image.network(...),
)

// Square image
AspectRatio(
  aspectRatio: 1,  // 1:1 ratio
  child: Container(),
)
```

---

## Device Classification

### Classification Strategy

**PetBuddy uses screen width breakpoints:**

| Category | Width | Use Case |
|----------|-------|----------|
| **Small Phone** | < 360px | Old Android phones |
| **Phone** | 360-600px | Most smartphones |
| **Large Phone** | 600-900px | Phablets, large phones |
| **Tablet** | 900-1200px | Small tablets (iPad mini) |
| **Large Tablet** | > 1200px | Large tablets (iPad Pro) |

### Implementation in PetBuddy

```dart
final screenWidth = MediaQuery.of(context).size.width;

// Binary classification
final bool isTablet = screenWidth > 600;

// Granular classification
DeviceType getDeviceType(double width) {
  if (width < 360) return DeviceType.smallPhone;
  if (width < 600) return DeviceType.phone;
  if (width < 900) return DeviceType.largePhone;
  if (width < 1200) return DeviceType.tablet;
  return DeviceType.largeTablet;
}
```

---

## Responsive Components

### 1. **Responsive Grid**

**Implementation in PetBuddy:**

```dart
int gridColumns = 1;
if (isTablet && screenWidth > 1200) {
  gridColumns = 3;
} else if (isTablet) {
  gridColumns = 2;
} else if (screenWidth > 400 && isLandscape) {
  gridColumns = 2;
}

GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: gridColumns,
    crossAxisSpacing: isTablet ? 16 : 12,
    mainAxisSpacing: isTablet ? 16 : 12,
    childAspectRatio: isLandscape ? 1.2 : 0.85,
  ),
  itemBuilder: (context, index) => petCard(index),
)
```

**Why This Works:**
- `crossAxisCount` adjusts grid columns (1→2→3)
- `crossAxisSpacing`/`mainAxisSpacing` scale with device type
- `childAspectRatio` adapts to portrait/landscape

### 2. **Responsive Typography**

**Implementation:**

```dart
final bool isTablet = screenWidth > 600;
final bool isLandscape = orientation == Orientation.landscape;

Text(
  'Title',
  style: TextStyle(
    fontSize: isTablet ? 28 : 24,
    fontWeight: FontWeight.bold,
  ),
)
```

**Font Size Guidelines:**
- **Phone Portrait**: 14-16 (body), 24-28 (heading)
- **Phone Landscape**: 12-14 (body), 20-24 (heading)
- **Tablet**: 16-18 (body), 28-32 (heading)

### 3. **Responsive Padding/Margins**

**Implementation:**

```dart
EdgeInsets.all(isTablet ? 20 : 12)
EdgeInsets.symmetric(
  horizontal: isTablet ? 24 : 16,
  vertical: isTablet ? 20 : 12,
)
```

**Guidelines:**
- **Phone**: 8-16 (compact spacing)
- **Tablet**: 16-24 (generous spacing)

### 4. **Responsive Button Sizing**

**Implementation:**

```dart
SizedBox(
  width: isTablet ? 140 : 100,
  height: 56,  // Material Design minimum touch target
  child: Material(
    child: InkWell(onTap: () {}),
  ),
)
```

**Touch Target Minimums (Material Design):**
- Minimum: **44×44 logical points** (56×56 recommended)

### 5. **Adaptive Text Overflow Handling**

**Problem:** Long text overflows on small screens

**Solution 1: FittedBox**
```dart
FittedBox(
  fit: BoxFit.scaleDown,
  child: Text('Siamese Cat'),
)
```

**Solution 2: Ellipsis**
```dart
Text(
  'Siamese Cat',
  overflow: TextOverflow.ellipsis,
  maxLines: 1,
)
```

**Solution 3: Wrap + Flexible**
```dart
Wrap(
  children: [
    Flexible(
      child: Text('Long text that might wrap'),
    ),
  ],
)
```

### 6. **Adaptive Footer Layout**

**Implementation in PetBuddy:**

```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth > 600) {
      // Tablet: Horizontal Row
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [...buttons],
      );
    } else {
      // Phone: Wrap (allows line breaks)
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.center,
        children: [...buttons],
      );
    }
  },
)
```

---

## Best Practices

### ✅ DO

1. **Use `MediaQuery` for app-level decisions**
   ```dart
   // Good: Device classification
   final isTablet = MediaQuery.of(context).size.width > 600;
   ```

2. **Use `LayoutBuilder` for local space decisions**
   ```dart
   // Good: Widget-level layout
   LayoutBuilder(
     builder: (context, constraints) {
       return constraints.maxWidth > 500 ? rowLayout() : columnLayout();
     },
   )
   ```

3. **Test on multiple emulators/devices**
   ```bash
   flutter emulators --launch Pixel_4a
   flutter emulators --launch Pixel_Tablet
   ```

4. **Use `Flexible` and `Expanded` for dynamic sizing**
   ```dart
   // Good: Child takes available space
   Expanded(child: GridView(...))
   ```

5. **Set FittedBox as last resort for text overflow**
   ```dart
   FittedBox(
     fit: BoxFit.scaleDown,
     child: Text('Long text'),
   )
   ```

### ❌ DON'T

1. **Don't hardcode pixel values**
   ```dart
   // Bad
   SizedBox(height: 1134)  // iPad specific
   
   // Good
   SizedBox(height: screenHeight * 0.5)
   ```

2. **Don't use device model detection**
   ```dart
   // Bad
   if (Platform.isIOS && deviceModel == 'iPad Pro') { ... }
   
   // Good
   final isTablet = screenWidth > 600;
   ```

3. **Don't skip testing on tablets**
   - Tablets expose layout bugs that phones don't

4. **Don't assume portrait-only**
   - Users rotate devices frequently

5. **Don't ignore safe areas**
   ```dart
   // Bad
   Container(padding: EdgeInsets.all(0))
   
   // Good
   SafeArea(child: Container())
   ```

---

## Troubleshooting

### Issue 1: Text Overflows on Small Screens

**Symptom:** "A RenderFlex overflowed..."

**Solutions:**
```dart
// Option 1: FittedBox
FittedBox(fit: BoxFit.scaleDown, child: Text(...))

// Option 2: Flexible
Flexible(child: Text(..., overflow: TextOverflow.ellipsis))

// Option 3: Constrain width
Container(
  width: 120,
  child: Text(..., overflow: TextOverflow.ellipsis),
)
```

### Issue 2: Buttons Too Small on Tablets

**Symptom:** Text is hard to read on large screens

**Solution:**
```dart
final buttonSize = isTablet ? 140 : 100;
SizedBox(
  width: buttonSize,
  height: 56,
  child: button,
)
```

### Issue 3: Layout Breaks in Landscape

**Symptom:** Content doesn't fit when rotated

**Solutions:**
```dart
// Option 1: Detect orientation
final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

if (isLandscape) {
  return horizontalLayout();
} else {
  return verticalLayout();
}

// Option 2: Use LayoutBuilder
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxHeight < 500) {
      return horizontalLayout();
    }
    return verticalLayout();
  },
)
```

### Issue 4: Grid Spans Incorrectly

**Symptom:** Grid items don't resize properly

**Solution:**
```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: isTablet ? 2 : 1,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
    childAspectRatio: 0.85,  // Critical for proper sizing
  ),
)
```

---

## Testing Checklist

Use this checklist to verify responsive design across devices:

### Phone (360×800) - Portrait
- [ ] Header displays without overflow
- [ ] Single column grid
- [ ] Buttons are touchable (>44×44)
- [ ] Padding looks natural
- [ ] Text is readable (14-16px)

### Phone (800×360) - Landscape
- [ ] Dual column grid (if enabled)
- [ ] Layout adapts (no overflow)
- [ ] Header compresses appropriately
- [ ] Footer buttons visible

### Tablet (820×1180) - Portrait
- [ ] Dual column grid
- [ ] Generous padding
- [ ] Larger fonts (16-18px)
- [ ] Content looks balanced

### Tablet (1280×800) - Landscape
- [ ] Triple column grid (if enabled)
- [ ] Horizontal footer layout
- [ ] Content spans full width
- [ ] Performance is smooth

---

## Performance Considerations

### 1. **Avoid Rebuilding on Every Frame**

```dart
// Bad: MediaQuery called multiple times
build(BuildContext context) {
  var size1 = MediaQuery.of(context).size;
  var size2 = MediaQuery.of(context).size;
}

// Good: Extract once
build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  // Use screenWidth multiple times
}
```

### 2. **Use `const` Constructors**

```dart
// Good: Prevents unnecessary rebuilds
const SizedBox(height: 16)
const EdgeInsets.all(8)
```

### 3. **Offload Heavy Computations**

```dart
// Extract grid column logic to top-level function
int getGridColumns(double screenWidth, bool isLandscape) {
  if (screenWidth > 1200) return 3;
  if (screenWidth > 600) return 2;
  return isLandscape ? 2 : 1;
}
```

---

## Resources

- [Flutter Responsive Design](https://flutter.dev/docs/development/ui/layouts/responsive)
- [MediaQuery API](https://api.flutter.dev/flutter/widgets/MediaQuery-class.html)
- [LayoutBuilder API](https://api.flutter.dev/flutter/widgets/LayoutBuilder-class.html)
- [Material Design Spacing](https://material.io/design/layout/responsive-layout-grid.html)
- [Touch Target Sizes](https://material.io/design/usability/accessibility.html#target-size)

---

**Last Updated:** March 17, 2026
