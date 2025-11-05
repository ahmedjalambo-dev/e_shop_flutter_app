import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_request_body.g.dart';

@JsonSerializable()
class RefreshTokenRequestBody {
  final String? refreshToken;
  final bool useCookies;

  RefreshTokenRequestBody({
    required this.refreshToken,
    this.useCookies = false,
  });

  Map<String, dynamic> toJson() => _$RefreshTokenRequestBodyToJson(this);
}
