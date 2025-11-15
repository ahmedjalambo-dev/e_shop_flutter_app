import 'package:e_shop_flutter_app/core/netowoks/api_result.dart';
import 'package:e_shop_flutter_app/features/auth/validate_otp/cubit/validate_otp_state.dart';
import 'package:e_shop_flutter_app/features/auth/validate_otp/data/models/validate_otp_request_body.dart';
import 'package:e_shop_flutter_app/features/auth/validate_otp/data/repos/validate_otp_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ValidateOtpCubit extends Cubit<ValidateOtpState> {
  final ValidateOtpRepo _validateOtpRepo;
  final String email;

  ValidateOtpCubit(this._validateOtpRepo, this.email)
    : super(const ValidateOtpState.initial());

  final formKey = GlobalKey<FormState>();
  String otpCode = '';

  void emitValidateOtpState() async {
    emit(const ValidateOtpState.loading());

    final response = await _validateOtpRepo.validateOtp(
      ValidateOtpRequestBody(email: email, otp: otpCode),
    );

    response.when(
      success: (validateOtpResponse) {
        if (validateOtpResponse.isSuccess) {
          emit(
            ValidateOtpState.success(
              validateOtpResponse.message ?? 'OTP is valid.',
            ),
          );
        } else {
          // Handle error response from API
          final errorMessage = validateOtpResponse.allErrorMessages.isNotEmpty
              ? validateOtpResponse.allErrorMessages.join('\n')
              : 'OTP validation failed';
          emit(ValidateOtpState.failure(errorMessage));
        }
      },
      failure: (error) {
        emit(
          ValidateOtpState.failure(
            error.apiErrorModel.message ?? 'An error occurred',
          ),
        );
      },
    );
  }

  void resetState() {
    emit(const ValidateOtpState.initial());
  }
}
