import 'package:flutter/material.dart';
import 'package:bts_notes/configs/types.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    this.fieldKey,
    this.label = "Password",
    required this.onChanged,
    required this.onDisplayError,
    super.key,
  });

  final String? fieldKey;
  final FunStrCtx onChanged;
  final FunCtx<String?> onDisplayError;
  final String label;

  Key? get tagKey {
    if (fieldKey is String) {
      return Key("${fieldKey!}Form_passwordInput_textField");
    }
    return null;
  }

  // final displayError = context.select(
  //       (SignInCubit cubit) => cubit.state.userPassword.displayError,
  // );

  @override
  Widget build(BuildContext context) => TextField(
        obscureText: true,
        key: tagKey,
        onChanged: (value) => onChanged?.call(value, context),
        decoration: InputDecoration(
          labelText: label,
          // errorText: displayError != null ? 'invalid password' : null,
          errorText: onDisplayError.call(context),
        ),
      );
}
