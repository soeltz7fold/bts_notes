import 'package:uuid/uuid.dart';

extension Stringers on String {
  String get namedFromEmail => substring(0, indexOf("@"));

}