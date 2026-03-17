# 📋 Quick Reference Card

## Responsive Design Quick Facts

### Screen Size Breakpoints
```
📱 Phone (360-600px)       → 1 column,  12px spacing, 14-16px font
📱 Phone Landscape         → 2 columns, 12px spacing, 12-14px font  
📱 Tablet (600-1200px)     → 2 columns, 16px spacing, 16-18px font
🖥️  Large Display (>1200px) → 3 columns, 16px spacing, 16-18px font
```

### Key MediaQuery Usage
```dart
// Get screen size
final width = MediaQuery.of(context).size.width;
final height = MediaQuery.of(context).size.height;

// Check orientation
final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

// Typical classification
final isTablet = width > 600;
final isSmallPhone = width < 360;
```

### Responsive Widgets Cheat Sheet
| Widget | Purpose | When to Use |
|--------|---------|------------|
| `Expanded` | Takes all available space | Filling remaining width/height |
| `Flexible` | Takes proportional space | Share space with flex ratio |
| `AspectRatio` | Maintain aspect ratio | Images, video thumbnails |
| `FittedBox` | Scale to fit | Prevent text overflow |
| `LayoutBuilder` | React to constraints | Local layout decisions |
| `GridView` | Responsive grid | Pet cards, product listings |
| `Wrap` | Wrap items | Buttons, tags, chips |

### Common Patterns in This Project

**Pattern 1: Device Classification**
```dart
final bool isTablet = screenWidth > 600;
final int cols = isTablet ? 2 : 1;
```

**Pattern 2: Adaptive Spacing**
```dart
EdgeInsets.all(isTablet ? 20 : 12)
```

**Pattern 3: Adaptive Font**
```dart
fontSize: isTablet ? 18 : 14
```

**Pattern 4: FittedBox for Text**
```dart
FittedBox(fit: BoxFit.scaleDown, child: Text(...))
```

**Pattern 5: Adaptive Grid**
```dart
GridView(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: gridColumns,
    childAspectRatio: isLandscape ? 1.2 : 0.85,
  ),
)
```

**Pattern 6: Dual Layout (LayoutBuilder)**
```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth > 600) return rowLayout();
    else return columnLayout();
  },
)
```

---

## File Quick Reference

| File | Purpose | Key Content |
|------|---------|------------|
| **lib/main.dart** | Entry point | App config, theme, MaterialApp |
| **lib/screens/responsive_home.dart** | Main UI | All responsive layouts (550 lines) |
| **test/widget_test.dart** | Tests | Responsive layout tests |
| **pubspec.yaml** | Dependencies | Flutter packages, versions |
| **analysis_options.yaml** | Linting | Code quality rules |
| **README.md** | Overview | Project details, code snippets |
| **RESPONSIVE_DESIGN_GUIDE.md** | Technical | Deep dive into implementation |
| **TESTING_GUIDE.md** | Testing | Emulator setup, test procedures |
| **PROJECT_SUMMARY.md** | Completion | Statistics, checklist, outcomes |
| **INDEX.md** | Navigation | Quick navigation guide |

---

## Testing Quick Commands

```bash
# Setup
cd /Users/hasan/S63-05-SPH-FlutterAndFirbase-PetBuddy
flutter pub get

# Run on Android phone
flutter emulators --launch Pixel_4a
flutter run

# Run on Android tablet
flutter emulators --launch Pixel_Tablet
flutter run

# Run on iOS (from Xcode)
open -a Simulator
flutter run

# Hot reload during development
# Press: r (in terminal)

# Hot restart
# Press: R (in terminal)

# Run tests
flutter test

# Build release
flutter build apk   # Android
flutter build ios   # iOS
```

---

## Responsive Layout Decision Tree

```
Device detected via MediaQuery
    ↓
Check screen width
    ├─ < 600px → Phone layout
    │   ├─ Portrait → 1 column, compact spacing
    │   └─ Landscape → 2 columns, adjusted ratio
    │
    └─ > 600px → Tablet layout
        ├─ 600-1200px → 2 columns, generous spacing
        └─ > 1200px → 3 columns, spacious layout
```

