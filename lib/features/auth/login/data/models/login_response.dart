import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  // Success response fields
  final String? accessToken;
  final String? expiresAtUtc;
  final String? refreshToken;

  // Error response fields
  final int? statusCode;
  final String? message;
  final Map<String, List<String>>? errors;

  LoginResponse({
    this.accessToken,
    this.expiresAtUtc,
    this.refreshToken,
    this.statusCode,
    this.message,
    this.errors,
  });

  // Helper method to check if the response is successful
  bool get isSuccess => accessToken != null;

  // Helper method to check if the response has errors
  bool get hasErrors => errors != null && errors!.isNotEmpty;

  // Helper method to get all error messages as a flat list
  List<String> get allErrorMessages {
    if (errors == null) return [];
    return errors!.values.expand((list) => list).toList();
  }

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
