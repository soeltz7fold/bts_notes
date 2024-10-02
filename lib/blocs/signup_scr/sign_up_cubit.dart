import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:bts_notes/blocs/auth/authentication_bloc.dart';
import 'package:bts_notes/configs/types.dart';
import 'package:bts_notes/models/users.dart';
import 'package:bts_notes/repos/authentications.dart';
import 'package:bts_notes/repos/users.dart';

import '../../models/formz/auth_sign/user_email.dart';
import '../../models/formz/auth_sign/user_password.dart';
import '../../utils/helpers.dart';
import '../../utils/log_it.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({
    required AuthenticationsRepository authenticationsRepos,
  })  : _authenticationsRepository = authenticationsRepos,
        super(const SignUpState());

  final AuthenticationsRepository _authenticationsRepository;

  // late StreamSubscription _streamAuthenticationBloc;

  @override
  Future<void> close() async {
    // await _streamAuthenticationBloc.cancel();
    LogIt.self.w("SIGN UP CUBIT CLOSED");
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
      var formzResult = FormzSubmissionStatus.failure;
      final atUser = SelfUser.signUp(
        email: state.userEmail.value,
        hashed: Helpers.self.generatePassword(state.userPassword.value),
      );
      final resultSignUp = await _authenticationsRepository.signUpUser(atUser);
      final messageSignUp = resultSignUp.item2;
      if (resultSignUp.isValid) {
        formzResult = FormzSubmissionStatus.success;
      }
      await Helpers.self.delayed(
          ms: 1200,
          voided: () {
            emit(state._copyWith(status: formzResult, messages: messageSignUp));
          });
    } catch (_) {
      emit(state._copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  void initAuthStream() {
    //
  }
}
