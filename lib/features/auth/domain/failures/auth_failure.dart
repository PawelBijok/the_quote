sealed class AuthFailure {
  AuthFailure([this.error, this.stackTrace]);

  final String? error;
  final StackTrace? stackTrace;
}

class EmailAlreadyExistsFailure extends AuthFailure {
  EmailAlreadyExistsFailure([super.error, super.stackTrace]);
}

class InvalidCredentialsFailure extends AuthFailure {
  InvalidCredentialsFailure([super.error, super.stackTrace]);
}

class UnknownFailure extends AuthFailure {
  UnknownFailure([super.error, super.stackTrace]);
}

class NoInternetConnectionFailure extends AuthFailure {
  NoInternetConnectionFailure([super.error, super.stackTrace]);
}
