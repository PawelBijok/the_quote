part of 'continue_with_email_cubit.dart';

@freezed
class ContinueWithEmailState with _$ContinueWithEmailState {
  const factory ContinueWithEmailState({
    @Default(true) bool isSigningIn,
    @Default('') String email,
    @Default('') String password,
    @Default('') String passwordConfirmation,
    @Default(false) bool isLoading,
    @Default(false) bool showFormErrors,
    ContinueWithEmailFormValidation? formValidation,
    AuthFailure? error,
    @Default(false) bool success,
  }) = _ContinueWithEmailState;
}
