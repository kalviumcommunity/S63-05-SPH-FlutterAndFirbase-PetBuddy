# PetBuddy - Responsive Layout Design

## Project Overview

**PetBuddy** is a Flutter application demonstrating advanced responsive design principles. The app features a pet adoption platform with a layout that seamlessly adapts across **phones, tablets, and different orientations** (portrait and landscape).

### Key Features

- ✅ **Header Section**: Dynamic gradient header with branding and statistics
- ✅ **Responsive Grid**: Adapts from 1 column (phone) → 2 columns (tablet) → 3 columns (large displays)
- ✅ **Adaptive Widgets**: Uses `Expanded`, `Flexible`, `AspectRatio`, `FittedBox`, and `LayoutBuilder`
- ✅ **Touch-Friendly UI**: Buttons and cards adjust sizes for all devices
- ✅ **Landscape Support**: Layout optimizes for landscape orientation
- ✅ **Footer Navigation**: Dynamic button layout using `Wrap` and `Row`

---

## Implementation Details

### 1. MediaQuery for Device Detection

The app uses `MediaQuery` to determine device type and orientation:

```dart
// Get device dimensions
final double screenWidth = MediaQuery.of(context).size.width;
final double screenHeight = MediaQuery.of(context).size.height;
final Orientation orientation = MediaQuery.of(context).orientation;

// Determine if device is tablet or phone
final bool isTablet = screenWidth > 600;
final bool isLandscape = orientation == Orientation.landscape;

// Calculate grid columns based on device size
int gridColumns = 1;
if (isTablet && screenWidth > 1200) {
  gridColumns = 3;
} else if (isTablet) {
  gridColumns = 2;
} else if (screenWidth > 400 && isLandscape) {
  gridColumns = 2;
}
```

**What this does:**
- Detects screen width to differentiate between phone (< 600px) and tablet (> 600px)
- Checks orientation for landscape/portrait mode
- Dynamically sets grid columns (1, 2, or 3) based on available space

---

### 2. LayoutBuilder for Flexible Layouts

The footer uses `LayoutBuilder` to create adaptive button layouts:

```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth > 600) {
      // Tablet layout - horizontal button layout
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [/* buttons */],
      );
    } else {
      // Phone layout - wrap buttons for better mobile UX
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.center,
        children: [/* buttons */],
      );
    }
  },
)
```

**Benefits:**
- Responds to actual available space, not just device class
- Uses `Row` for wide screens (horizontal layout)
- Uses `Wrap` for narrow screens (organized wrapping)

---

### 3. Responsive Widgets in Action

#### AspectRatio for Pet Cards
```dart
AspectRatio(
  aspectRatio: 1,
  child: Container(
    decoration: BoxDecoration(
      color: pet.color.withOpacity(0.2),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Center(
      child: Text(pet.emoji, style: TextStyle(fontSize: isTablet ? 60 : 48)),
    ),
  ),
)
```
- Maintains consistent image/emoji proportions across devices
- Font size scales: **60px on tablets**, **48px on phones**

#### FittedBox for Text Scaling
```dart
FittedBox(
  fit: BoxFit.scaleDown,
  child: Text(
    'PetBuddy',
    style: TextStyle(fontSize: titleFontSize),
  ),
)
```
- Prevents text overflow by scaling down if needed
- Maintains readability on all screen sizes

#### Flexible & Expanded for Space Distribution
```dart
Expanded(
  child: GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: gridColumns,  // 1, 2, or 3 based on screen size
      crossAxisSpacing: isTablet ? 16 : 12,
      mainAxisSpacing: isTablet ? 16 : 12,
      childAspectRatio: isLandscape ? 1.2 : 0.85,
    ),
    // ...
  ),
)
```
- `Expanded` takes available space in the Column
- `GridView` columns change dynamically
- `childAspectRatio` adjusts for landscape mode

#### Wrap for Dynamic Wrapping
```dart
Wrap(
  spacing: 16,
  runSpacing: 8,
  children: [
    _buildStatItem('6', 'Available', isLandscape),
    _buildStatItem('150+', 'Adopted', isLandscape),
    _buildStatItem('4.8★', 'Ratings', isLandscape),
  ],
)
```
- Automatically wraps items to next line if insufficient space
- Maintains consistent spacing

---

## Responsive Breakpoints

