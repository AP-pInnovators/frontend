import 'package:flutter/material.dart';

class Problem {
  final bool status;
  final String content;

  const Problem({
    required this.status,
    required this.content,
  });

  factory Problem.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'success': bool status,
        'content': String content,
      } =>
        Problem(
          status: status,
          content: content,
        ),
      _ => throw const FormatException('Failed to load problem.'),
    };
  }
}