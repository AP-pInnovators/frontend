// lib/Pages/profile_page.dart
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String username = "placeholder"; 
  final String aboutMe = "placeholder"; 
  final int streak = 0; 
  final int leaderboardRank = 0; 
  final double accuracy = 0; 
  final int problemsSolved = 0; 
  final String timeSpent = "placeholder"; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Screen"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        color: Colors.purple.shade100,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.purple.shade300,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    username,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  // Streak Section
                  Column(
                    children: [
                      Icon(Icons.local_fire_department,
                          color: Colors.orange, size: 30),
                      Text(
                        'Streak',
                        style: TextStyle(color: Colors.black54, fontSize: 14),
                      ),
                      Text(
                        '$streak days',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              // About Me Section
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Text(
                  aboutMe,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
              SizedBox(height: 16),
              // Statistics Section
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Statistics",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Leaderboard Ranking - #$leaderboardRank",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Text(
                      "Accuracy - ${accuracy.toStringAsFixed(1)}%",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Text(
                      "Problems Solved - $problemsSolved",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Text(
                      "Time Spent - $timeSpent",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // Placeholder for account settings
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Base Account Settings (make separate screen later)",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Logout Button
              ElevatedButton(
                onPressed: () {
                  // Add logout functionality here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Log Out functionality coming soon!")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Log Out",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Navigation Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      // Navigate to Home
                    },
                    icon: Icon(Icons.home, color: Colors.black54, size: 32),
                  ),
                  IconButton(
                    onPressed: () {
                      // Navigate to Search
                    },
                    icon: Icon(Icons.search, color: Colors.black54, size: 32),
                  ),
                  IconButton(
                    onPressed: () {
                      // Navigate to Analytics
                    },
                    icon: Icon(Icons.bar_chart, color: Colors.black54, size: 32),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}