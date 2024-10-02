import 'package:bts_notes/_temp/old_home_page.dart';
import 'package:bts_notes/blocs/auth/authentication_bloc.dart';
import 'package:bts_notes/configs/router_helper.dart';
import 'package:bts_notes/extensions/cublocers.dart';
import 'package:bts_notes/repos/authentications.dart';
import 'package:bts_notes/repos/users.dart';
import 'package:bts_notes/screens/auth/signin_scr.dart';
import 'package:bts_notes/screens/auth/signup_scr.dart';
import 'package:bts_notes/screens/note_scr.dart';
import 'package:bts_notes/screens/splash_scr.dart';
import 'package:bts_notes/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:bts_notes/configs/of_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  RouterHelper.instance;
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Future.wait([
    SharedPrefs().init(),
    // Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // ),
  ]).whenComplete(() => runApp(const BtsApp()));
}

class BtsApp extends StatefulWidget {
  const BtsApp({super.key});

  @override
  State<BtsApp> createState() => _BtsAppState();
}

class _BtsAppState extends State<BtsApp> {
  late final AuthenticationsRepository _authRepos;
  late final UserRepository _userRepos;

  @override
  void initState() {
    super.initState();
    _authRepos = AuthenticationsRepository();
    _userRepos = UserRepository();
  }

  @override
  void dispose() {
    _authRepos.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(
        /// RepositoryProvider.value(value: _authRepos)
        providers: [
          RepositoryProvider(create: (ctx) => AuthenticationsRepository()),
          RepositoryProvider(create: (ctx) => UserRepository()),
        ],
        child: const _App(),
      );
}

class _App extends StatelessWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<AuthenticationBloc>(
        lazy: false,
        create: (_) => AuthenticationBloc(
          authRepository: context.authRepos,
          userRepository: context.userRepos,
        ),
        child: MaterialApp.router(
          // routerConfig: appRouter,
          routerConfig: RouterHelper.router,
          // routeInformationParser: RouterHelper.router.routeInformationParser,
          // routerDelegate: RouterHelper.router.routerDelegate,
          // routeInformationProvider: RouterHelper.router.routeInformationProvider,
          // routerConfig: TryStatefulShell.router,
        ),
        //
        // home: const SplashScreen(),
        // routes: {
        //   '/splash': (context) => const SplashScreen(),
        //   OfRoutes.signin: (context) => const SignInScreen(),
        //   OfRoutes.signup: (context) => const SignUpScreen(),
        //   OfRoutes.notes: (context) => const NoteScreen(),
        // },
      );
}
