import 'package:dio/dio.dart';
import 'package:e_shop_flutter_app/core/netowoks/api_constants.dart';
import 'package:e_shop_flutter_app/features/auth/signup/data/models/signup_request_body.dart';
import 'package:e_shop_flutter_app/features/auth/signup/data/models/signup_response.dart';
import 'package:retrofit/retrofit.dart';

part 'signup_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class SignupApiService {
  factory SignupApiService(Dio dio, {String baseUrl}) = _SignupApiService;

  @POST(ApiConstants.signup)
  Future<SignupResponse> signup(@Body() SignupRequestBody signupRequestBody);
}
