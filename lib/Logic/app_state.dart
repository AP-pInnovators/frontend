// lib/Logic/app_state.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class MyAppState extends ChangeNotifier {
  var decodedData = {};
  var decodedQuestion = {};

  Future<void> login(String username, String password) async {
    var initdata = {'username': username, 'password': password};
    var jsondata = jsonEncode(initdata);
    http.Response response;
    try {
      if (Platform.isAndroid) {
        response = await http.post(
          Uri.parse('http://10.0.2.2:8000/api/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsondata,
        );
      } else {
        response = await http.post(
          Uri.parse('http://127.0.0.1:8000/api/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsondata,
        );
      }
      
      if (response.statusCode == 200) {
        decodedData = jsonDecode(response.body);
        if (decodedData['success'] == true) {
          notifyListeners();
        } else {
          // Extract and throw the error message from the response
          throw decodedData['error_message'];
        }
      } else {
        throw 'Failed to login: ${response.statusCode}';
      }
    } catch (e) {
      // Pass the error message to the UI
      throw Exception(e.toString());
    }
  }
  Future<void> getquestion(int questionid) async {
    http.Response response;
    try {
      if (Platform.isAndroid) {
        response = await http.get(
          Uri.parse('http://10.0.2.2:8000/api/question/$questionid'),
          headers: {'Content-Type': 'application/json'},
        );
      } else {
        response = await http.get(
          Uri.parse('http://127.0.0.1:8000/api/question/$questionid'),
          headers: {'Content-Type': 'application/json'},
        );
      }
      if (response.statusCode == 200) {
        decodedQuestion = jsonDecode(response.body);
        if (decodedQuestion['success'] == true) {
          notifyListeners();
        }
      }
      
    } catch (e) {
      // TODO
    }
  }
  
}
