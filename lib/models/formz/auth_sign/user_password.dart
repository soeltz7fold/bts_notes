import 'package:formz/formz.dart';

enum UserPasswordValidationError { empty }

class UserPassword extends FormzInput<String, UserPasswordValidationError> {
  const UserPassword.pure() : super.pure('');
  const UserPassword.dirty([super.value = '']) : super.dirty();

  @override
  UserPasswordValidationError? validator(String value) {
    if (value.isEmpty) return UserPasswordValidationError.empty;
    return null;
  }
}