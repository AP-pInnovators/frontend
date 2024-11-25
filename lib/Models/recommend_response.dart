import 'api_response.dart';

class RecommendResponse extends APIResponse {
  final int id;

  const RecommendResponse({
    required super.success,
    required this.id,
  });

  factory RecommendResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'success': bool success,
        'id': int id,
      } =>
        RecommendResponse(
          success: success,
          id: id,
        ),
      _ => throw const FormatException('Failed to load recommendation'),
    };
  }
}