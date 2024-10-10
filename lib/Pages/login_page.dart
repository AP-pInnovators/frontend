// lib/Pages/login_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Logic/app_state.dart';

class LoginPage extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Username field
            SizedBox(
              height: 60,
              width: 350,
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                  hintText: 'Enter Username',
                ),
                controller: usernameController,
              ),
            ),
            SizedBox(height: 10),
            // Password field
            SizedBox(
              height: 60,
              width: 350,
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                  hintText: 'Enter Password',
                ),
                controller: passwordController,
                obscureText: true,
              ),
            ),
            SizedBox(height: 10),
            // Login Button
            ElevatedButton(
              onPressed: () {
                appState.login(usernameController.text, passwordController.text);
                Future.delayed(Duration(milliseconds: 100), () {
                  if (!context.mounted) return;
                  if (appState.decodedData["success"] == "true") {
                    Navigator.pushReplacementNamed(context, '/home');
                  } 
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Invalid Credentials")),
                    );
                  }
                });
              },
              child: Container(
                width: 300,
                height: 60,
                alignment: Alignment.center,
                child: Text("Login"),
              ),
            ),
            // Google Login Button (optional)
          ],
        ),
      ),
    );
  }
}
