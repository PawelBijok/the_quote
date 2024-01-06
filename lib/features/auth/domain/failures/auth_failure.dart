import 'package:easy_localization/easy_localization.dart';
import 'package:the_quote/core/l10n/locale_keys.g.dart';
import 'package:the_quote/features/auth/domain/enums/auth_provider.dart';

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

class AuthProviderFailure extends AuthFailure {
  AuthProviderFailure(this.authProvider, [super.error, super.stackTrace]);
  final AppAuthProvider authProvider;
}

extension AuthFailureExt on AuthFailure {
  String get toLocale {
    return switch (this) {
      EmailAlreadyExistsFailure() => LocaleKeys.emailAlreadyInUse.tr(),
      InvalidCredentialsFailure() => LocaleKeys.invalidCredentials.tr(),
      UnknownFailure() => LocaleKeys.somethingWentWrong.tr(),
      NoInternetConnectionFailure() => LocaleKeys.noInternetConnection.tr(),
      AuthProviderFailure() => LocaleKeys.authProviderSignInFailed.tr(
          namedArgs: {
            'authProvider': (this as AuthProviderFailure).authProvider.uiName,
          },
        ),
    };
  }
}
