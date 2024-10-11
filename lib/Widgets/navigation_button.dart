// lib/Widgets/navigation_button.dart
import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final IconData icon;

  const NavigationButton({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: ElevatedButton(
        onPressed: () {},
        child: Icon(icon, size: 50),
      ),
    );
  }
}
