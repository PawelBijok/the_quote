import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:the_quote/core/validators/text/text_validation_error.dart';
import 'package:the_quote/core/validators/text/text_validation_option.dart';
import 'package:the_quote/core/validators/text/text_validators.dart';
import 'package:the_quote/features/auth/data/repositories/auth_repository.dart';
import 'package:the_quote/features/auth/domain/failures/auth_failure.dart';
import 'package:the_quote/features/email_base_auth/presentation/errors/continue_with_email_error.dart';

part 'continue_with_email_cubit.freezed.dart';
part 'continue_with_email_form_validation.dart';
part 'continue_with_email_state.dart';

@injectable
class ContinueWithEmailCubit extends Cubit<ContinueWithEmailState> {
  ContinueWithEmailCubit(this._textValidator, this._authRepository)
      : super(
          const ContinueWithEmailState(),
        );

  final TextValidator _textValidator;
  final AuthRepository _authRepository;

  void toggleSignInAndRegister() {
    if (state.isLoading) {
      return;
    }
    emit(state.copyWith(isSigningIn: !state.isSigningIn));
  }

  void handleEmailChange(String email) {
    final emailValidation = _textValidator(EmailTextValidation(email));
    emit(
      state.copyWith(
        email: email,
        formValidation: state.formValidation?.copyWith(email: emailValidation),
      ),
    );
  }

  void handlePasswordChange(String password) {
    final passwordValidation = _textValidator(PasswordTextValidation(password));
    emit(
      state.copyWith(
        password: password,
        formValidation: state.formValidation?.copyWith(
          password: passwordValidation,
        ),
      ),
    );
  }

  void handlePasswordConfirmationChange(String passwordConfirmation) {
    final passwordConfirmationValidation = _textValidator(
      EqualityTextValidation(
        passwordConfirmation,
        state.password,
      ),
    );

    emit(
      state.copyWith(
        passwordConfirmation: passwordConfirmation,
        formValidation: state.formValidation?.copyWith(
          passwordConfirmation: passwordConfirmationValidation,
        ),
      ),
    );
  }

  Future<void> validateAndSingInOrSignUp() async {
    if (state.isLoading) {
      return;
    }
    final formValidation = _validateForm();

    if (!formValidation.isValid) {
      return emit(
        state.copyWith(
          formValidation: formValidation,
          showFormErrors: true,
        ),
      );
    }

    emit(state.copyWith(isLoading: true));
    state.isSigningIn ? await _signIn() : await _signUp();
    emit(state.copyWith(isLoading: false));
  }

  Future<void> _signIn() async {
    final userOrFailure = await _authRepository.singIn(
      email: state.email,
      password: state.password,
    );
    userOrFailure.fold(
      _handleAuthFailure,
      (right) => emit(
        state.copyWith(success: true),
      ),
    );
  }

  Future<void> _signUp() async {
    final userOrFailure = await _authRepository.register(
      email: state.email,
      password: state.password,
    );
    userOrFailure.fold(
      _handleAuthFailure,
      (right) => emit(
        state.copyWith(success: true),
      ),
    );
  }

  void _handleAuthFailure(AuthFailure failure) {
    final error = switch (failure) {
      EmailAlreadyExistsFailure() => ContinueWithEmailError.userAlreadyExists,
      InvalidCredentialsFailure() => ContinueWithEmailError.invalidCredentials,
      NoInternetConnectionFailure() => ContinueWithEmailError.noInternet,
      UnknownFailure() => ContinueWithEmailError.unexpected,
    };
    emit(state.copyWith(error: error));
    emit(state.copyWith(error: null));
  }

  ContinueWithEmailFormValidation _validateForm() {
    final emailValidation = _textValidator(
      EmailTextValidation(state.email),
    );
    final passwordValidation = _textValidator(
      PasswordTextValidation(state.password),
    );

    final passwordConfirmationValidation = state.isSigningIn
        ? null
        : _textValidator(
            EqualityTextValidation(state.passwordConfirmation, state.password),
          );

    return ContinueWithEmailFormValidation(
      email: emailValidation,
      password: passwordValidation,
      passwordConfirmation: passwordConfirmationValidation,
    );
  }
}
