import 'package:flutter/material.dart';

/// A responsive screen that adapts between phone and tablet layouts.
///
/// Responsiveness requirements implemented:
/// - Uses `MediaQuery` to detect screen width/height and orientation.
/// - If `width > 600`, it uses a multi-column layout (tablet).
/// - Otherwise it uses a single-column layout (phone).
/// - Works in both portrait and landscape (grid cross-axis adapts).
class ResponsiveHome extends StatelessWidget {
  const ResponsiveHome({super.key});

  @override
  Widget build(BuildContext context) {
    // MediaQuery provides screen size + orientation.
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final orientation = MediaQuery.of(context).orientation;

    // Responsive logic:
    // - Tablet layout for wider screens.
    final isTablet = width > 600;

    // Use landscape to slightly adjust grid density.
    final isLandscape = orientation == Orientation.landscape;

    // Simple “card” header content that stays flexible.
    Widget buildHero() {
      // Use AspectRatio to prevent overflow and keep consistent proportions.
      return AspectRatio(
        aspectRatio: isLandscape ? 16 / 9 : 3 / 2,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.pets, size: 64),
                SizedBox(height: 8),
                Text(
                  'PetBuddy Dashboard',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Common “features” data used by both layouts.
    final features = const <String>[
      'Track',
      'Manage',
      'Care',
      'Remind',
      'Help',
      'Support',
      'Schedule',
      'Health',
    ];

    // Tablet (multi-column) layout:
    // - Left panel: hero + short text
    // - Right panel: grid of feature tiles
    if (isTablet) {
      final crossAxisCount = isLandscape ? 4 : 3;

      return Scaffold(
        appBar: AppBar(
          title: const Text('Responsive Home'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Multi-column Row layout
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left panel expands based on available space.
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          buildHero(),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Screen size: ${width.toStringAsFixed(0)} x ${height.toStringAsFixed(0)}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'This tablet layout uses a Row + GridView so content can expand without overflow.',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Right panel grid expands to fill remaining space.
                    Expanded(
                      flex: 3,
                      child: GridView.builder(
                        // Grid inside scroll view: use shrinkWrap + disable its own scrolling.
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: features.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.0,
                        ),
                        itemBuilder: (context, index) {
                          return _FeatureTile(
                            label: features[index],
                            icon: _featureIcon(index),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _BottomButton(
          label: 'Open Features',
          // The bottom button section is required.
        ),
      );
    }

    // Phone (single-column) layout:
    // - Uses Column layout + Wrap for features so it adapts naturally.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Home'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              buildHero(),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Phone layout (single column).',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Uses MediaQuery width threshold (600) to switch layouts.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Wrap helps avoid overflow by flowing chips into new lines.
              Row(
                children: [
                  const Text('Quick actions:'),
                  const Spacer(),
                  // Flexible used here to avoid overflow in small widths.
                  Flexible(
                    child: Text(
                      isLandscape ? 'Landscape' : 'Portrait',
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(features.length, (index) {
                  return ActionChip(
                    avatar: Icon(_featureIcon(index), size: 18),
                    label: Text(features[index]),
                    onPressed: () {
                      // No extra feature logic: this is just a UI element.
                    },
                  );
                }),
              ),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _BottomButton(
        label: 'Get Started',
      ),
    );
  }

  // Keeps icon mapping inside this file (simple beginner-friendly).
  static IconData _featureIcon(int index) {
    const icons = <IconData>[
      Icons.track_changes,
      Icons.dashboard_customize,
      Icons.local_hospital,
      Icons.notifications_active,
      Icons.help_outline,
      Icons.support_agent,
      Icons.calendar_month,
      Icons.healing,
    ];
    return icons[index % icons.length];
  }
}

class _FeatureTile extends StatelessWidget {
  final String label;
  final IconData icon;

  const _FeatureTile({
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // AspectRatio here ensures each tile stays consistent across sizes.
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 34, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomButton extends StatelessWidget {
  final String label;

  const _BottomButton({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // No extra logic required for the assignment.
            },
            child: Text(label),
          ),
        ),
      ),
    );
  }
}

