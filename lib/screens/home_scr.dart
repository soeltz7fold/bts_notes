import 'package:bts_notes/blocs/auth/authentication_bloc.dart';
import 'package:bts_notes/extensions/ctx.dart';
import 'package:bts_notes/screens/note_scr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bts_notes/blocs/home_scr/bottom_navigation/home_navigation_cubit.dart';
import 'package:bts_notes/components/loader_indicator.dart';
import 'package:bts_notes/constants/app_strings.dart';
import 'package:bts_notes/constants/colored.dart';
import 'package:bts_notes/extensions/cublocers.dart';
import 'package:bts_notes/utils/log_it.dart';

import '../../blocs/home_scr/home_scr_cubit.dart';
import '../configs/of_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (c, s) {
          if (s.isUnknown) {
            c.snacked(
                what: "Success Sign Out",
                voided: (ctx) {
                  ctx.go(OfRoutes.signin);
                });
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.appName),
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: (value) => onPopped(context, value),
                itemBuilder: (BuildContext context) {
                  return {'Logout', 'Settings'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          backgroundColor: Colored.spaceGrey,
          body: const Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HomeBanner(),
              Expanded(child: NoteView()),
            ],
          ),
        ),
      );

  void onPopped(BuildContext ctx, String value) {
    // TODO if state isReady
    switch (value) {
      case 'Logout':
        ctx.blocAuth.add(const AuthenticationSignOutEvent());
        break;
      case 'Settings':
        break;
    }
  }
}

class _HomeBanner extends StatelessWidget {
  const _HomeBanner({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 200,
        child: Card.filled(
          // IntrinsicHeight
          child: BlocBuilder<HomeScrCubit, HomeScrState>(
            builder: (c, s) {
              if (s is HomeScrLoaded) {
                return Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Container(
                        color: Colored.youngBrown,
                        // child: Image.asset(AppAssets.appLogo),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Welcome Back, "),
                          Text(
                            s.user.name!,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return const LoaderIndicator(isCenter: true);
            },
          ),
        ),
      );
}

//////////////////////////////
// class BottomNavigationBarScaffold extends StatelessWidget {
//   const BottomNavigationBarScaffold(Widget child, {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
// Scaffold(
// appBar: AppBar(
// title: const Text(AppStrings.appName),
// ),
// body: child,
// bottomNavigationBar:
// BlocConsumer<HomeNavigationCubit, HomeNavigationState>(
// listener: (BuildContext c, HomeNavigationState s) {
// switch (s.idx) {
// case 0:
// c.go("/");
// break;
// case 1:
// c.go("/watch");
// break;
// default:
// break;
// }
// },
// builder: (c, s) => BottomNavigationBar(
// onTap: c.cubitHomeNavigate.tapIndex,
// backgroundColor: Colors.white70,
// enableFeedback: true,
// fixedColor: Colors.pinkAccent,
// currentIndex: s.idx,
// items: const [
// BottomNavigationBarItem(
// icon: Icon(Icons.home),
// label: 'Home',
// ),
// BottomNavigationBarItem(
// icon: Icon(Icons.video_call),
// label: 'Watch',
// ),
// BottomNavigationBarItem(
// icon: Icon(Icons.settings),
// label: 'Settings',
// ),
// ],
// ),
// ),
// );
