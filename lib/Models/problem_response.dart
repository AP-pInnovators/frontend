import 'api_response.dart';

class ProblemResponse extends APIResponse {
  final String content;

  const ProblemResponse({
    required super.success,
    required this.content,
  });

  factory ProblemResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'success': bool success,
        'content': String content,
      } =>
        ProblemResponse(
          success: success,
          content: content,
        ),
      _ => throw const FormatException('Failed to load problem.'),
    };
  }
}