sealed class Failure {
  Failure([this.error, this.stackTrace]);

  final String? error;
  final StackTrace? stackTrace;
}

class NoInternetFailure extends Failure {
  NoInternetFailure([super.error, super.stackTrace]);
}

class UnknownFailure extends Failure {
  UnknownFailure([super.error, super.stackTrace]);
}