| Device Type | Screen Width | Grid Columns | Layout |
|-------------|-------------|------------|--------|
| Phone      | < 400px     | 1          | Single column |
| Phone      | 400-600px   | 1 (2 in landscape) | Single/dual column |
| Tablet     | 600-1200px  | 2          | Dual column |
| Large Display | > 1200px | 3          | Triple column |

---

## File Structure

```
lib/
├── main.dart                    # App entry point
└── screens/
    └── responsive_home.dart     # Responsive layout screen
```

---

## Testing Instructions

### Prerequisites
```bash
flutter pub get
```

### Running on Different Devices

#### Android Emulators
```bash
# Pixel 4a (Phone - 5.8" display)
flutter emulators --launch Pixel_4a

# Pixel Tablet (Tablet - 11.5" display)
flutter emulators --launch Pixel_Tablet

# Once emulator is running:
flutter run -d emulator-5554
```

#### iOS Simulators
```bash
# iPhone 14 (Phone)
open -a Simulator
xcrun simctl bootWithOptions com.apple.CoreSimulator.SimDeviceType.iPhone-14

# iPad Pro (Tablet)
xcrun simctl bootWithOptions com.apple.CoreSimulator.SimDeviceType.iPad-Pro

# Then run:
flutter run -d "iPhone 14"
```

#### Physical Devices
```bash
# List connected devices
flutter devices

# Run on specific device
flutter run -d <device-id>
```

### Testing Orientation Changes

**Android:**
- Use `Ctrl + F12` (or `Cmd + F12` on Mac) to rotate emulator

**iOS:**
- Press `Cmd + →` or `Cmd + ←` to rotate

**Physical Device:**
- Enable rotation lock OFF and rotate the device

### Verification Checklist

- [ ] **Phone Portrait**: Single column grid, full-width buttons
- [ ] **Phone Landscape**: Dual column grid, horizontal button layout
- [ ] **Tablet Portrait**: Dual column grid, spread-out buttons
- [ ] **Tablet Landscape**: Triple column grid (if > 1200px), full row of buttons
- [ ] **Text Scaling**: No overflow, readable on all devices
- [ ] **Button Responsiveness**: Tap areas are finger-friendly (>44x44pts)
- [ ] **Spacing**: Padding adjusts based on device (12px phone, 16-20px tablet)
- [ ] **Images/Emojis**: Proportional sizing across devices
- [ ] **Performance**: Smooth scrolling in grid view on all devices

---

## Example Screenshots

### Phone (Portrait - 360x800)
```
┌─────────────────────┐
│ 🏠 PetBuddy         │  ← Header with gradient
│ Find companion      │     Stats: 6 | 150+ | 4.8★
├─────────────────────┤
│ Available Pets      │  ← Title
├─────────────────────┤
│ ┌───────────────┐   │
│ │   🐕          │   │  ← Single column grid
│ │ Max           │   │
│ │ Golden Ret.   │   │
│ │ [  Adopt  ]   │   │
│ └───────────────┘   │
│ ┌───────────────┐   │
│ │   🐱          │   │
│ │ Luna          │   │
│ │ Siamese Cat   │   │
│ │ [  Adopt  ]   │   │
│ └───────────────┘   │
├─────────────────────┤
│ [View][Fav][Adopt]  │  ← Wrapped footer buttons
│ [Settings]          │
└─────────────────────┘
```

### Tablet (Landscape - 1280x800)
```
┌────────────────────────────────────────────────────────────┐
│ 🏠 PetBuddy  |  6 Available  |  150+ Adopted  |  4.8★ Rating│  ← Header
├────────────────────────────────────────────────────────────┤
│ Available Pets                                             │
├────────────────────────────────────────────────────────────┤
│ ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐       │
│ │    🐕    │ │    🐱    │ │    🐕    │ │    🐱    │ ← 3-4 col grid
│ │  Max     │ │  Luna    │ │  Buddy   │ │  Whiskers│
│ │[Adopt]   │ │[Adopt]   │ │[Adopt]   │ │[Adopt]   │
│ └──────────┘ └──────────┘ └──────────┘ └──────────┘
├────────────────────────────────────────────────────────────┤
│ [View All] [Favorites] [My Adoption] [Settings]            │  ← Row footer
└────────────────────────────────────────────────────────────┘
```

---

## Challenges & Solutions

### Challenge 1: Text Overflow on Small Screens
**Problem:** Long text like "Siamese Cat" overflows on narrow cards.

