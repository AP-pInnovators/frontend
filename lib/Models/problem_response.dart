import 'api_response.dart';

class ProblemResponse extends APIResponse {
  final String content;
  final List answers;

  const ProblemResponse({
    required super.success,
    required this.content,
    required this.answers,
  });

  factory ProblemResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'success': bool success,
        'content': String content,
        'answers': List answers,
      } =>
        ProblemResponse(
          success: success,
          content: content,
          answers: answers,
        ),
      _ => throw const FormatException('Failed to load problem.'),
    };
  }
}