import 'api_response.dart';

class StatsResponse extends APIResponse {
  final int score;

  const StatsResponse({
    required super.success,
    required this.score,
  });

  factory StatsResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'success': bool success,
        'score': int score,
      } =>
        StatsResponse(
          success: success,
          score: score,
        ),
      _ => throw const FormatException('Failed to load stats'),
    };
  }
}