import 'package:flutter/material.dart';

class ResponsiveHome extends StatefulWidget {
  const ResponsiveHome({Key? key}) : super(key: key);

  @override
  State<ResponsiveHome> createState() => _ResponsiveHomeState();
}

class _ResponsiveHomeState extends State<ResponsiveHome> {
  // Sample pet data
  final List<PetModel> pets = [
    PetModel(
      name: 'Max',
      breed: 'Golden Retriever',
      age: '2 years',
      color: Colors.amber,
      emoji: '🐕',
    ),
    PetModel(
      name: 'Luna',
      breed: 'Siamese Cat',
      age: '1 year',
      color: Colors.blue,
      emoji: '🐱',
    ),
    PetModel(
      name: 'Buddy',
      breed: 'Labrador',
      age: '3 years',
      color: Colors.brown,
      emoji: '🐕',
    ),
    PetModel(
      name: 'Whiskers',
      breed: 'Persian Cat',
      age: '2 years',
      color: Colors.grey,
      emoji: '🐱',
    ),
    PetModel(
      name: 'Rocky',
      breed: 'German Shepherd',
      age: '4 years',
      color: Colors.orange,
      emoji: '🐕',
    ),
    PetModel(
      name: 'Mittens',
      breed: 'Tabby Cat',
      age: '1 year',
      color: Colors.deepOrange,
      emoji: '🐱',
    ),
  ];

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // HEADER SECTION
            _buildHeader(screenWidth, isTablet, isLandscape),

            // MAIN CONTENT SECTION
            Expanded(
              child: _buildMainContent(
                screenWidth,
                screenHeight,
                isTablet,
                isLandscape,
                gridColumns,
              ),
            ),

            // FOOTER SECTION
            _buildFooter(screenWidth, isTablet),
          ],
        ),
      ),
    );
  }

  /// Header section with title and stats
  Widget _buildHeader(double screenWidth, bool isTablet, bool isLandscape) {
    final double headerPadding = isTablet ? 24 : 16;
    final double titleFontSize = isLandscape && isTablet ? 24 : 28;
    final double subtitleFontSize = isLandscape && isTablet ? 14 : 16;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade400, Colors.orange.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.all(headerPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'PetBuddy',
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: isLandscape ? 4 : 8),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Find your perfect companion',
                        style: TextStyle(
                          fontSize: subtitleFontSize,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '🏠',
                  style: TextStyle(fontSize: 28),
                ),
              ),
            ],
          ),
          SizedBox(height: isLandscape ? 8 : 12),
          // Stats row using Wrap for flexibility
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              _buildStatItem('6', 'Available', isLandscape),
              _buildStatItem('150+', 'Adopted', isLandscape),
              _buildStatItem('4.8★', 'Ratings', isLandscape),
            ],
          ),
        ],
      ),
    );
  }

  /// Individual stat item with flexible sizing
  Widget _buildStatItem(String value, String label, bool isLandscape) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isLandscape ? 12 : 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Main content section with pet grid/list
  Widget _buildMainContent(
    double screenWidth,
    double screenHeight,
    bool isTablet,
    bool isLandscape,
    int gridColumns,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: EdgeInsets.all(isTablet ? 20 : 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section title
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Available Pets',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              // Pet grid/list
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: gridColumns,
                    crossAxisSpacing: isTablet ? 16 : 12,
                    mainAxisSpacing: isTablet ? 16 : 12,
                    childAspectRatio: isLandscape ? 1.2 : 0.85,
                  ),
                  itemCount: pets.length,
                  itemBuilder: (context, index) {
                    return _buildPetCard(
                      pets[index],
                      screenWidth,
                      isTablet,
                      isLandscape,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Individual pet card with adaptive sizing
  Widget _buildPetCard(
    PetModel pet,
    double screenWidth,
    bool isTablet,
    bool isLandscape,
  ) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('You selected ${pet.name}!'),
            duration: const Duration(milliseconds: 800),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [
                pet.color.withOpacity(0.1),
                pet.color.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Pet emoji/image area with AspectRatio
              Flexible(
                flex: 2,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: pet.color.withOpacity(0.2),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          pet.emoji,
                          style: TextStyle(
                            fontSize: isTablet ? 60 : 48,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Pet info area
              Flexible(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(isTablet ? 12 : 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Name
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          pet.name,
                          style: TextStyle(
                            fontSize: isTablet ? 16 : 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      // Breed
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          pet.breed,
                          style: TextStyle(
                            fontSize: isTablet ? 12 : 11,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      // Age
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Age: ${pet.age}',
                          style: TextStyle(
                            fontSize: isTablet ? 11 : 10,
                            color: Colors.black45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Action button
              Flexible(
                child: Padding(
                  padding: EdgeInsets.all(isTablet ? 8 : 6),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Adopted ${pet.name}!'),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: pet.color,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Adopt',
                              style: TextStyle(
                                fontSize: isTablet ? 12 : 11,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Footer section with action buttons
  Widget _buildFooter(double screenWidth, bool isTablet) {
    // Use Wrap for responsive button layout
    final double buttonSpacing = isTablet ? 12 : 8;
    final double buttonWidth = isTablet ? 120 : 100;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
      ),
      padding: EdgeInsets.all(isTablet ? 16 : 12),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // Tablet layout - horizontal button layout
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFooterButton(
                  label: 'View All',
                  icon: Icons.list,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('View All clicked')),
                    );
                  },
                ),
                _buildFooterButton(
                  label: 'Favorites',
                  icon: Icons.favorite,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Favorites clicked')),
                    );
                  },
                ),
                _buildFooterButton(
                  label: 'My Adoption',
                  icon: Icons.pets,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('My Adoptions clicked')),
                    );
                  },
                ),
                _buildFooterButton(
                  label: 'Settings',
                  icon: Icons.settings,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Settings clicked')),
                    );
                  },
                ),
              ],
            );
          } else {
            // Phone layout - wrap buttons for better mobile UX
            return Wrap(
              spacing: buttonSpacing,
              runSpacing: buttonSpacing,
              alignment: WrapAlignment.center,
              children: [
                _buildFooterButton(
                  label: 'View All',
                  icon: Icons.list,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('View All clicked')),
                    );
                  },
                ),
                _buildFooterButton(
                  label: 'Favorites',
                  icon: Icons.favorite,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Favorites clicked')),
                    );
                  },
                ),
                _buildFooterButton(
                  label: 'My Adoption',
                  icon: Icons.pets,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('My Adoptions clicked')),
                    );
                  },
                ),
                _buildFooterButton(
                  label: 'Settings',
                  icon: Icons.settings,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Settings clicked')),
                    );
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }

  /// Individual footer button
  Widget _buildFooterButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: 100,
      height: 56,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.orange, size: 24),
              SizedBox(height: 4),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Model class for pet data
class PetModel {
  final String name;
  final String breed;
  final String age;
  final Color color;
  final String emoji;

  PetModel({
    required this.name,
    required this.breed,
    required this.age,
    required this.color,
    required this.emoji,
  });
}
