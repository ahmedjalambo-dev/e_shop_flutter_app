import 'package:freezed_annotation/freezed_annotation.dart';

part 'validate_otp_state.freezed.dart';

@freezed
class ValidateOtpState with _$ValidateOtpState {
  const factory ValidateOtpState.initial() = _Initial;
  const factory ValidateOtpState.loading() = Loading;
  const factory ValidateOtpState.success(String message) = Success;
  const factory ValidateOtpState.failure(String message) = Failure;
}
