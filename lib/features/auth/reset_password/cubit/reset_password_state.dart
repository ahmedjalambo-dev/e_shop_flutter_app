import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_state.freezed.dart';

@freezed
class ResetPasswordState with _$ResetPasswordState {
  const factory ResetPasswordState.initial() = _Initial;
  const factory ResetPasswordState.loading() = Loading;
  const factory ResetPasswordState.success(String message) = Success;
  const factory ResetPasswordState.failure(String message) = Failure;
}
