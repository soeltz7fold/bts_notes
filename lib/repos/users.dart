// import 'package:firebase_database/firebase_database.dart';
// import 'package:object/object.dart';
import 'package:uuid/uuid.dart';
import 'package:bts_notes/blocs/mixins/user_auth_mix.dart';
import 'package:bts_notes/configs/types.dart';
import 'package:bts_notes/utils/log_it.dart';

import '../constants/const.dart';
import '../models/users.dart';
import '../utils/shared_prefs.dart';

// import 'package:bts_notes/configs/routes/routes.dart';
// import 'package:bts_notes/utils/fire_db.dart';
// import 'package:bts_notes/models/rooms.dart';

class UserRepository with UserAuthMix {
  SelfUser? _user;

  UserRepository() {
    _initialize();
  }

  SelfUser get atUser => _user!;

  // Rooms get atRoom => _room!;

  Future<void> _initialize() async {
    userChecker(tag: "initial");
  }

  void userChecker({String? tag}) {
    LogIt.self.d("USER REPO CHECKER: ${_user?.id}");
    // LogIt.self.w("USER REPO HOST 2: ${atUser.id}");
  }

  /// clear user cached data
  Future onSignOut({bool isForced = false}) async {
    if (_user is SelfUser || isForced) {
      await removeUser().then((isRemoved) {
        if (!isRemoved) return;
        _user = null;
      });
    }
  }

  /// sample dummy user
  Future<SelfUser?> dummyUser() async {
    if (_user is SelfUser) return _user;
    return Future.delayed(
      const Duration(microseconds: 500),
      () => _user = SelfUser(
        id: const Uuid().v4(),
        email: "Invalid Email",
        name: "Invalid User",
      ),
    );
  }

  Future<SelfUser> prefUser() async {
    if (_user is SelfUser) return atUser;
    _user = await SharedPrefs().loadUser();

    return atUser;
    // await loadAllRooms();
    // return await _prefRoomHost().then((_) => atUser);
  }

  Future<void> _prefRoomHost() async {}

// Future<BolStr> updateLiveStatus(Rooms rooms) async {
//   return const BolStr(false, "ERROR Update Live Status");
}
