part of 'reset_password_cubit.dart';

@freezed
class ResetPasswordState with _$ResetPasswordState {
  const factory ResetPasswordState.initial({
    @Default('') String email,
    @Default(false) bool loading,
    @Default(null) TextValidationError? emailValidation,
    @Default(false) bool showErrors,
  }) = _Initial;
  const factory ResetPasswordState.failure() = _Failure;
  const factory ResetPasswordState.success() = _Success;
}
