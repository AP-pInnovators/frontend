// lib/Logic/app_state.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class MyAppState extends ChangeNotifier {
  var decodedData = {};

  void login(String username, String password) async {
    var initdata = {'username': username, 'password': password};
    var jsondata = jsonEncode(initdata);

    http.Response response;

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
      String data = response.body;
      decodedData = jsonDecode(data);
    } else {
      print(response.statusCode);
    }
    notifyListeners();
  }
}
