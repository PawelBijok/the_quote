import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:the_quote/core/validators/text/text_validation_error.dart';
import 'package:the_quote/core/validators/text/text_validation_option.dart';
import 'package:the_quote/core/validators/text/text_validators.dart';
import 'package:the_quote/features/auth/domain/repositories/auth_repository.dart';

part 'reset_password_cubit.freezed.dart';
part 'reset_password_state.dart';

@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this._textValidator, this._authRepository) : super(const ResetPasswordState.initial());
  final TextValidator _textValidator;
  final AuthRepository _authRepository;
  void onEmailChanged(String? email) {
    if (email == null) {
      return;
    }
    final emailValidation = _textValidator(EmailTextValidation(email));
    state.mapOrNull(
      initial: (state) {
        emit(
          state.copyWith(
            email: email,
            emailValidation: emailValidation,
          ),
        );
      },
    );
  }

  Future<void> onSubmit() async {
    await state.mapOrNull(
      initial: (state) async {
        final emailValidation = _textValidator(EmailTextValidation(state.email));
        if (emailValidation != null) {
          return emit(state.copyWith(loading: false, emailValidation: emailValidation, showErrors: true));
        }
        final prevState = state;
        emit(state.copyWith(loading: true));
        final failureOrNull = await _authRepository.resetPassword(state.email);
        failureOrNull.fold(
          (_) {
            emit(const ResetPasswordState.failure());
            emit(prevState);
          },
          (right) {
            return emit(const ResetPasswordState.success());
          },
        );
      },
    );
  }
}
