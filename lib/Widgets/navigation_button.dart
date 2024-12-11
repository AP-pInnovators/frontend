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
          if (page == "home") {
            Navigator.pushNamed(context, '/$page');
          }
          else if (page == "profile") {
            Navigator.pushNamed(context, '/$page');
          }
          else {
            showDialog<void>(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Upcoming Feature!"),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text(page),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
        child: Icon(icon, size: 50),
      ),
    );
  }
}
