import 'package:injectable/injectable.dart';
import 'package:the_quote/core/constants/business_constants.dart';
import 'package:the_quote/core/validators/text/text_validation_error.dart';
import 'package:the_quote/core/validators/text/text_validation_option.dart';

@injectable
class TextValidator {
  TextValidationError? call(
    TextValidationOption option,
  ) {
    return switch (option) {
      final NotEmptyTextValidation o => _NotEmptyValidator().validate(o.text),
      final EmailTextValidation o => _EmailValidator().validate(o.text),
      final PasswordTextValidation o => _PasswordValidator().validate(o.text),
      final EqualityTextValidation o =>
        _EqualityValidator().validate(o.text, o.compareTo),
    };
  }
}

class _NotEmptyValidator {
  TextValidationError? validate(String? text) {
    if (text == null || text.isEmpty) {
      return TextValidationError.empty;
    }
    return null;
  }
}

class _EmailValidator {
  TextValidationError? validate(String? text) {
    if (text == null || text.isEmpty) {
      return TextValidationError.empty;
    }
    final regex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
      multiLine: false,
    );

    if (!regex.hasMatch(text)) {
      return TextValidationError.passwordTooShort;
    }

    return null;
  }
}

class _PasswordValidator {
  TextValidationError? validate(String? text) {
    if (text == null || text.isEmpty) {
      return TextValidationError.empty;
    }
    if (text.length < BusinessConstants.minPasswordLength) {
      return TextValidationError.passwordTooShort;
    }

    return null;
  }
}

class _EqualityValidator {
  TextValidationError? validate(String? text, String? compareTo) {
    if (text == null || text.isEmpty) {
      return TextValidationError.empty;
    }
    return text == compareTo ? null : TextValidationError.notEqual;
  }
}
