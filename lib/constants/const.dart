import 'package:tuple/tuple.dart';
import 'package:bts_notes/configs/types.dart';

const appId = 1629813521;
const String appSignId =
    "8298b13731df19a94b3f7b020f38e05c8067b9d43812a01d6d20272b1d1f2766";
const String sampleUserId = "userId1";
const String sampleUserName = "userIdOne";
const String sampleLiveId = "liveIdOne";

// Firebase
class FireTable {
  static const auths = "auths";
  static const users = "users";
  static const rooms = "rooms";
}

class FireVar {
  static const email = 'email';
  static const password = 'pass';
  static const id = 'id';
  static const isLive = 'is_live';
  static const isSign = 'is_sign';
}

class PrefKey {
  static const prefUser = 'pref_user';
}
