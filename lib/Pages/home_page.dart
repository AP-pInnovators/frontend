// lib/Pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import '../Widgets/navigation_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Recommended Problem Button
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Column(
                children: [
                  Text("Recommended Problem"),
                  Container(width: 300, height: 140, alignment: Alignment.center, child: Text("Preview")),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Daily Problem Button
            ElevatedButton(
              onPressed: () {},
              child: Column(
                children: [
                  Text("Daily Problem"),
                  Container(
                    width: 300,
                    height: 140,
                    alignment: Alignment.center,
                    child: Math.tex(r'\frac{-b \pm \sqrt{b^2 - 4ac}}{2a}', mathStyle: MathStyle.display),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Navigation Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NavigationButton(icon: Icons.manage_search),
                SizedBox(width: 10),
                NavigationButton(icon: Icons.leaderboard),
                SizedBox(width: 10),
                NavigationButton(icon: Icons.account_circle),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
