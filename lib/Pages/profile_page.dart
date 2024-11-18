// lib/Pages/profile_page.dart
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String username = "JohnDoe123"; // Replace with dynamic data if available
  final String rank = "Gold Member"; // Replace with dynamic data if available

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Profile picture placeholder
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey.shade300,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 20),
            // Username
            Text(
              username,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            // Rank
            Text(
              rank,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 30),
            // Edit Profile button
            ElevatedButton(
              onPressed: () {
                // Add functionality to edit profile
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Edit Profile functionality coming soon!"),
                  ),
                );
              },
              child: Container(
                width: 200,
                height: 50,
                alignment: Alignment.center,
                    ),
                  ),
               ]  
             ),
            )
          
        );
  }
}