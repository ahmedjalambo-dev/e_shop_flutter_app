import 'package:e_shop_flutter_app/core/cache/shared_pref_keys.dart';
import 'package:e_shop_flutter_app/core/helpers/shared_pref_helper.dart';
import 'package:e_shop_flutter_app/core/netowoks/api_result.dart';
import 'package:e_shop_flutter_app/core/netowoks/dio_factory.dart';
import 'package:e_shop_flutter_app/features/auth/login/cubit/login_state.dart';
import 'package:e_shop_flutter_app/features/auth/login/data/models/login_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_shop_flutter_app/features/auth/login/data/models/login_request_body.dart';
import 'package:e_shop_flutter_app/features/auth/login/data/repos/login_repo.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;

  LoginCubit(this._loginRepo) : super(const LoginState.initial());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> emitLoginStates() async {
    emit(const LoginState.loading());
    
    final loginRequestBody = LoginRequestBody(
      email: emailController.text,
      password: passwordController.text,
    );
    final result = await _loginRepo.login(loginRequestBody);

    result.when(
      success: (loginResponse) {
        if (loginResponse.isSuccess) {
          emit(LoginState.success(loginResponse.accessToken!));
        } else {
          // Handle error response
          final errorMessage = loginResponse.message ?? 'Login failed';
          emit(LoginState.error(errorMessage));
        }
      },
      failure: (error) {
        emit(
          LoginState.error(error.apiErrorModel.message ?? 'An error occurred'),
        );
      },
    );
  }

  void resetState() {
    emit(const LoginState.initial());
  }

  Future<void> saveUserTokens(LoginResponse loginResponse) async {
    await SharedPrefHelper.setData(
      SharedPrefKeys.accessToken,
      loginResponse.accessToken,
    );
    DioFactory.setTokenIntoHeader(loginResponse.accessToken!);
  }
}
