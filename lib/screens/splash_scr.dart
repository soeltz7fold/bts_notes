import 'package:bts_notes/configs/of_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bts_notes/blocs/splash_scr/splash_cubit.dart';
// import 'package:go_router/go_router.dart';
import 'package:bts_notes/configs/router_helper.dart';
// import 'package:bts_notes/configs/routes/routes.dart';
import 'package:bts_notes/extensions/enumers.dart';
import 'package:bts_notes/repos/authentications.dart';
import 'package:go_router/go_router.dart';

import '../blocs/auth/authentication_bloc.dart';
import '../utils/log_it.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LogIt.self.d("SPLASHED.........");
    return BlocProvider(
      create: (ctx) => SplashCubit(
        BlocProvider.of<AuthenticationBloc>(ctx),
        // RepositoryProvider.of<AuthenticationsRepository>(ctx),
      ),
      child: const _SplashView(),
    );
  }
}

class _SplashView extends StatelessWidget {
  const _SplashView({super.key});

  @override
  Widget build(BuildContext context) => BlocListener<SplashCubit, SplashState>(
        listener: (ctx, state) {
          LogIt.self.d("SPLASHED RESULT: $state");
          if (state is SplashLoaded) {
            var routeTarget = OfRoutes.signin;
            if (state.status.isAuthenticated) {
              LogIt.self.i("SPLASHED SUCCESS");
              routeTarget = OfRoutes.home;
            } else {
              LogIt.self.e("SPLASHED FAILED");
            }
            ctx.go(routeTarget, extra: 'Splashed Result');
            // ctx.replace(CustomNavigationHelper.homePath, extra: 'Splashed Result');
          }
        },
        child: Container(
            color: Colors.brown,
            child: const Center(
              child: CircularProgressIndicator(color: Colors.green),
            )),
      );
}
