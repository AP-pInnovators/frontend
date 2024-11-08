import 'api_response.dart';

class LoginResponse extends APIResponse {
  final String sessionToken;

  const LoginResponse({
    required super.success,
    required this.sessionToken,
  });

  @override
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'success': bool success,
        'session_token': String sessionToken,
      } =>
        LoginResponse(
          success: success,
          sessionToken: sessionToken,
        ),
      _ => throw const FormatException('Failed to login'),
    };
  }
}