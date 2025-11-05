import 'package:json_annotation/json_annotation.dart';

part 'verify_email_response.g.dart';

@JsonSerializable()
class VerifyEmailResponse {
  // Success response field (when response is a plain string)
  final String? message;

  // Error response fields (when response is an object)
  final int? statusCode;
  final Map<String, List<String>>? errors;

  VerifyEmailResponse({this.message, this.statusCode, this.errors});

  // Helper method to check if the response is successful
  bool get isSuccess => message != null && statusCode == null;

  // Helper method to check if the response has errors
  bool get hasErrors => errors != null && errors!.isNotEmpty;

  // Helper method to get all error messages as a flat list
  List<String> get allErrorMessages {
    if (errors == null) return [];
    return errors!.values.expand((list) => list).toList();
  }

  // Custom factory to handle both string and object responses
  factory VerifyEmailResponse.fromJson(dynamic json) {
    if (json is String) {
      // Handle success response as plain string
      return VerifyEmailResponse(message: json);
    } else if (json is Map<String, dynamic>) {
      // Handle error response as object
      return _$VerifyEmailResponseFromJson(json);
    } else {
      throw const FormatException('Unexpected JSON format');
    }
  }

  Map<String, dynamic> toJson() => _$VerifyEmailResponseToJson(this);
}
