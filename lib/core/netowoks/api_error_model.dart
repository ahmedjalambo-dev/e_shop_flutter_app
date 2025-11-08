import 'package:json_annotation/json_annotation.dart';

part 'api_error_model.g.dart';

/// Updated to match the "ProblemDetails" schema from the eshopapi--v1.JSON.
/// This model can now correctly parse error responses from the API.
@JsonSerializable()
class ApiErrorModel {
  @JsonKey(name: 'status')
  final int? statusCode;

  @JsonKey(name: 'title')
  final String? message;

  @JsonKey(name: 'detail')
  final String? detail;

  /// Used for validation errors (HttpValidationProblemDetails)
  final Map<String, List<String>>? errors;

  ApiErrorModel({
    required this.statusCode,
    required this.message,
    this.detail,
    this.errors,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);

  /// A helper to get a combined error message, prioritizing validation errors.
  String getFullErrorMessage() {
    if (errors != null && errors!.isNotEmpty) {
      // Combine all validation error messages
      return errors!.entries
          .map((e) => '${e.key}: ${e.value.join(', ')}')
          .join('\n');
    }
    return detail ?? message ?? 'An unknown error occurred.';
  }
}
