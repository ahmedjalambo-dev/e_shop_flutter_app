// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validate_otp_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidateOtpRequestBody _$ValidateOtpRequestBodyFromJson(
  Map<String, dynamic> json,
) => ValidateOtpRequestBody(
  email: json['email'] as String,
  otp: json['otp'] as String,
);

Map<String, dynamic> _$ValidateOtpRequestBodyToJson(
  ValidateOtpRequestBody instance,
) => <String, dynamic>{'email': instance.email, 'otp': instance.otp};
