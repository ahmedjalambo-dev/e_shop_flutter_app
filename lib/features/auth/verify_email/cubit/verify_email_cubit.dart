import 'package:e_shop_flutter_app/core/netowoks/api_result.dart';
import 'package:e_shop_flutter_app/features/auth/verify_email/cubit/verify_email_state.dart';
import 'package:e_shop_flutter_app/features/auth/verify_email/data/models/verify_email_request_body.dart';
import 'package:e_shop_flutter_app/features/auth/verify_email/data/repos/verify_email_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  final VerifyEmailRepo _verifyEmailRepo;
  final String email;

  VerifyEmailCubit(this._verifyEmailRepo, this.email)
    : super(const VerifyEmailState.initial());


  Future<void> verifyEmail(String email, String otp) async {
    emit(const VerifyEmailState.loading());

    final verifyEmailRequestBody = VerifyEmailRequestBody(
      email: email,
      otp: otp,
    );

    final result = await _verifyEmailRepo.verifyEmail(verifyEmailRequestBody);

    result.when(
      success: (verifyEmailResponse) {
        if (verifyEmailResponse.isSuccess) {
          emit(
            VerifyEmailState.success(
              verifyEmailResponse.message ?? 'Email verified successfully',
            ),
          );
        } else {
          // Handle error response from API
          final errorMessage = verifyEmailResponse.allErrorMessages.isNotEmpty
              ? verifyEmailResponse.allErrorMessages.join('\n')
              : 'Email verification failed';
          emit(VerifyEmailState.error(errorMessage));
        }
      },
      failure: (error) {
        emit(
          VerifyEmailState.error(
            error.apiErrorModel.message ?? 'An error occurred',
          ),
        );
      },
    );
  }

  void resetState() {
    emit(const VerifyEmailState.initial());
  }
}
