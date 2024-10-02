import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:meta/meta.dart';
import 'package:object/object.dart' as obj;
// import 'package:bts_notes/configs/routes/routes.dart';
import 'package:bts_notes/repos/authentications.dart';
import 'package:bts_notes/utils/log_it.dart';

import '../auth/authentication_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._authenticationBloc) : super(const SplashInitial()) {
    _fetchUser();
  }

  // final AuthenticationsRepository _authenticationRepository;
  final AuthenticationBloc _authenticationBloc;
  late StreamSubscription _streamAuthenticationBloc;

  @override
  Future<void> close() {
    _streamAuthenticationBloc.cancel();
    return super.close();
  }

  Future<void> _fetchUser() async {
    try {
      _streamAuthenticationBloc = _authenticationBloc.stream.listen((data) {
        final status = data.status;
        LogIt.self.d("SPLASH USER LISTEN: $status");
        emit(SplashLoaded(status));
      });
    } catch (exc) {
      LogIt.self.e("SPLASH USER EXCEPTION: $exc");
    } finally {
      LogIt.self.d("SPLASH FETCH ENDED..........");
      FlutterNativeSplash.remove();
    }
  }
}
