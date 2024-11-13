import 'api_response.dart';

class LoginResponse extends APIResponse {
  final String sessionToken;
  final String tokenType;

  const LoginResponse({
    required super.success,
    required this.sessionToken,
    required this.tokenType,
  });

  @override
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'success': bool success,
        'access_token': String sessionToken,
        'token-type' : String tokenType
      } =>
        LoginResponse(
          success: success,
          sessionToken: sessionToken,
          tokenType: tokenType,
        ),
      _ => throw const FormatException('Failed to login'),
    };
  }
}