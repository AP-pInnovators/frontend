import 'package:flutter/material.dart';
import '../Widgets/navigation_button.dart';
import 'package:flutter_tex/flutter_tex.dart'; 
import '../Logic/app_state.dart';
import 'package:provider/provider.dart';
import '../Models/problem_response.dart';
import '../API/sigma_API.dart';
import '../Models/sigma_model.dart';

class ProblemPage extends StatefulWidget {
  @override
  State<ProblemPage> createState() => _ProblemPageState();
}

class _ProblemPageState extends State<ProblemPage> {
  final answerController = TextEditingController();
  Future<ProblemResponse>? _questionFuture;
  int? questionid;
  var myModel = SigmaModel();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _fetchQuestion()); // Fetch the question when the page is initialized
  }

  void didPushNext() {
    //update question each time the page is called
    Future.microtask(() => _fetchQuestion());
  }

  void _fetchQuestion() {
    var appState = Provider.of<MyAppState>(context, listen: false);

    setState(() {
      _questionFuture = myModel.getquestion(appState.dailyProblem); // Call your question fetching method here
    });
  }

  Future<void> _showCorrectDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Correct!"),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Congratulations, that's the correct answer!"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showWrongDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Wrong"),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Sorry, but that's not the right answer. Please try again."),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Top Row with Home Icon and Problem Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NavigationButton(icon: Icons.home, page: "home"),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
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
                              String displayString = snapshot.data!.content;
                              for (final answer in snapshot.data!.answers) {
                                String answercontent = answer["content"];
                                displayString = "$displayString"" ""$answercontent";
                              }
                              return TeXView(
                                child: TeXViewDocument(
                                  displayString,
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
                    ),
                    ]
                  ),
              SizedBox(height: 40), // Spacer between Problem title and Scratch Work
        
              // Scratch Work Section
              Expanded(
                child: Center(
                  child: Text(
                    'Scratch Work',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
        
              SizedBox(height: 40), // Spacer between Scratch Work and Answer/Submit Row
        
              // Bottom Row with Answer TextField and Submit Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 500,
                    child: TextFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(20.0),
                      filled: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                      hintText: 'Enter Answer',
                    ),
                    controller: answerController,
                  ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        var response = await myModel.answer(
                          answerController.text,
                          appState.dailyProblem,
                        );
                        if (!context.mounted) return;
                        // If login is successful
                        if (response.success) {
                          if (response.correct) {
                            await _showCorrectDialog();
                            if (!context.mounted) return;
                            Navigator.pushReplacementNamed(context, '/home');
                          }
                          else {
                            await _showWrongDialog();
                          }
                        }
                      } catch (e) {
                        if (!context.mounted) return;
                        // Catch and display the error message using a SnackBar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.toString()),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreenAccent[400], // Submit button color
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
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