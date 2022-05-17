import 'package:flutter/material.dart';

class CustomBottomBar extends StatefulWidget {
  List<BottomNavigationBarItem> items;
  int currentIndex;
  void Function(int)? onTap;
  CustomBottomBar({
    required this.items,
    required this.currentIndex,
    this.onTap,
  });

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: widget.items,
      currentIndex: widget.currentIndex,
      onTap: (newPageIndex) => widget.onTap?.call(newPageIndex),
      selectedItemColor: Color(0xFF46DAB9),
      unselectedItemColor: Colors.grey,
    );
  }
}
