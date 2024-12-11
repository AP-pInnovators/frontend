import 'package:http/http.dart' as http;
import 'package:namer_app/Models/answer_response.dart';
import 'package:namer_app/Models/login_response.dart';
import 'package:namer_app/Models/recommend_response.dart';
import 'dart:convert';
import 'dart:io';
import '../Models/problem_response.dart';
import '../Models/stats_response.dart';
import '../Logic/app_state.dart';

class SigmaAPI {
  bool demo = false;

  String returnBaseURL() {
    if (demo) {
      return 'http://192.168.1.17:8000/api/';
    }
    else if (Platform.isAndroid) {
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
      print("hi");
      throw Exception(e);
    }
  }

  Future<ProblemResponse> getquestion(int questionid, String? sessionKey) async {
    // check first to see if we're logged in (i.e. do we have a session key)

    var decodedQuestion = {};
    http.Response response;
    String url = returnBaseURL();

    try {
      response = await http.get(
        Uri.parse('$url''question/$questionid'),
        headers: {'Content-Type': 'application/json',
                  'Authorization':'Bearer $sessionKey'},
      );
      
      if (response.statusCode == 200) {
        decodedQuestion = jsonDecode(response.body);
        if (decodedQuestion['success']) {
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

  Future<AnswerResponse> answer(String? content, int id, String? sessionKey) async {
    var initdata = {'content': content};
    var jsondata = jsonEncode(initdata);
    var decodedAnswer = {};
    http.Response response;

    try {
      String url = returnBaseURL();

      response = await http.post(
        Uri.parse('$url''question/$id'),
        headers: {'Content-Type': 'application/json',
                  'Authorization':'Bearer $sessionKey'},
        body: jsondata,
      );

      
      if (response.statusCode == 200) {
        decodedAnswer = jsonDecode(response.body);
        if (decodedAnswer['success']) {
          print(decodedAnswer);
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
  Future<RecommendResponse> getrecommendation(String? sessionKey) async {
    http.Response response;
    var decodedRecommendation = {};

    try {
      String url = returnBaseURL();

      response = await http.get(
        Uri.parse('$url''recommendation'),
        headers: {'Content-Type': 'application/json',
                  'Authorization':'Bearer $sessionKey'},
      );

      
      if (response.statusCode == 200) {
        decodedRecommendation = jsonDecode(response.body);
        if (decodedRecommendation['success']) {
          print(decodedRecommendation);
          return RecommendResponse.fromJson(decodedRecommendation as Map<String, dynamic>);
        } else {
          // Extract and throw the error message from the response
          throw decodedRecommendation['error_message'];
        }
      } else {
        throw 'Failed to get recommendation';
      }
    } catch (e) {
      // Pass the error message to the UI
      throw Exception("Connection Refused");
    }
  }

  Future<StatsResponse> getstats(String? sessionKey) async {
    http.Response response;
    var decodedStats = {};

    try {
      String url = returnBaseURL();

      response = await http.get(
        Uri.parse('$url''stats'),
        headers: {'Content-Type': 'application/json',
                  'Authorization':'Bearer $sessionKey'},
      );

      
      if (response.statusCode == 200) {
        decodedStats = jsonDecode(response.body);
        if (decodedStats['success']) {
          print(decodedStats);
          return StatsResponse.fromJson(decodedStats as Map<String, dynamic>);
        } else {
          // Extract and throw the error message from the response
          throw decodedStats['error_message'];
        }
      } else {
        throw 'Failed to get recommendation';
      }
    } catch (e) {
      // Pass the error message to the UI
      throw Exception("Connection Refused");
    }
  }
}