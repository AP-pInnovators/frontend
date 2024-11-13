// lib/Logic/app_state.dart
import 'package:flutter/material.dart';
import '../Models/sigma_model.dart';

class MyAppState extends ChangeNotifier {
  var myModel = SigmaModel();
  var dailyProblem = 1;
  

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
