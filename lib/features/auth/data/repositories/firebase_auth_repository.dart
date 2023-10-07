import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:the_quote/features/auth/domain/failures/auth_failure.dart';
import 'package:the_quote/features/auth/domain/models/user_model.dart';
import 'package:the_quote/features/auth/domain/repositories/auth_repository.dart';

@Injectable(as: AuthRepository)
class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this.firebaseAuth);

  final FirebaseAuth firebaseAuth;

  @override
  Future<Either<AuthFailure, void>> signOut() async {
    try {
      await firebaseAuth.signOut();
      return const Right(null);
    } catch (e, st) {
      return Left(UnknownFailure(e.toString(), st));
    }
  }

  @override
  Future<Either<AuthFailure, UserModel>> singIn({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = firebaseAuth.currentUser;
      if (user == null || user.email == null) {
        return Left(UnknownFailure());
      }

      final userModel = UserModel(user.email!);

      return Right(userModel);
    } on FirebaseAuthException catch (e, st) {
      return Left(InvalidCredentialsFailure(e.toString(), st));
    } on SocketException catch (e, st) {
      return Left(NoInternetConnectionFailure(e.toString(), st));
    } catch (e, st) {
      return Left(UnknownFailure(e.toString(), st));
    }
  }

  @override
  Future<Either<AuthFailure, UserModel>> register({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = firebaseAuth.currentUser;
      if (user == null || user.email == null) {
        return Left(UnknownFailure());
      }

      final userModel = UserModel(user.email!);

      return Right(userModel);
    } on FirebaseAuthException catch (e, st) {
      if (e.code == 'email-already-in-use') {
        return Left(EmailAlreadyExistsFailure(e.toString(), st));
      }
      rethrow;
    } on SocketException catch (e, st) {
      return Left(NoInternetConnectionFailure(e.toString(), st));
    } catch (e, st) {
      return Left(UnknownFailure(e.toString(), st));
    }
  }

  @override
  Future<Either<AuthFailure, UserModel>> signInWithGoogle() {
    // TODO(pafello): implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, UserModel>> signInWithApple() {
    // TODO(pafello): implement signInWithApple
    throw UnimplementedError();
  }

  @override
  Future<UserModel?> autoLogin() async {
    final user = firebaseAuth.currentUser;
    if (user == null || user.email == null) {
      return null;
    }

    final userModel = UserModel(user.email!);
    return userModel;
  }
}
