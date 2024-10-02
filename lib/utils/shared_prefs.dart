import 'dart:convert';

// import 'package:object/object.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bts_notes/configs/types.dart';
import 'package:bts_notes/constants/const.dart';
import 'package:bts_notes/models/users.dart';
import 'package:bts_notes/utils/log_it.dart';

class SharedPrefs {
  late final SharedPreferences _prefs;

  static final SharedPrefs _instance = SharedPrefs._internal();

  factory SharedPrefs() => _instance;

  SharedPrefs._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> delete(String key) async => await _prefs.remove(key);

  Future<bool> saveUser(SelfUser user) async =>
      await _prefs.setString(PrefKey.prefUser, json.encode(user.toJSON()));

  Future<SelfUser?> loadUser() async =>
      await Future.sync(() async => _prefs.getString(PrefKey.prefUser))
          .then((data) async {
        if (data is String) {
          // return User.fromPrefs(json.decode(data));
          return SelfUser.fromJson(json.decode(data));
        }
      });
}

extension PublicPreferences on SharedPrefs {
  Future<bool> clearUser() async => await delete(PrefKey.prefUser)
      .then((_) async => await loadUser().then((user) => null == user));
}
