import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bts_notes/blocs/auth/authentication_bloc.dart';
import 'package:bts_notes/blocs/signin_scr/sign_in_cubit.dart';
import 'package:bts_notes/blocs/signup_scr/sign_up_cubit.dart';
import 'package:bts_notes/blocs/splash_scr/splash_cubit.dart';
import 'package:bts_notes/repos/authentications.dart';
import 'package:bts_notes/repos/users.dart';

// import '../blocs/home_scr/bottom_navigation/home_navigation_cubit.dart';
// import '../blocs/stream_scr/stream_scr_cubit.dart';
// import 'package:bts_notes/blocs/live_scr/live_scr_cubit.dart';

extension Cublocers on BuildContext {
  SignInCubit get cubitSignIn => read<SignInCubit>();
  SignUpCubit get cubitSignUp => read<SignUpCubit>();
  SplashCubit get cubitSplash => read<SplashCubit>();

  AuthenticationBloc get blocAuth => read<AuthenticationBloc>();
  // StreamScrCubit get cubitStreamScr => read<StreamScrCubit>();
  // LiveScrCubit get cubitLiveScr => read<LiveScrCubit>();

  // HomeNavigationCubit get cubitHomeNavigate => read<HomeNavigationCubit>();

}


extension Repos on BuildContext {
  AuthenticationsRepository get authRepos => RepositoryProvider.of<AuthenticationsRepository>(this);
  UserRepository get userRepos => RepositoryProvider.of<UserRepository>(this);

}