// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validate_otp_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidateOtpResponse _$ValidateOtpResponseFromJson(Map<String, dynamic> json) =>
    ValidateOtpResponse(
      message: json['message'] as String?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
      errors: (json['errors'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
    );

Map<String, dynamic> _$ValidateOtpResponseToJson(
  ValidateOtpResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'statusCode': instance.statusCode,
  'errors': instance.errors,
};
