import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:uuid/enums.dart';
import 'package:uuid/uuid.dart';
// import 'package:json_annotation/json_annotation.dart';

import 'package:bts_notes/constants/app_strings.dart';
import 'package:bts_notes/configs/types.dart';
import 'package:bts_notes/configs/types.dart';
import 'package:bts_notes/constants/const.dart';
import 'package:bts_notes/extensions/stringers.dart';

// @JsonSerializable()
class SelfUser extends Equatable {
  final String? id;
  final String? email;
  final String? name;
  final String? pass;
  final int? age;

  // String get zigohId => "$id@${AppStrings.appName}";

  String get zigohLiveId => "${id}_live";

  // String get uuidFire => FireDB.self.uuidGenerate(email!);

  const SelfUser({this.id, this.email, this.pass, this.name, this.age});

  @override
  List<Object?> get props => [id, email, pass, name, age];

  SelfUser fireId({required String authId}) => SelfUser(
    id: authId,
    email: email,
    name: name,
    pass: pass,
    age: age,
  );

  /// Generate from signup
  factory SelfUser.signUp({required String email, required String hashed}) => SelfUser(
        // id: FireDB.self.uuidGenerate(email!),
        email: email,
        name: email.namedFromEmail,
        pass: hashed,
        age: -1,
      );

  /// Connect the generated
  factory SelfUser.fromJson(KeyVal json, {String? key}) => SelfUser(
        id: key ?? json['id'],
        email: json['email'],
        pass: json['pass'],
        name: json['name'],
        age: (json['age'])?.toInt(),
      );

  factory SelfUser.fromPrefs(KeyVal json) => SelfUser.fromJson(json);

  /// Connect the generated
  KeyVal toJSON({bool isFireSign = false}) {
    var struct = {
      'id': id,
      'email': email,
      'pass': pass,
      'name': name,
      'age': age,
      // "address": {"street": "Sample Street, 100 Mountain View"}
    };

    // if (isFireSign) {
    //   struct['id'] = uuidFire;
    // }
    return struct;
  }

  static const emptyUser = SelfUser();

  String encodeIt() => json.encode(toJSON());


  KeyObj fireSign(bool isSignIn) {
    // final data = KeyVal.castFrom({
    //   FireVar.isSign: isSignIn,
    // });
    return KeyObj.castFrom({"${id!}/${FireVar.isSign}": isSignIn});
  }

// static List<Music> decode(String musics) =>
//     (json.decode(musics) as List<dynamic>)
//         .map<Music>((item) => Music.fromJson(item))
//         .toList();
}

// part 'users.g.dart';
// @JsonSerializable()
// class User extends Equatable {
//   final String? id;
//   final UserData? userData;
//
//   const User(this.id, this.userData);
//
//   factory User.fromJson(KeyVal json) => _$UserFromJson(json);
//
//   KeyVal toJSON() => _$UserToJson(this);
//
//   @override
//   List<Object?> get props => [id, userData];
// }
//
// @JsonSerializable()
// class UserData extends Equatable {
//   final String? email;
//   final String? name;
//   final int? age;
//
//   const UserData({this.email, this.name, this.age});
//
//   /// Connect the generated
//   factory UserData.fromJson(KeyVal json) => _$UserDataFromJson(json);
//
//   /// Connect the generated
//   KeyVal toJSON() => _$UserDataToJson(this);
//
//   static const emptyUser = UserData();
//
//   @override
//   List<Object?> get props => [email, name, age];
// }
