import 'dart:convert';

import 'package:bts_notes/blocs/splash_scr/splash_cubit.dart';
import 'package:bts_notes/configs/apis.dart';
import 'package:bts_notes/configs/types.dart';
import 'package:bts_notes/models/users.dart';
import 'package:bts_notes/utils/log_it.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:object/object.dart';

class Callers {
  Callers._privateConstructor();

  static final Callers _instance = Callers._privateConstructor();

  static Callers get self => _instance;

  Future<KeyVal?> signIn(SelfUser user, {KeyVal? data}) async {
    try {
      final response = await http.post(
        Uri.parse(Apis.reqToken),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: jsonEncode({
          // TODO as JSON function
          "username": user.name,
          "password": user.pass,
        }),
      );
      final code = response.statusCode;
      if (200 == code) {
        var jsonResponse = convert.jsonDecode(response.body);
        KeyVal data = KeyVal.castFrom(jsonResponse);
        // var data = jsonResponse['data'];
        // Number of books about http: {statusCode: 2110, message: Proses view detail berhasil,
        // errorMessage: null,
        // data: {token: eyJhbGciOiJIUzUxMiJ9.eyJyb2xlcyI6W119.i2OVQdxr08dmIqwP7cWOJk5Ye4fySFUqofl-w6FKbm4EwXTStfm0u-sGhDvDVUqNG8Cc7STtUJlawVAP057Jlg}}.
        LogIt.self.d('RESULT: ${data}.');
        return data;
      } else {
        LogIt.self.e('Request failed with status: $code.');
      }
    } catch (exc) {
      LogIt.self.e(exc.toString());
    }
    return null;
  }

  Future<KeyVal?> signUp(SelfUser user) async {
    try {
      final response = await http.post(Uri.parse(Apis.register),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            // TODO as JSON function
            "email": user.email,
            "password": user.pass,
            "username": user.name,
            // "email": "test1@email.com",
            // "password": "password",
            // "username": "test_1",
          }));
      final code = response.statusCode;
      if (200 == code) {
        // {statusCode: 2000, message: Proses save berhasil, errorMessage: null, data: null}
        var jsonResponse = convert.jsonDecode(response.body);
        KeyVal data = KeyVal.castFrom(jsonResponse);
        // var data = jsonResponse['data'];
        LogIt.self.d('USER REGISTERED');
        return data;
      } else {
        LogIt.self.e('USER FAIL REGISTER status: $code.');
      }
    } catch (exc) {
      // print(exc);
      LogIt.self.e(exc);
    }
    return null;
  }

  /// todo into dynamic functions
// Future<KeyVal?> call({required String url, KeyVal? data}) async {
//   try {
//     final response = await http(Uri.parse(url), headers: {}, );
//     final code = response.statusCode;
//     if (200 == code) {
//       var jsonResponse = convert.jsonDecode(response.body).asMap;
//       // var data = jsonResponse['data'];
//       LogIt.self.d('Number of books about http: $jsonResponse.');
//     } else {
//       LogIt.self.e('Request failed with status: $code.');
//     }
//   } catch (exc) {
//     LogIt.self.e(exc);
//   }
// }
}
