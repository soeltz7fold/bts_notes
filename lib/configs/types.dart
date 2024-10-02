import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

/// typedef ListViewAdapter<T> = Widget Function(T item);

typedef KeyVal = Map<String, dynamic>;
typedef KeyObj = Map<String, Object>;
typedef BolBol = Tuple2<bool, bool>;
typedef BolStr = Tuple2<bool, String?>;
typedef StrStr = Tuple2<String, String>;

typedef FunStr = String Function(String val)?;
typedef FunStrCtx<T> = T Function(String val, BuildContext ctx)?;
typedef FunCtx<T> = T Function(BuildContext ctx);
typedef FunCtn<T> = T Function(BuildContext ctx)?;

extension ExtBolStr on BolStr {
  bool get isValid => item1;

  String? get messages => item2;
}

extension ExtBolBol on BolBol {
  bool get isValid1 => item1;

  bool get isValid2 => item2;
}

extension ExtStrStr on StrStr {
  String get title => item1;

  String get subtitle => item2;
}
