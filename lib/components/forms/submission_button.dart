import 'package:flutter/material.dart';
import 'package:bts_notes/components/loader_indicator.dart';
import 'package:bts_notes/configs/types.dart';
import 'package:bts_notes/extensions/ctx.dart';

import '../../constants/colored.dart';

class SubmissionButton extends StatelessWidget {
  const SubmissionButton({
    this.btnKey, // = 'signin'
    this.label = "Sign In",
    required this.onSubmit,
    required this.onValidState,
    required this.onProgressState,
    this.colored,
    super.key,
  });

  final String? btnKey;
  final String label;
  final FunCtx<bool> onProgressState;
  final FunCtx<void> onSubmit;
  final FunCtx<bool> onValidState;
  final Color? colored;

  Key? get tagKey {
    if (btnKey is String) {
      return Key("${btnKey!}Form_button_submission");
    }
    return null;
  }

  // bool get isValidState => onValidState

  // final isInProgressOrSuccess = context.select(
  //       (SignInCubit cubit) => cubit.state.status.isInProgress,
  // );
  // final isValid = context.select((SignInCubit bloc) => bloc.state.isValid);

  @override
  Widget build(BuildContext context) {
    // isInProgressOrSuccess

    final isInProgressOrSuccess = onProgressState(context);
    // if (isInProgressOrSuccess) {
    //   return const LoaderIndicator(isCenter: true);
    // }

    // final isValid = context.select((SignInCubit bloc) => bloc.state.isValid);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: colored),
            key: tagKey,
            onPressed: onValidState.call(context)
                ? () {
                    context.unSnacked();
                    onSubmit.call(context);
                  }
                : null,
            child: isInProgressOrSuccess
                ? const LoaderIndicator(isCenter: true, isIndicator: true)
                : Text(
                    label,
                    style: TextStyle(
                      color: colored == null ? null : Colored.onlyWhite,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
