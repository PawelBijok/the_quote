import 'package:either_dart/either.dart';
import 'package:the_quote/features/auth/domain/failures/auth_failure.dart';
import 'package:the_quote/features/auth/domain/models/user_model.dart';

abstract interface class AuthRepository {
  Future<Either<AuthFailure, UserModel>> singIn({
    required String email,
    required String password,
  });
  Future<Either<AuthFailure, void>> signOut();
  Future<Either<AuthFailure, UserModel>> register({
    required String email,
    required String password,
  });
  Future<Either<AuthFailure, UserModel>> signInWithGoogle();
  Future<Either<AuthFailure, UserModel>> signInWithApple();
  Future<UserModel?> autoLogin();
  Future<Either<AuthFailure, void>> resetPassword(
    String email,
  );
}
