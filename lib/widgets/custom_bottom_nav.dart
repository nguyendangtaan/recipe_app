import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final String? currentRoute;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(
              Icons.home,
              color: currentIndex == 0 ? Colors.amber : Colors.grey,
            ),
            onPressed: () => onTap(0),
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              color: currentIndex == 1 ? Colors.amber : Colors.grey,
            ),
            onPressed: () => onTap(1),
          ),
          const SizedBox(width: 40),
          IconButton(
            icon: Icon(
              Icons.bookmark,
              color: (currentIndex == 3 || currentRoute == '/recipe') ? Colors.amber : Colors.grey,
            ),
            onPressed: () => onTap(3),
          ),
          IconButton(
            icon: Icon(
              Icons.person,
              color: currentIndex == 4 ? Colors.amber : Colors.grey,
            ),
            onPressed: () => onTap(4),
          ),
        ],
      ),
    );
  }
} 