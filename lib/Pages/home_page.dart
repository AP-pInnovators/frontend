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
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
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
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              onPressed: () {},
              child: Column(
                  children: [
                    Text("Daily Problem"),
                    Container(
                      alignment: Alignment.center,
                      width: 300,
                      height: 140,  // Set fixed width to prevent overflow
                      padding: EdgeInsets.all(8), // Add padding for better spacing
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal, // Horizontal scrolling for LaTeX
                        child: Math.tex(
                          r"""
                          \text{Let } f \text{ be the unique function defined on the positive integers such that } 
                          \sum_{d \mid n} d \cdot f\left(\frac{n}{d}\right) = 1 
                          \text{ for all positive integers } n. 
                          \text{ What is } f(2023)?
                          \quad \textbf{(A)}~-1536 
                          \quad \textbf{(B)}~96 
                          \quad \textbf{(C)}~108 
                          \quad \textbf{(D)}~116 
                          \quad \textbf{(E)}~144
                          """,
                          textStyle: TextStyle(fontSize: 16),
                           // Adjust font size for readability
                        ),
                      ),
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
