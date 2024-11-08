import 'api_response.dart';

class AnswerResponse extends APIResponse {
  final bool correct;

  const AnswerResponse({
    required super.success,
    required this.correct,
  });

  @override
  factory AnswerResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'success': bool success,
        'correct': bool correct,
      } =>
        AnswerResponse(
          success: success,
          correct: correct,
        ),
      _ => throw const FormatException('Failed to login'),
    };
  }
}