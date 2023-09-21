import 'package:the_quote/core/l10n/locale_keys.g.dart';

enum ContinueWithEmailError {
  userAlreadyExists,
  invalidCredentials,
  unexpected,
  noInternet,
}

extension ContinueWithEmailErrorExt on ContinueWithEmailError {
  String get toLocaleKey {
    return switch (this) {
      ContinueWithEmailError.userAlreadyExists => LocaleKeys.emailAlreadyInUse,
      ContinueWithEmailError.invalidCredentials => LocaleKeys.invalidCredentials,
      ContinueWithEmailError.unexpected => LocaleKeys.somethingWentWrong,
      ContinueWithEmailError.noInternet => LocaleKeys.noInternetConnection,
    };
  }
}
