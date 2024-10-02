import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:conduit_password_hash/conduit_password_hash.dart';
// import 'package:crypto/crypto.dart';

class Helpers {
  Helpers._privateConstructor();

  static final Helpers _instance = Helpers._privateConstructor();

  static Helpers get self => _instance;

  String generatePassword(String credentials) {
    // var salt = 'UVocjgjgXg8P7zIsC93kKlRU8sPbTBhsAMFLnLUPDRYFIWAk';

    // String credentials = "username:password";
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    final salt = stringToBase64.encode(credentials); // dXNlcm5hbWU6cGFzc3dvcmQ=
    // String decoded = stringToBase64.decode(encoded);

    var generator = new PBKDF2();
    // var salt = Salt.generateAsBase64String();
    // var salt = base
    var hashed = generator.generateKey(credentials, salt, 1000, 32);
    return hashed.join();
  }

  int intRandom() => Random().nextInt(10000);

  Future<T> delayed<T>(
      {int secs = 1, int? ms, FutureOr<T> Function()? voided}) async {
    var duration = Duration(seconds: secs);
    if (ms is int) {
      duration = Duration(milliseconds: ms);
    }
    return await Future.delayed(duration, voided);
  }
}
