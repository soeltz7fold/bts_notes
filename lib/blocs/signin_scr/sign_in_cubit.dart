import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:bts_notes/blocs/auth/authentication_bloc.dart';
import 'package:bts_notes/extensions/enumers.dart';
import 'package:bts_notes/repos/authentications.dart';
import 'package:bts_notes/repos/users.dart';
import 'package:bts_notes/utils/helpers.dart';
import 'package:bts_notes/utils/log_it.dart';
import 'package:bts_notes/utils/shared_prefs.dart';

import '../../models/formz/auth_sign/auth_sign.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({
    required AuthenticationBloc authenticationBloc,
    required UserRepository userRepository,
  })  : _authenticationBloc = authenticationBloc,
        _userRepository = userRepository,
        super(const SignInState()) {
    initAuthStream();
  }

  final AuthenticationBloc _authenticationBloc;
  final UserRepository _userRepository;
  late StreamSubscription _streamAuthenticationBloc;

  @override
  Future<void> close() async {
    await _streamAuthenticationBloc.cancel();
    LogIt.self.w("SIGN IN CUBIT CLOSED");
    return super.close();
  }

  void onEmailChanged(String email) {
    final userEmail = UserEmail.dirty(email);
    emit(
      state._copyWith(
        userEmail: userEmail,
        isValid: Formz.validate([state.userPassword, userEmail]),
        status: state.resetSubmissionStatus,
      ),
    );
  }

  void onPasswordChanged(String password) {
    final userPassword = UserPassword.dirty(password);
    emit(
      state._copyWith(
        userPassword: userPassword,
        isValid: Formz.validate([userPassword, state.userEmail]),
        status: state.resetSubmissionStatus,
      ),
    );
  }

  Future<void> onSubmitted() async {
    if (!state.isValid) return;
    emit(state._copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      _authenticationBloc.add(AuthenticationSignInEvent(
        state.userEmail.value,
        Helpers.self.generatePassword(state.userPassword.value),
      ));
      // emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (_) {
      emit(state._copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  void initAuthStream() {
    _streamAuthenticationBloc = _authenticationBloc.stream.listen((data) async {
      final status = data.status;
      // LogIt.self.d("SIGN-IN LISTEN:: $status}");

      /// if (state.status.isInitial) return;
      if (state.status.isInProgress) {
        if (status.shouldEmit) {
          if (status.isAuthenticated) {
            // await Helpers.self
            //     .delayed(
            //         secs: 3,
            //         voided: () async {
            //           await _userRepository.prefRoomHost().whenComplete(
            //               () => LogIt.self.w("SIGN-IN DELAYED HELPER RUN!!!"));
            //         })
            //     .whenComplete(() => LogIt.self.i("SIGN-IN Emitter :: $status"));
          }

          emit(state._authWith(authStatus: status));
        }
        // await Future.delayed(const Duration(seconds: 1));
        // emit(state.copyWith(status: FormzSubmissionStatus.initial));
      }
      // if (data.status == AuthStatus.failed) {
      //   _authenticationBloc.add(const AuthenticationSubscriptionEvent());
      // }
    });
  }
}

extension _SignInCubit on SignInCubit {}
