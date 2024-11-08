import 'package:http/http.dart' as http;
import 'package:namer_app/Models/answer_response.dart';
import 'package:namer_app/Models/login_response.dart';
import 'dart:convert';
import 'dart:io';
import '../Models/problem_response.dart';
import '../storage.dart';

class SigmaAPI {
  var myStorage = SigmaStorage();

  String returnBaseURL() {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8000/api/';
    }
    else {
      return 'http://127.0.0.1:8000/api/';
    }
  }

  Future<LoginResponse> login(String username, String password) async {
    var initdata = {'username': username, 'password': password};
    var jsondata = jsonEncode(initdata);
    var decodedData = {};
    http.Response response;
    try {
      String url = returnBaseURL();
      response = await http.post(
          Uri.parse('$url''login'),
          headers: {'Content-Type': 'application/json'},
          body: jsondata,
        );
      
      if (response.statusCode == 200) {
        decodedData = jsonDecode(response.body);
        
        if (decodedData['success']) {
          // myStorage.writeSessionKey(decodedData['session_token']);
          return LoginResponse.fromJson(decodedData as Map<String, dynamic>);
        } else {
          // Extract and throw the error message from the response
          throw decodedData['error_message'];
        }
      } else {
        throw Exception("Failed to login");
      }
    } catch (e) {
      // Pass the error message to the UI
      throw Exception(e);
    }
  }

  Future<ProblemResponse> getquestion(int questionid) async {

    // check first to see if we're logged in (i.e. do we have a session key)
    // String? sessionKey = await myStorage.getSessionKey();
    // print(sessionKey);

    var decodedQuestion = {};
    http.Response response;
    String url = returnBaseURL();

    try {
      response = await http.get(
        Uri.parse('$url''question/$questionid'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        decodedQuestion = jsonDecode(response.body);
        if (decodedQuestion['success']) {
          print(jsonDecode(response.body));
          return ProblemResponse.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
        }
        else {
          throw decodedQuestion['error_message'];
        }
      }
      else {
        throw Exception("Failed to load");
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<AnswerResponse> answer(String answer, int id) async {
    var initdata = {'id': id, 'answer': answer};
    var jsondata = jsonEncode(initdata);
    var decodedAnswer = {};
    http.Response response;

    try {
      String url = returnBaseURL();

      response = await http.post(
        Uri.parse('$url''question/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsondata,
      );

      
      if (response.statusCode == 200) {
        decodedAnswer = jsonDecode(response.body);
        print(decodedAnswer);
        if (decodedAnswer['success']) {
          return AnswerResponse.fromJson(decodedAnswer as Map<String, dynamic>);
        } else {
          // Extract and throw the error message from the response
          throw decodedAnswer['error_message'];
        }
      } else {
        throw 'Failed to send answer';
      }
    } catch (e) {
      // Pass the error message to the UI
      throw Exception("Connection Refused");
    }
  }  
}