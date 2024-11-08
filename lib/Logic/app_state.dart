// lib/Logic/app_state.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import '../Models/problem_response.dart';

class MyAppState extends ChangeNotifier {
  var dailyProblem = 1;
  // var myStorage = SigmaStorage();  

  Future<void> updateCurrentProblem(int id) async {
    try {
      dailyProblem = id;
      notifyListeners();
    }
    catch (e) {
      throw Exception(e);
    }
  }
}
