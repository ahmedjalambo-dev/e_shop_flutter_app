import 'package:json_annotation/json_annotation.dart';

part 'verify_email_request_body.g.dart';

@JsonSerializable()
class VerifyEmailRequestBody {
  final String email;
  final String otp;

  VerifyEmailRequestBody({required this.email, required this.otp});

  Map<String, dynamic> toJson() => _$VerifyEmailRequestBodyToJson(this);
}
