import 'package:json_annotation/json_annotation.dart';

part 'validate_otp_response.g.dart';

@JsonSerializable()
class ValidateOtpResponse {
  // Success response field (when response is a plain string)
  final String? message;

  // Error response fields (when response is an object)
  final int? statusCode;
  final Map<String, List<String>>? errors;

  ValidateOtpResponse({this.message, this.statusCode, this.errors});

  // Helper method to check if the response is successful
  bool get isSuccess => message != null && statusCode == null;

  // Helper method to check if the response has errors
  bool get hasErrors => errors != null && errors!.isNotEmpty;

  // Helper method to get all error messages as a flat list
  List<String> get allErrorMessages {
    if (errors == null) return [];
    return errors!.values.expand((list) => list).toList();
  }

  // Standard fromJson for error responses
  factory ValidateOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$ValidateOtpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ValidateOtpResponseToJson(this);
}
