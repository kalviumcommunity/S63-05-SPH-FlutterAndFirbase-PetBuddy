# Quick Start Guide - Testing Responsive Layout

This guide helps you quickly test the PetBuddy app on different screen sizes and orientations.

## Prerequisites

```bash
# Install Flutter (if not already installed)
# Visit: https://flutter.dev/docs/get-started/install

# Get dependencies
cd /Users/hasan/S63-05-SPH-FlutterAndFirbase-PetBuddy
flutter pub get
```

## Running on Different Emulators

### Android Emulators

**Pixel 4a (Phone - 5.8" @ 1080×2340, 20:9 ratio)**
```bash
# List available emulators
flutter emulators

# Launch emulator
flutter emulators --launch Pixel_4a

# Once running:
flutter run

# Rotate screen:
# Windows/Linux: Ctrl + F12
# Mac: Cmd + F12
```

**Pixel Tablet (11.5" @ 2560×1600)**
```bash
flutter emulators --launch Pixel_Tablet
flutter run
```

**Pixel 6 (Phone - 6.1" @ 1080×2400)**
```bash
flutter emulators --launch Pixel_6
flutter run
```

### iOS Simulators

**iPhone 14 (Phone - 6.1")**
```bash
# Start simulator
open -a Simulator

# List simulators
xcrun simctl list devices

# Run app
flutter run -d "iPhone 14"

# Rotate screen:
# Press: Cmd + Right Arrow (landscape)
# Press: Cmd + Left Arrow (portrait)
```

**iPad Pro 11-inch (Tablet)**
```bash
# Build for iPad
flutter run -d "iPad Pro (11-inch)"

# Rotate for landscape:
# Press: Cmd + Right Arrow
```

**iPad Air (Tablet - 10.9")**
```bash
flutter run -d "iPad Air (5th generation)"
```

## Creating Custom Device Sizes

### Android Studio Method

1. **Android Studio → Device Manager**
2. **Create Virtual Device**
3. Choose desired screen size and resolution:
   - **Phone**: 5.0" (420×800) | 5.5" (480×854) | 6.0" (540×960)
   - **Tablet**: 7.0" (600×1024) | 10.0" (768×1024)

### Command Line Method

```bash
# Create 5" phone emulator
flutter emulators --launch Pixel_4a

# For custom sizes, use AVD Manager in Android Studio
```

## Test Checklist

### Screen Size: Pixel 4a (360×800) - Phone Portrait

- [ ] **Header**: "PetBuddy" text and stats visible
- [ ] **Grid**: Single column of pet cards
- [ ] **Spacing**: 12px padding looks natural
- [ ] **Text**: Font size 14-16px, readable
- [ ] **Buttons**: Footer buttons fully visible, wrapped if needed
- [ ] **Scroll**: Grid scrolls smoothly with 6 items

**Expected Layout:**
```
┌──────────────────┐
│PetBuddy          │← Header with gradient
│Stats: 6|150+|4.8 │
├──────────────────┤
│Available Pets    │← Title
├──────────────────┤
│ ┌──────────────┐ │
│ │  🐕 (emoji)  │ │
│ │Max           │ │→ Single column grid
│ │Gold. Retriev │ │
│ │ [Adopt]      │ │
│ └──────────────┘ │
│ ┌──────────────┐ │
│ │  🐱          │ │
│ │  Luna        │ │
│ │ [Adopt]      │ │
│ └──────────────┘ │
├──────────────────┤
│ [V][F][A][S]     │← Footer buttons wrapped
│ [Settings]       │
└──────────────────┘
```

### Screen Size: Pixel 4a (800×360) - Phone Landscape

- [ ] **Grid**: Dual column (2 pets per row)
- [ ] **Header**: Compressed but readable
- [ ] **Footer**: Buttons in row layout (may need scroll)
- [ ] **Ratio**: `childAspectRatio: 1.2` (wider cards)
- [ ] **Performance**: Smooth scrolling

**Expected Layout:**
```
┌────────────────────────────────┐
│🏠 PetBuddy  │ Stats row  │ 4.8★ │
├────────────────────────────────┤
│ ┌──────────┐ ┌──────────┐      │
│ │   🐕     │ │   🐱     │ ← 2-col grid
│ │Max       │ │Luna      │
│ │[Adopt]   │ │[Adopt]   │
│ └──────────┘ └──────────┘
│        more cards...           │
├────────────────────────────────┤
│[View][Fav][Adopt][Settings]    │← Footer
└────────────────────────────────┘
```

### Screen Size: Pixel Tablet (1200×800) - Tablet Landscape

- [ ] **Grid**: Triple column (3 pets per row)
- [ ] **Header**: Full-width with stats
- [ ] **Footer**: Buttons evenly spaced in row
- [ ] **Spacing**: 16px between items (more generous)
- [ ] **Font**: Slightly larger (16-18px)

**Expected Layout:**
```
┌──────────────────────────────────────────────────────┐
│🏠 PetBuddy  │  6 Available  │  150+ Adopted  │ 4.8★  │
├──────────────────────────────────────────────────────┤
│Available Pets                                         │
├──────────────────────────────────────────────────────┤
│ ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐         │
│ │  🐕    │ │  🐱    │ │  🐕    │ │  🐱    │ ← 3-4 col
│ │Max     │ │Luna    │ │Buddy   │ │Whiskers│
│ │[Adopt] │ │[Adopt] │ │[Adopt] │ │[Adopt] │
│ └────────┘ └────────┘ └────────┘ └────────┘
│        more cards...                          │
├──────────────────────────────────────────────────────┤
│[View All] [Favorites] [My Adoptions] [Settings]     │
└──────────────────────────────────────────────────────┘
```

## Interactive Testing Commands

### Test in Terminal

```bash
# Navigate to project
cd /Users/hasan/S63-05-SPH-FlutterAndFirbase-PetBuddy

# Run on phone emulator
flutter run

# Run on tablet emulator with verbose output
flutter run -dPixel_Tablet -v

# Run unit tests
dart test

# Run widget tests (responsive layout tests)
flutter test
```

### Key Shortcuts While Running

| Action | Keyboard |
|--------|----------|
| **Hot Reload** | `r` |
| **Hot Restart** | `R` |
| **Quit** | `q` |
| **Verbose** | `v` |
| **Pause** | `p` |

### Manual Testing Steps

1. **Start the app on Pixel 4a**
   ```bash
   flutter emulators --launch Pixel_4a
   flutter run
   ```

2. **Test in Portrait**
   - [ ] Scroll through all 6 pets
   - [ ] Tap on a pet card - should show snackbar "You selected [name]!"
   - [ ] Tap "Adopt" button - should show adoption snackbar
   - [ ] Tap footer buttons - each should show different snackbar

3. **Rotate to Landscape** (Cmd+F12 on Mac)
   - [ ] Grid changes to 2 columns
   - [ ] Header compresses
   - [ ] Footer layout changes

4. **Switch to Pixel_Tablet**
   ```bash
   flutter run -d Pixel_Tablet
   ```
   - [ ] 2 columns in landscape
   - [ ] Larger spacing and fonts
   - [ ] More generous padding

## Responsive Design Verification

### Complete Verification Matrix

| Device | Orientation | Grid Cols | Font Size | Spacing Px | Status |
|--------|-------------|-----------|-----------|------------|--------|
| Pixel 4a | Portrait | 1 | 14-16 | 12 | ☐ Test |
| Pixel 4a | Landscape | 2 | 12-14 | 12 | ☐ Test |
| Pixel Tablet | Portrait | 2 | 16-18 | 16 | ☐ Test |
| Pixel Tablet | Landscape | 3 | 16-18 | 16 | ☐ Test |
| iPhone 14 | Portrait | 1 | 14-16 | 12 | ☐ Test |
| iPhone 14 | Landscape | 2 | 12-14 | 12 | ☐ Test |
| iPad Pro | Portrait | 2 | 16-18 | 16 | ☐ Test |
| iPad Pro | Landscape | 3 | 16-18 | 20 | ☐ Test |

## Performance checklist

- [ ] **Frame Rate**: Smooth scrolling (60 FPS on emulator)
- [ ] **Memory**: No visible memory leaks (use DevTools)
- [ ] **Load Time**: App launches in < 3 seconds
- [ ] **Grid**: 6 items load without lag

## Troubleshooting

### Problem: Emulator Won't Start
```bash
# Check installed emulators
flutter emulators

# Kill any stuck processes
killall qemu-system-x86_64

# Try again
flutter emulators --launch Pixel_4a
```

### Problem: App Crashes on Orientation Change
- Check for hardcoded widget sizes
- Ensure all `Expanded`/`Flexible` widgets are in `Row`/`Column`
- Use `LayoutBuilder` for complex layouts

### Problem: Text Overflow
- Use `FittedBox` with `fit: BoxFit.scaleDown`
- Or use `overflow: TextOverflow.ellipsis`

### Problem: GridView Doesn't Update on Orientation
- Trigger rebuild with `setState()`
- Or use `OrientationBuilder`

## Next Steps

1. ✅ Test on at least 2 different screen sizes
2. ✅ Test both portrait and landscape
3. ✅ Verify no overflow or layout issues
4. ✅ Take screenshots for documentation
5. ✅ Review the main app code in `lib/screens/responsive_home.dart`
6. ✅ Read detailed guide: `RESPONSIVE_DESIGN_GUIDE.md`

## Additional Resources

- [Flutter Device Testing](https://flutter.dev/docs/testing/debugging)
- [Android Emulator](https://developer.android.com/studio/run/emulator)
- [iOS Simulator](https://developer.apple.com/simulator/)
- [Flutter DevTools](https://flutter.dev/docs/development/tools/devtools)

---

**Happy Testing!** 🚀
