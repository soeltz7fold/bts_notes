import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bts_notes/configs/of_routes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:bts_notes/blocs/mixins/user_auth_mix.dart';
import 'package:bts_notes/models/users.dart';
import 'package:bts_notes/repos/authentications.dart';
import 'package:bts_notes/repos/users.dart';
import 'package:bts_notes/utils/helpers.dart';
import 'package:bts_notes/utils/log_it.dart';
import 'package:bts_notes/utils/shared_prefs.dart';

// import '../../configs/routes/routes.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationsRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    _preCheck();

    on<_AuthenticationSubscriptionEvent>(_onceSubscriptionRequested);
    on<AuthenticationSignOutEvent>(_actionSignOut);
    on<AuthenticationSignInEvent>(_onSignInEvent);

    _initialEvent();
  }

  final AuthenticationsRepository _authRepository;
  final UserRepository _userRepository;

  SelfUser get getUser => _userRepository.atUser;

  @override
  Future<void> close() {
    _authRepository.dispose();
    return super.close();
  }

  void _preCheck() async {
    if (AppConfig.launchClearUser) {
      await _userRepository.onSignOut(isForced: true);
      // _authRepository.onSignOut();
    }
    LogIt.self.w("PREPARE DEVELOPMENT USER AUTH-CHECKER....................");
  }

  void _initialEvent() =>
      add(const _AuthenticationSubscriptionEvent(isRecheck: false));

  FutureOr<void> _onceSubscriptionRequested(
    _AuthenticationSubscriptionEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    // if (event.isRecheck) {
    //// var a = _authRepository.recheckUserStatus();
    //// LogIt().e("RECHECK NOW");
    // } else {
    return emit.onEach(
      _authRepository.checkUserStatus,
      onData: (status) async {
        LogIt.self.w("AUTH EACH: $status");
        switch (status) {
          case AuthStatus.failed:
            LogIt.self.e("AUTH BLOC FAIL");
            return emit(const AuthenticationState.unauthenticated());
          case AuthStatus.authenticated:
            final user = await _userRepository.prefUser();
            LogIt.self.w("AUTH BLOC OKAY ${user.id}");
            LogIt.self.w("REPO USER ${_userRepository.atUser.toJSON()}");
            return emit(AuthenticationState.authenticated(user));
          default:
            LogIt.self.e("AUTH BLOC DEFAULT");
            await _userRepository.onSignOut();
            return emit(const AuthenticationState.unknown());
        }
      },
      onError: addError,
    );
  }

  // user force getter
  Future<SelfUser?> _tryGetUser() async {
    try {
      return await _userRepository.dummyUser();
    } catch (_) {
      return null;
    }
  }

  Future<FutureOr<void>> _actionSignOut(AuthenticationSignOutEvent event,
      Emitter<AuthenticationState> emit) async {
    _authRepository.onSignOut(_userRepository.atUser);
    // return _tryGetUser();
  }

  void _onSignInEvent(AuthenticationSignInEvent event,
      Emitter<AuthenticationState> emit) async {
    // cause failure at first signin fired
    emit(const AuthenticationState.unknown());
    // add(const AuthenticationSubscriptionEvent(isRecheck: true));
    _authRepository.signIn(event.email, event.password);
  }
}
