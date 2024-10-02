import 'package:flutter/material.dart';
import 'package:bts_notes/configs/types.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    this.fieldKey,
    this.label = "Email",
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
      return Key("${fieldKey!}Form_emailInput_textField");
    }
    return null;
  }

  // final displayError = context.select(
  //       (SignInCubit cubit) => cubit.state.userEmail.displayError,
  // );

  @override
  Widget build(BuildContext context) => TextField(
        key: tagKey,
        onChanged: (value) => onChanged?.call(value, context),
        decoration: InputDecoration(
          labelText: label,
          errorText: onDisplayError.call(context),
        ),
      );
}
