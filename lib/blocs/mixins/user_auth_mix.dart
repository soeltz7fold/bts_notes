import '../../utils/shared_prefs.dart';

mixin UserAuthMix {
  Future<bool> removeUser() async => await SharedPrefs().clearUser();
}