import 'package:the_quote/core/l10n/locale_keys.g.dart';

enum TextValidationError {
  empty,
  passwordTooShort,
  invalidEmailFormat,
  notEqual,
}

extension TextValidationErrorExt on TextValidationError {
  String toKey() {
    return switch (this) {
      TextValidationError.empty => LocaleKeys.thisFieldIsRequired,
      TextValidationError.passwordTooShort => LocaleKeys.passwordTooShort,
      TextValidationError.invalidEmailFormat => LocaleKeys.invalidEmail,
      TextValidationError.notEqual => LocaleKeys.fieldsNotEqual,
    };
  }
}
