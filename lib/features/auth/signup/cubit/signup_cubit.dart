import 'package:e_shop_flutter_app/core/netowoks/api_result.dart';
import 'package:e_shop_flutter_app/features/auth/signup/cubit/signup_state.dart';
import 'package:e_shop_flutter_app/features/auth/signup/data/models/signup_request_body.dart';
import 'package:e_shop_flutter_app/features/auth/signup/data/repos/signup_repo.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupRepo _signUpRepo;
  SignupCubit(this._signUpRepo) : super(const SignupState.initial());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  void emitSignupStates() async {
    emit(const SignupState.loading());
    final response = await _signUpRepo.signup(
      SignupRequestBody(
        email: emailController.text,
        password: passwordController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
      ),
    );
    response.when(
      success: (signupResponse) => emit(SignupState.success(signupResponse)),
      failure: (error) =>
          emit(SignupState.failure(error.apiErrorModel.message ?? '')),
    );
  }
}
