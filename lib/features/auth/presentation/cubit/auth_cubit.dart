import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:the_quote/features/auth/domain/repositories/auth_repository.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

@lazySingleton
class AuthCubit extends Cubit<AuthState> with ChangeNotifier {
  AuthCubit(this.authRepository) : super(const AuthState.initial());

  final AuthRepository authRepository;

  Future<void> tryAutoLogin() async {
    final user = await authRepository.autoLogin();

    if (user == null) {
      emit(const AuthState.signedOut());
    } else {
      emit(const AuthState.signedIn());
    }
    notifyListeners();
  }

  Future<void> logout() async {
    await authRepository.signOut();
    emit(const AuthState.signedOut());
    notifyListeners();
  }
}
