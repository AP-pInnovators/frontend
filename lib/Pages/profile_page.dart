// lib/Pages/profile_page.dart
import 'package:flutter/material.dart';
import 'package:namer_app/Pages/home_page.dart';
import '../Models/sigma_model.dart';
import '../Models/stats_response.dart';
import '../API/sigma_API.dart';
import '../Widgets/navigation_button.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var myModel = SigmaModel();
  Future<StatsResponse>? _statsFuture;

  final String aboutMe = "placeholder"; 

  final int streak = 0; 

  final int leaderboardRank = 0; 

  final double accuracy = 0; 

  final int problemsSolved = 0; 

  final String timeSpent = "placeholder"; 

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _fetchQuestion()); // Fetch the question when the page is initialized
  }

  void _fetchQuestion() async {
    setState(() {
      _statsFuture = myModel.getstats(); // Call your question fetching method here
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Screen"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: false
      ),
      body: Container(
        color: Colors.purple.shade100,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
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
                        myModel.user,
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
                            'Streak features coming soon!',
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
                        FutureBuilder(
                          future: _statsFuture, 
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              // Handle any errors that occurred during the fetch
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            } 
                            else if (snapshot.hasData){
                              // Display the content once loaded
                              return Text('Score: ' + snapshot.data!.score.toString());
                            }
                            return Center(
                                child: CircularProgressIndicator(),
                              );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  // Logout Button
                  ElevatedButton(
                    onPressed: () async {
                      // Add logout functionality here
                      await myModel.logout();
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 35),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Log Out",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Navigation Icons
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                        onPressed: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                const begin = Offset(-1.0, 0.0); // Start off-screen to the left
                                const end = Offset.zero;        // Slide to the center
                                const curve = Curves.ease;
            
                                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                var offsetAnimation = animation.drive(tween);
            
                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        child: Icon(Icons.home, size: 50),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}