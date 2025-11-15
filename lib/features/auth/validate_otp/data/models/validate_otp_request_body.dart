import 'package:json_annotation/json_annotation.dart';

part 'validate_otp_request_body.g.dart';

@JsonSerializable()
class ValidateOtpRequestBody {
  final String email;
  final String otp;

  ValidateOtpRequestBody({required this.email, required this.otp});

  Map<String, dynamic> toJson() => _$ValidateOtpRequestBodyToJson(this);
}
