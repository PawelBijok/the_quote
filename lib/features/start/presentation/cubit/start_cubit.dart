import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:the_quote/features/auth/domain/failures/auth_failure.dart';
import 'package:the_quote/features/auth/domain/models/user_model.dart';
import 'package:the_quote/features/auth/domain/repositories/auth_repository.dart';

part 'start_cubit.freezed.dart';
part 'start_state.dart';

@injectable
class StartCubit extends Cubit<StartState> {
  StartCubit(this.authRepository) : super(const StartState());
  final AuthRepository authRepository;
  Future<void> signInWithGoogle() async {
    emit(state.copyWith(loading: true));
    final userOrFailure = await authRepository.signInWithGoogle();
    userOrFailure.fold((f) {
      emit(state.copyWith(failure: f, loading: false));
    }, (user) {
      emit(state.copyWith(signedInUser: user, loading: false));
    });
  }

  Future<void> signInWithApple() async {
    emit(state.copyWith(loading: true));
    emit(state.copyWith(loading: false));
  }
}
