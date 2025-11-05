// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshTokenRequestBody _$RefreshTokenRequestBodyFromJson(
  Map<String, dynamic> json,
) => RefreshTokenRequestBody(
  refreshToken: json['refreshToken'] as String?,
  useCookies: json['useCookies'] as bool? ?? false,
);

Map<String, dynamic> _$RefreshTokenRequestBodyToJson(
  RefreshTokenRequestBody instance,
) => <String, dynamic>{
  'refreshToken': instance.refreshToken,
  'useCookies': instance.useCookies,
};
