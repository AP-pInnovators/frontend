import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
void main() {
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'SigmaTheta',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 137, 201, 253)),
          scaffoldBackgroundColor: const Color.fromARGB(255, 159, 193, 233),
        ),
        home: LoginPage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var decodedData = {};

  void getData() async {
    http.Response response = await http.get(Uri.parse('http://127.0.0.1:8000/api'));
    if (response.statusCode == 200) {
      String data = response.body;
      decodedData = jsonDecode(data);
      print(decodedData);
    } else {
      print(response.statusCode);
    }
    notifyListeners();
  }
  
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                  )
                ),
                onPressed: () {
                  print("hi");
                },
                child: Column(
                  children: [
                    Text("Recommended Problem"),
                    Container(
                      width: 300,
                      height: 140,
                      alignment: Alignment.center,
                      child: Text("Preview")
                    )
                  ],
                )
              ),
            SizedBox(height:20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                  )
                ),
                onPressed: () {
                  print("hi");
                },
                child: Column(
                  children: [
                    Text("Daily Problem"),
                    Container(
                      width: 300,
                      height: 140,
                      alignment: Alignment.center,
                      child: Text("Preview")
                    )
                  ],
                )
              ),
            SizedBox(height:20),
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

class LoginPage extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var data = appState.decodedData;

    return Scaffold(body: 
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(                
                height: 60,
                width: 350,
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                    hintText: 'Enter Username',              
                  ),
                  controller: usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  }
                ),
              ),
              SizedBox(height:10),
              SizedBox(                
                height: 60,
                width: 350,
                child:  TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                    hintText: 'Enter Password',              
                  ),
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
              ),

              SizedBox(height:10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)
                    )
                  ),
                onPressed: () {
                    appState.getData();
                    if (data[usernameController.text] == passwordController.text) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage()
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Invalid Credentials')),
                          );
                      }
                    },
                  
                child: Container(
                  width:300,
                  height:60,
                  alignment:Alignment.center,
                  child: Text("Login")
                )
              ),

              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)
                    )
                  ),
                onPressed: () {
                    print("hi");
                  },
                child: Container(
                  width:300,
                  height:60,
                  alignment:Alignment.center,
                  child: Text("Google Login")
                )
              )
            ],
          ),
        )
    );
  }
}



class NavigationButton extends StatelessWidget {
  const NavigationButton({
    super.key,
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:100,
      height:100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
          )
        ),
        onPressed: () {
          print("hi");
        },
        child: Icon(icon, size:50),
      ),
    );
  }
}