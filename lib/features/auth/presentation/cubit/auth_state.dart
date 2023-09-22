part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.signedOut() = _SignedOut;
  const factory AuthState.signedIn() = _SignedIn;
}
