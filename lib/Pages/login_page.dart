// lib/Pages/login_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Logic/app_state.dart';
import '../API/sigma_API.dart';

class LoginPage extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var sigmaAPI = SigmaAPI();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Username field
            SizedBox(
              height: 60,
              width: 450,
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20.0),
                  filled: true,
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
              width: 450,
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20.0),
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                  hintText: 'Enter Password',
                ),
                controller: passwordController,
                obscureText: true,
              ),
            ),
            SizedBox(height: 30),
            // Login Button
            ElevatedButton(
              onPressed: () async {
                try {
                  var response = await sigmaAPI.login(
                    usernameController.text,
                    passwordController.text,
                  );
                  if (!context.mounted) return;

                  // If login is successful
                  if (response.success) {
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                } catch (e) {
                  // Catch and display the error message using a SnackBar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString()),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Container(
                width: 400,
                height: 60,
                alignment: Alignment.center,
                child: Text("Login"),
              ),
            ),
            SizedBox(height: 10),
            // Google Login Button (optional)
            ElevatedButton(
              onPressed: () {
                print("hi");
              },
              child: Container(
                width: 400,
                height: 60,
                alignment: Alignment.center,
                child: Text("Google Login"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
