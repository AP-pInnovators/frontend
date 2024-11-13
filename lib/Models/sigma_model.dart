import '../API/sigma_API.dart';
import '../storage.dart';
import 'login_response.dart';
import 'answer_response.dart';
import 'problem_response.dart';
class SigmaModel {
    var myStorage = SigmaStorage();
    var sigmaAPI = SigmaAPI();
    String? questionContent;

    Future<void> login(String username, String password) async {
      LoginResponse data = await sigmaAPI.login(username, password);
      myStorage.writeSessionKey(data.sessionToken);
      return;
    }

    Future<void> getquestion(int questionid) async {
      String? sessionKey = await myStorage.getSessionKey();
      ProblemResponse data = await sigmaAPI.getquestion(questionid, sessionKey);
      questionContent = data.content;
      return;
    }

    Future<AnswerResponse> answer(String content, int id) async {
      String? sessionKey = await myStorage.getSessionKey();
      AnswerResponse data = await sigmaAPI.answer(content, id, sessionKey);
      return data;
    }


    
}