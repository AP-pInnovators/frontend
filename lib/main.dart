// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Logic/app_state.dart';
import 'Pages/login_page.dart';
import 'Pages/home_page.dart';
import 'Pages/problem_page.dart';
import 'Pages/profile_page.dart';
import 'package:google_fonts/google_fonts.dart';
import '../storage.dart';

void main() {
  runApp(const MyApp());
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
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 137, 201, 253)),
          scaffoldBackgroundColor: Color.fromARGB(255, 200, 165, 223),
          fontFamily: GoogleFonts.titilliumWeb().fontFamily,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),
          '/home': (context) => HomePage(),
          '/problem': (context) => ProblemPage(),
          '/profile': (context) => ProfilePage(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/home') {
            return PageRouteBuilder(
              settings: settings, // Pass settings for named routes
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
            );
          }
          return null;
        }
      ),
    );
  }
}
