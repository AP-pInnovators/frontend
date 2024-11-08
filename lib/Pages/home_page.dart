// lib/Pages/home_page.dart
import 'package:flutter/material.dart';
import '../Widgets/navigation_button.dart';
import 'package:flutter_tex/flutter_tex.dart'; 
import '../Logic/app_state.dart';
import 'package:provider/provider.dart';
import '../Models/problem_response.dart';
import 'dart:math';
import '../API/sigma_API.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   Future<ProblemResponse>? _questionFuture;
   var sigmaAPI = SigmaAPI();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _fetchQuestion()); // Fetch the question when the page is initialized
  }

  void _fetchQuestion() async {
    var appState = Provider.of<MyAppState>(context, listen: false);
    var rng = Random();
    var curr = 2;
    setState(() {
      _questionFuture = sigmaAPI.getquestion(curr); // Call your question fetching method here
    });
    await appState.updateCurrentProblem(curr);
  }


  // void didPushNext() {
  //   // This is called when the current route is pushed to the next route
  //   // If you want to refresh when going back, call _fetchQuestion here
  //   _fetchQuestion();
  // }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
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
              onPressed: () {
                Navigator.pushNamed(context, '/problem');
              },
              child: Column(
                  children: [
                    Text("Daily Problem"),
                    Container(
                      alignment: Alignment.center,
                      width: 300,
                      height: 140,  // Set fixed width to prevent overflow
                      padding: EdgeInsets.all(8), // Add padding for better spacing
                        child: FutureBuilder(
                          future: _questionFuture,  // Fetch the question
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              // Handle any errors that occurred during the fetch
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            } 
                            else if (snapshot.hasData){
                              // Display the content once loaded
                              return TeXView(
                                child: TeXViewDocument(
                                  snapshot.data!.content,
                                  style: TeXViewStyle(
                                    textAlign: TeXViewTextAlign.center,
                                  ),
                                ),
                                style: TeXViewStyle(
                                  padding: TeXViewPadding.all(5),
                                ),
                              );
                            }
                            return Center(
                                child: CircularProgressIndicator(),
                              );
                          },
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
