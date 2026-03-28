import 'package:flutter/material.dart';

class ScrollableViewsScreen extends StatelessWidget {
  const ScrollableViewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scrollable Views')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Horizontal ListView.builder', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          
          // 1. Horizontal ListView
          SizedBox(
            height: 120, // Constrain height for the horizontal list
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 15,
              itemBuilder: (context, index) {
                return Container(
                  width: 120,
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[(index % 9 + 1) * 100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text('List Item $index', textAlign: TextAlign.center),
                  ),
                );
              },
            ),
          ),
          
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Vertical GridView.builder', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          
          // 2. Vertical GridView
          Expanded( // Take up remaining vertical space
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 items per row
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: 24,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.green[(index % 9 + 1) * 100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text('Grid Item $index'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
