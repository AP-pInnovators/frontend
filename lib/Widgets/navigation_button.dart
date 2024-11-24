// lib/Widgets/navigation_button.dart
import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final IconData icon;
  final String page;

  const NavigationButton({
    super.key,
    required this.icon,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/$page');
        },
        child: Icon(icon, size: 50),
      ),
    );
  }
}
