import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:object/object.dart';
import 'package:bts_notes/blocs/mixins/user_auth_mix.dart';
import 'package:bts_notes/configs/apis.dart';
import 'package:bts_notes/configs/types.dart';
import 'package:bts_notes/constants/const.dart';
import 'package:bts_notes/models/users.dart';
import 'package:bts_notes/utils/callers.dart';
import 'package:bts_notes/utils/log_it.dart';
import 'package:bts_notes/utils/shared_prefs.dart';

// import 'package:bts_notes/utils/fire_auth.dart';
// import 'package:bts_notes/utils/fire_db.dart';
// import '../models/rooms.dart';

enum AuthStatus { unknown, authenticated, failed }

class AuthenticationsRepository {
  final _controller = StreamController<AuthStatus>(); //.broadcast

  AuthenticationsRepository() {
    checkStream();
  }

  void dispose() {
    // if (_controller.hasListener) {}
    _controller.close();
  }

  void checkStream() async {
    // var hasListener = _controller.hasListener;
    // LogIt.self.w("AUTH REPO Has Listen: $hasListener");
    // var fUser = FireAuth.self.auth.currentUser;
    LogIt.self.w("AUTH REPO USER: fUser");
  }

  Stream<AuthStatus> get checkUserStatus async* {
    // await Future<void>.delayed(const Duration(seconds: 4));
    checkStream();

    // check for user preferences
    final user = await SharedPrefs().loadUser();
    LogIt.self.w("AUTHENTICATION-STATUS: ${user?.email}");

    yield (user is SelfUser) ? AuthStatus.authenticated : AuthStatus.failed;
    yield* _controller.stream;
  }

  void recheckUserStatus() async {
    // yield AuthStatus.failed;
    var a = await _controller.stream.last;
    LogIt.self.e("RECHECK STATE $a");
  }

  Future<void> signIn(String email, String password) async {
    // var authState = AuthStatus.failed;

    var user = SelfUser.signUp(email: email, hashed: password);
    return await Callers.self.signIn(user).then((result) async {
      var authed = AuthStatus.failed;
      if (result != null) {
        await SharedPrefs().saveUser(user).then((isSaved) {
          if (isSaved) {
            authed = AuthStatus.authenticated;
          }
          // var token = result["data"]["token"];
        });
      }
      _controller.add(authed);
    });
  }

  /// .push()
  ///  Fire Credentials: User(displayName: null, email: test1@maill.com, isEmailVerified: false, isAnonymous: false,
  ///  metadata: UserMetadata(creationTime: 2024-09-24 01:56:30.887Z, lastSignInTime: 2024-09-24 01:56:30.887Z), phoneNumber: null, photoURL: null,
  ///  providerData, [UserInfo(displayName: null, email: test1@maill.com, phoneNumber: null, photoURL: null, providerId: password, uid: test1@maill.com)],
  ///  refreshToken: null, tenantId: null, uid: A3mUrrA1tbOl0qbhhIet37AYiy03)
  Future<BolStr> signUpUser(SelfUser atUser) async {
    var err = "Unknown Error";
    try {
      return await Callers.self.signUp(atUser).then((result) async {
        var isValid = null != result;
        final tag = isValid ? "Success" : "Failure";
        return BolStr(isValid, "Signup $tag");
      });
    } catch (exc) {
      err = "Signup Failure";
      LogIt.self.e("ERROR SIGN UP $exc");
    }
    return BolStr(false, err);
  }

  Future<void> onSignOut(SelfUser atUser) async {
    _controller.add(AuthStatus.unknown);
  }

  Future<BolStr> _signAuthChange(SelfUser atUser,
      {required bool isSignIn}) async {
    try {
      // await FireDB.self.authRef.update(atUser.fireSign(isSignIn));
      return const BolStr(true, "Sign-change Success");
    } catch (exc) {
      LogIt.self.e("ERROR SIGN UP $exc");
    }
    return const BolStr(false, "Sign-change Failure");
  }

// Future<bool> _clearUser() async => await SharedPrefs().clearUser();
}

/// just for test try
///
// await _db.child(FireTable.tblUsers).once().then((values) {
//   final snapshot = values.snapshot;
//   final responses = snapshot.children;
//   if (responses.isEmpty) return null;
//
//   final snapUser = responses.first;
//
//   final data = snapUser.value?.asMap();
//   if (data is KeyVal) {
//     // data["id"] = snapUser.key!;
//     final user = User.fromJson(snapUser.key!, data);
//     LogIt.self.d("FIRE USER ${user.toJSON()}");
//     if (email == user.email) {
//       return user;
//     }
//   }
// })

/// .push()
// Future<BolStr> signUpUser(User atUser) async {
//   try {
//     final fireUserExists =
//         await FireDB.self.isUserExists(email: atUser.email!);
//     if (null != fireUserExists) {
//       return const BolStr(false, "User Already Registered");
//     }
//     final userJson = atUser.toJSON(isFireSign: true);
//     // LogIt.self.w("JSON: $data");
//
//     // await (DatabaseReference) FireDB.self.ref.batch();
//     final dataKey = userJson['id']; // set custom_id na
//     final userRoom = Rooms(id: atUser.zigohLiveId, watchers: 0);
//
//     final KeyObj data = KeyObj.castFrom({
//       "${FireTable.users}/$dataKey": userJson,
//       "${FireTable.auths}/$dataKey": KeyVal.castFrom({
//         FireVar.email: atUser.email,
//         FireVar.password: atUser.pass,
//         FireVar.isSign: false,
//       }),
//       "${FireTable.rooms}/$dataKey": KeyVal.castFrom(userRoom.toJSON())
//     });
//
//     await FireDB.self.ref.update(data);
//     return const BolStr(true, "Signup Success");
//
//     // return await _fireSet(
//     //         atChild: FireTable.users, data: data, atKey: dataKey)
//     //     .then((result) async => await _fireSet(
//     //         atChild: FireTable.auths, data: atUser.pass, atKey: dataKey))
//     //     .then((result) {
//     //   LogIt.self.d("RESULT SUCCESS OF SIGNUP: $result");
//     //   return const BolStr(true, "Signup Success");
//     // });
//   } catch (exc) {
//     LogIt.self.e("ERROR SIGN UP $exc");
//     return const BolStr(false, "Signup Failure");
//   }
// }