**Solution:** Used `FittedBox` with `fit: BoxFit.scaleDown`
```dart
FittedBox(
  fit: BoxFit.scaleDown,
  child: Text('Siamese Cat'),
)
```
This scales down the text proportionally if it doesn't fit, maintaining hierarchy.

### Challenge 2: Maintaining Touch Target Sizes
**Problem:** Buttons too small on phones in landscape mode.

**Solution:** Set minimum size constraints and use `LayoutBuilder`:
```dart
SizedBox(
  width: 100,
  height: 56,  // Minimum 56pt height (Material Design guideline)
  child: /* button content */
)
```

### Challenge 3: Grid Item Dimensions on Different Aspect Ratios
**Problem:** Cards look stretched on tablets, squished on phones.

**Solution:** Adjust `childAspectRatio` based on orientation:
```dart
childAspectRatio: isLandscape ? 1.2 : 0.85,
```
- **Landscape**: Wider cards (1.2:1)
- **Portrait**: Taller cards (0.85:1)

### Challenge 4: Footer Button Layout Wrapping
**Problem:** Footer buttons wouldn't wrap nicely on medium-sized phones.

**Solution:** Use `LayoutBuilder` + `Wrap` + `Row` combination:
- On phones: `Wrap` (allows wrapping to multiple lines)
- On tablets: `Row` (horizontal layout)

---

## Responsive Design Principles Used

### 1. **Mobile-First Approach**
- Default layout designed for phones
- Enhanced progressively for larger screens
- Uses `> 600px` threshold for tablet detection

### 2. **Flexible Spacing**
```dart
EdgeInsets.all(isTablet ? 20 : 12)  // Adapts padding
crossAxisSpacing: isTablet ? 16 : 12  // Adapts grid spacing
```

### 3. **Content-Driven Breakpoints**
- Breakpoints based on content fit, not device models
- Uses `LayoutBuilder` to respond to actual space
- Avoids hardcoding specific device dimensions

### 4. **Adaptive Typography**
```dart
fontSize: isTablet ? 16 : 14,
fontSize: isLandscape ? 24 : 28,
```

### 5. **Image/Emoji Scaling**
```dart
fontSize: isTablet ? 60 : 48,  // 25% larger on tablets
childAspectRatio: isLandscape ? 1.2 : 0.85,  // Aspect adjusts
```

---

## How Responsive Design Improves UX

### 🎯 Accessibility
- **Larger touch targets** on phones (easier for small hands)
- **Readable text** at native resolution on all devices
- **Proper spacing** prevents accidental mis-taps

### 📱 Multi-Device Support
- **One codebase** serves all screen sizes
- **No overflow** or clipping on any device
- **Consistent branding** across platforms

### 🚀 Performance
- **Single app** instead of multiple device-specific versions
- **Efficient space usage** maximizes content visibility
- **Fewer visual glitches** from hardcoded dimensions

### 😊 User Satisfaction
- **Native feel** on each device type
- **Intuitive navigation** at any screen size
- **Professional appearance** across all platforms

---

## Running the Application

### Setup
```bash
cd /path/to/S63-05-SPH-FlutterAndFirbase-PetBuddy
flutter pub get
```

### Run
```bash
flutter run
```

### Build Release
```bash
flutter build apk      # Android
flutter build ios      # iOS
```

---

## Key Takeaways

1. **MediaQuery** enables device detection and responsive breakpoints
2. **LayoutBuilder** responds to actual available space, not device class
3. **Flexible widgets** (`Expanded`, `Flexible`, `AspectRatio`, `FittedBox`) enable scalability
4. **Wrap** provides intelligent wrapping for dynamic content
5. **GridView** with dynamic `crossAxisCount` handles responsive grids
6. **Conditional logic** (ternary operators) adjusts sizing, spacing, and layout
7. **Testing across devices** is essential to catch layout issues early

---

## Resources

- [Flutter Responsive Design Guide](https://flutter.dev/docs/development/ui/layouts/responsive)
- [MediaQuery Documentation](https://api.flutter.dev/flutter/widgets/MediaQuery-class.html)
- [LayoutBuilder Documentation](https://api.flutter.dev/flutter/widgets/LayoutBuilder-class.html)
- [Material Design - Supporting Different Sizes](https://material.io/design/platform-guidance/android-bars.html#behavior)

---

## Author Notes

This project demonstrates advanced Flutter UI techniques for building apps that work beautifully on all devices. The responsive layout system is production-ready and can be adapted for other app types beyond pet adoption.

**Last Updated:** March 17, 2026
