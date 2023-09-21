part of './continue_with_email_cubit.dart';

@freezed
class ContinueWithEmailFormValidation with _$ContinueWithEmailFormValidation {
  const factory ContinueWithEmailFormValidation({
    TextValidationError? email,
    TextValidationError? password,
    TextValidationError? passwordConfirmation,
  }) = _ContinueWithEmailFormValidation;

  const ContinueWithEmailFormValidation._();

  bool get isValid =>
      email == null && password == null && passwordConfirmation == null;
}
