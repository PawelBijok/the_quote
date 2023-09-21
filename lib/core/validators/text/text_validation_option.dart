sealed class TextValidationOption {
  TextValidationOption(this.text);

  final String? text;
}

class NotEmptyTextValidation extends TextValidationOption {
  NotEmptyTextValidation(super.text);
}

class EmailTextValidation extends TextValidationOption {
  EmailTextValidation(super.text);
}

class PasswordTextValidation extends TextValidationOption {
  PasswordTextValidation(super.text);
}

class EqualityTextValidation extends TextValidationOption {
  EqualityTextValidation(super.text, this.compareTo);
  final String? compareTo;
}