---

## Touch Target Minimum Sizes (Material Design)

```
Minimum: 44×44 logical points
Recommended: 48×48 or 56×56 logical points

In this project:
- Buttons: 100×56 (phone), 140×56 (tablet)
- Cards: Full width, flexible height with AspectRatio
- Stats: Flexible sizing with FittedBox
```

---

## Font Size Scale

```
Phone Portrait:
  - Heading: 24-28px
  - Subheading: 16px
  - Body: 14-16px
  - Small: 10-12px

Tablet:
  - Heading: 28-32px
  - Subheading: 18px
  - Body: 16-18px
  - Small: 12-14px
```

---

## Spacing Scale

```
Phone: 8, 12, 16 (compact)
Tablet: 12, 16, 20, 24 (generous)

Grid spacing:
- Phone: 12px
- Tablet: 16px

Button padding:
- Phone: 8-12px
- Tablet: 12-16px
```

---

## Color Palette

```
Primary Colors:
- Orange 400: #FFB74D (light)
- Orange 500: #FFA726 (main)
- Orange 600: #FB8C00 (dark)

Pet Colors (6 variants):
- Gold (Retriever)
- Blue (Siamese)
- Brown (Labrador)
- Grey (Persian)
- Orange (Shepherd)
- Deep Orange (Tabby)

Neutral:
- White: #FFFFFF
- Black: #000000
- Grey 100: #F5F5F5
```

---

## Common Issues & Solutions

**Issue: Text Overflow**
```dart
// Solution
FittedBox(fit: BoxFit.scaleDown, child: Text(...))
```

**Issue: Small touch targets**
```dart
// Solution
SizedBox(width: 100, height: 56, child: button)
```

**Issue: Layout doesn't adapt**
```dart
// Solution
Use MediaQuery + LayoutBuilder + conditional logic
```

**Issue: Grid spans incorrectly**
```dart
// Solution
Set childAspectRatio appropriately (0.85-1.2)
```

**Issue: Keyboard overlaps content**
```dart
// Solution
Wrap with SafeArea() and adjust viewInsets
```

---

## Performance Tips

✅ Extract MediaQuery calls to variable
```dart
final width = MediaQuery.of(context).size.width;
```

✅ Use const constructors
```dart
const SizedBox(height: 16)
```

✅ Use LayoutBuilder for local decisions
```dart
LayoutBuilder(builder: (context, constraints) { ... })
```

✅ Avoid rebuilds on font scaling
```dart
// Store device type at build time
```

---

## Debugging Tips

```dart
// Print screen dimensions during build
print('Width: ${MediaQuery.of(context).size.width}');
print('Height: ${MediaQuery.of(context).size.height}');

// Check device classification
print('Is Tablet: $isTablet');
print('Is Landscape: $isLandscape');

// DevTools widget inspector
flutter pub global activate devtools
devtools
```

---

## Next Steps

1. **Read**: README.md (overview)
2. **Study**: RESPONSIVE_DESIGN_GUIDE.md (technical details)
3. **Run**: TESTING_GUIDE.md (set up emulators)
4. **Code**: lib/screens/responsive_home.dart (main implementation)
5. **Modify**: Experiment with breakpoints and sizes
6. **Deploy**: Build and test on real devices

---

## Success Checklist

- ✅ Code compiles without errors
- ✅ App runs on phone emulator
- ✅ App runs on tablet emulator
- ✅ Layout changes on rotation
- ✅ Text doesn't overflow
- ✅ Buttons are tappable
- ✅ Grid adjusts columns
- ✅ Footer adapts to space
- ✅ Performance is smooth
- ✅ Documentation is clear

---

**Need Help?** Check the appropriate guide:
- Overview: [README.md](README.md)
- Setup: [TESTING_GUIDE.md](TESTING_GUIDE.md)
- Technical: [RESPONSIVE_DESIGN_GUIDE.md](RESPONSIVE_DESIGN_GUIDE.md)
- Navigation: [INDEX.md](INDEX.md)

*Last Updated: March 17, 2026*
