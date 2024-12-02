import 'package:namer_app/Models/recommend_response.dart';

import '../API/sigma_API.dart';
import '../storage.dart';
import 'login_response.dart';
import 'answer_response.dart';
import 'problem_response.dart';
import 'stats_response.dart';

class SigmaModel {
    var myStorage = SigmaStorage();
    var sigmaAPI = SigmaAPI();
    String? questionContent;
    int? score;
    int? currentQuestion;

    Future<LoginResponse> login(String username, String password) async {
      LoginResponse data = await sigmaAPI.login(username, password);
      myStorage.writeSessionKey(data.sessionToken);
      return data;
    }

    Future<ProblemResponse> getquestion(int questionid) async {
      String? sessionKey = await myStorage.getSessionKey();
      ProblemResponse data = await sigmaAPI.getquestion(questionid, sessionKey);
      questionContent = data.content;
      return data;
    }

    Future<AnswerResponse> answer(String content, int id) async {
      String? sessionKey = await myStorage.getSessionKey();
      AnswerResponse data = await sigmaAPI.answer(content, id, sessionKey);
      return data;
    }

    Future<RecommendResponse> getrecommendation() async {
      String? sessionKey = await myStorage.getSessionKey();
      RecommendResponse data = await sigmaAPI.getrecommendation(sessionKey);
      return data;
    }
    
    Future<StatsResponse> getstats() async {
      String? sessionKey = await myStorage.getSessionKey();
      StatsResponse data = await sigmaAPI.getstats(sessionKey);
      return data;
    }
}