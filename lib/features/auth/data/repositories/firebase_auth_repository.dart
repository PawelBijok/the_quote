import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:the_quote/features/auth/domain/enums/auth_provider.dart';
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
  Future<Either<AuthFailure, UserModel>> signInWithGoogle() async {
    const scopes = <String>['email'];

    final googleSignIn = GoogleSignIn(
      scopes: scopes,
    );
    try {
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final user = await _signInFromProvider(credential);
      if (user == null) {
        return Left(
          AuthProviderFailure(AppAuthProvider.apple),
        );
      }
      return Right(user);
    } catch (e, st) {
      return Left(AuthProviderFailure(AppAuthProvider.apple, e.toString(), st));
    }
  }

  Future<UserModel?> _signInFromProvider(OAuthCredential credential) async {
    try {
      final firebaseUser = await FirebaseAuth.instance.signInWithCredential(credential);
      if (firebaseUser.user?.email == null) {
        return null;
      }
      return UserModel(firebaseUser.user!.email!);
    } catch (_) {
      return null;
    }
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

  @override
  Future<Either<AuthFailure, void>> resetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return const Right(null);
    } on SocketException catch (e, st) {
      return Left(NoInternetConnectionFailure(e.toString(), st));
    } catch (e, st) {
      return Left(UnknownFailure(e.toString(), st));
    }
  }
}
