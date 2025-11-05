import 'package:freezed_annotation/freezed_annotation.dart';
part 'verify_email_state.freezed.dart';

@freezed
class VerifyEmailState with _$VerifyEmailState {
  const factory VerifyEmailState.initial() = _Initial;
  const factory VerifyEmailState.loading() = Loading;
  const factory VerifyEmailState.success(String message) = Success;
  const factory VerifyEmailState.error(String message) = Error;
}
