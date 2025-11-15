import 'package:e_shop_flutter_app/core/netowoks/api_result.dart';
import 'package:e_shop_flutter_app/features/auth/forgot_password/cubit/forgot_password_state.dart';
import 'package:e_shop_flutter_app/features/auth/forgot_password/data/repos/forgot_password_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordRepo _forgotPasswordRepo;
  ForgotPasswordCubit(this._forgotPasswordRepo)
    : super(const ForgotPasswordState.initial());

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  void emitForgotPasswordState() async {
    emit(const ForgotPasswordState.loading());
    final response = await _forgotPasswordRepo.forgotPassword(
      emailController.text,
    );
    response.when(
      success: (successMessage) {
        emit(ForgotPasswordState.success(successMessage));
      },
      failure: (error) {
        emit(
          ForgotPasswordState.failure(
            error.apiErrorModel.message ?? 'An error occurred',
          ),
        );
      },
    );
  }
}
