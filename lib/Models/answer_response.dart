import 'api_response.dart';

class AnswerResponse extends APIResponse {
  final bool correct;
  final int attempts, score;

  const AnswerResponse({
    required super.success,
    required this.correct,
    required this.attempts,
    required this.score,
  });

  @override
  factory AnswerResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'success': bool success,
        'correct': bool correct,
        'attempts': int attempts,
        'score': int score,
      } =>
        AnswerResponse(
          success: success,
          correct: correct,
          attempts: attempts,
          score: score,
        ),
      _ => throw const FormatException('Failed to login'),
    };
  }
}