import 'package:flutter/material.dart';

class ResponsiveLayoutScreen extends StatelessWidget {
  const ResponsiveLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Determine screen width using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Layout'),
      ),
      body: Column(
        children: [
          // Header Section (Always consistent)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            color: Colors.blueAccent,
            child: const Text(
              'Header Section',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          
          // Content Sections (Responsive part)
          Expanded(
            child: isLargeScreen
                // Large screen: side-by-side (Row)
                ? Row(
                    children: [
                      // Left Section
                      Expanded(
                        child: Container(
                          color: Colors.lightGreen,
                          child: const Center(child: Text('Left Section', style: TextStyle(fontSize: 18))),
                        ),
                      ),
                      // Right Section
                      Expanded(
                        child: Container(
                          color: Colors.orangeAccent,
                          child: const Center(child: Text('Right Section', style: TextStyle(fontSize: 18))),
                        ),
                      ),
                    ],
                  )
                // Small screen: stacked (Column)
                : Column(
                    children: [
                      // Left (Top) Section
                      Expanded(
                        child: Container(
                          color: Colors.lightGreen,
                          width: double.infinity,
                          child: const Center(child: Text('Top Section', style: TextStyle(fontSize: 18))),
                        ),
                      ),
                      // Right (Bottom) Section
                      Expanded(
                        child: Container(
                          color: Colors.orangeAccent,
                          width: double.infinity,
                          child: const Center(child: Text('Bottom Section', style: TextStyle(fontSize: 18))),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
