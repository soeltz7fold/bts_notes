import 'package:bts_notes/configs/types.dart';
import 'package:bts_notes/constants/app_strings.dart';
import 'package:bts_notes/models/notes.dart';

class Hardcodeds {
  Hardcodeds._privateConstructor();

  static final Hardcodeds _instance = Hardcodeds._privateConstructor();

  static List<Notes> get sampleNotes => List.generate(
        20,
        (index) => Notes("title $index", "descriptions $index", index > 1),
      ).toList();

  static Hardcodeds get self => _instance;

  List<StrStr> get menuSettings => [
        const StrStr("about", "about ${AppStrings.appName}"),
        const StrStr("sign out", "Exit app"),
      ];
}
