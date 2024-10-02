import 'package:bts_notes/configs/of_routes.dart';
import 'package:bts_notes/extensions/cublocers.dart';
import 'package:bts_notes/screens/auth/signin_scr.dart';
import 'package:bts_notes/screens/auth/signup_scr.dart';
import 'package:bts_notes/screens/home_scr.dart';
import 'package:bts_notes/screens/splash_scr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/home_scr/home_scr_cubit.dart';

class RouterHelper {
  static final RouterHelper _instance = RouterHelper._internal();

  static RouterHelper get instance => _instance;

  static late final GoRouter router;

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _authNavigatorKey = GlobalKey<NavigatorState>();

  static final homeTabNavigatorKey = GlobalKey<NavigatorState>();

  // static final searchTabNavigatorKey = GlobalKey<NavigatorState>();
  // static final settingsTabNavigatorKey = GlobalKey<NavigatorState>();

  BuildContext get context =>
      router.routerDelegate.navigatorKey.currentContext!;

  GoRouterDelegate get routerDelegate => router.routerDelegate;

  GoRouteInformationParser get routeInformationParser =>
      router.routeInformationParser;

  // static const String homePath = '/home';
  // static const String settingsPath = '/settings';
  // static const String searchPath = '/search';

  factory RouterHelper() => _instance;

  RouterHelper._internal() {
    final routes = [
      /// Splash page
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: OfRoutes.splash,
        builder: (BuildContext context, GoRouterState state) =>
            const SplashScreen(),

        // pageBuilder: (context, state) {
        //   return getPage( child: const SplashScreen(),  state: state, );
        // },
      ),

      /// signUP page
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: OfRoutes.signup,
        pageBuilder: (context, state) {
          return const NoTransitionPage(
            child: SignUpScreen(),
            // state: state,
          );
        },
      ),

      /// signIN page
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: OfRoutes.signin,
        pageBuilder: (context, state) {
          return const NoTransitionPage(
            child: SignInScreen(),
            // state: state,
          );
        },
        // onExit: (c, s) => false,
      ),

      // HOME

      GoRoute(
        path: OfRoutes.home,
        pageBuilder: (context, GoRouterState state) => NoTransitionPage(
          child: BlocProvider(
            create: (ctx) => HomeScrCubit(authenticationBloc: ctx.blocAuth),
            child: const HomeScreen(),
          ),
          // label: OfRoutes.home.asNamed,
          // detailsPath: '/home/details')
        ),
      ),
    ];

    router = GoRouter(
      // refreshListenable:,
      // errorBuilder: (context, state) => Container(color: Colors.red,),
      // errorPageBuilder: (context, state) => getPage(child: Container(color: Colors.red,), state: state),
      navigatorKey: _rootNavigatorKey,
      initialLocation: OfRoutes.splash,
      debugLogDiagnostics: true,
      routes: routes,
    );
  }
}
