import 'package:formz/formz.dart';
import 'package:flutter_regex/flutter_regex.dart';

enum UserEmailValidationError { empty, invalid }

class UserEmail extends FormzInput<String, UserEmailValidationError> {
  const UserEmail.pure() : super.pure('');

  const UserEmail.dirty([super.value = '']) : super.dirty();

  @override
  UserEmailValidationError? validator(String value) {
    if (value.isEmpty) return UserEmailValidationError.empty;
    if (value.isEmail(supportTopLevelDomain: true)) return null;
    return UserEmailValidationError.invalid;
  }
}

extension ExtUserEmailValidationError on UserEmailValidationError {
  String get asError {
    switch (this) {
      case UserEmailValidationError.empty:
        return "Empty Email!";
      case UserEmailValidationError.invalid:
        return "Invalid Email Format";
      default:
        return "Unknown Error";
    }
  }
}
