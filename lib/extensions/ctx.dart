import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bts_notes/configs/types.dart';
import 'package:bts_notes/constants/colored.dart';
import 'package:bts_notes/utils/log_it.dart';

extension Ctx on BuildContext {
  /// back navigate
  void goBack() {
    if (canPop()) pop();
  }

  // Future go(String route, {Object? extra}) async {
  //   Navigator.of(this).pushNamed(route, arguments: extra);
  // }
  // Future replace(String route, {Object? extra}) async {
  //   Navigator.of(this).pushReplacementNamed(route, arguments: extra);
  // }

  /// pop snack
  snacked({
    required what,
    bool isError = false,
    Color? colored,
    FunCtn voided,
  }) async {
    final snack = SnackBar(
      duration: const Duration(milliseconds: 3000),
      content: Text(what),
      backgroundColor: isError ? Colored.onlyOrange : null,
    );

    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(snack).closed.then((onValue) async {
        if (null == voided) return LogIt.self.w("SNACK CLOSED");
        voided.call(this);
      });
  }

  unSnacked() => ScaffoldMessenger.of(this).hideCurrentSnackBar();
}
