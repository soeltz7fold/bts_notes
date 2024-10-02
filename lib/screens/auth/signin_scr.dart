import 'package:bts_notes/configs/of_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
// import 'package:go_router/go_router.dart';
// import 'package:bts_notes/configs/router_helper.dart';
// import 'package:bts_notes/configs/routes/routes.dart';
import 'package:bts_notes/blocs/auth/authentication_bloc.dart';
import 'package:bts_notes/blocs/signin_scr/sign_in_cubit.dart';
import 'package:bts_notes/components/forms/email_field.dart';
import 'package:bts_notes/components/forms/password_field.dart';
import 'package:bts_notes/components/forms/submission_button.dart';
import 'package:bts_notes/constants/colored.dart';
import 'package:bts_notes/extensions/ctx.dart';
import 'package:bts_notes/extensions/cublocers.dart';
import 'package:bts_notes/models/formz/auth_sign/auth_sign.dart';
import 'package:bts_notes/repos/authentications.dart';
import 'package:bts_notes/utils/log_it.dart';
import 'package:go_router/go_router.dart';

import '../../constants/app_strings.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) => BackButtonListener(
        onBackButtonPressed: () async {
          // if (location == OfRoutes.signin) {
          //   LogIt.self.w("LOCATION SIGNIN");
          //   return true;
          // }
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Sign In",
              style: TextStyle(color: Colored.onlyWhite),
            ),
            backgroundColor: Colored.youngBrown,
          ),
          body: Container(
            color: Colors.green.shade50,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: BlocProvider(
              create: (ctx) => SignInCubit(
                authenticationBloc: ctx.blocAuth,
                userRepository: ctx.userRepos,
              ),
              child: const _SignInForm(),
            ),
            // child: sampleCenter(context)
          ),
        ),
      );

}

class _SignInForm extends StatelessWidget {
  const _SignInForm({super.key});

  // Future<void> createEngine() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   // Get your AppID and AppSign from ZEGOCLOUD Console
  //   //[My Projects -> AppID] : https://console.zegocloud.com/project
  //   await ZegoExpressEngine.createEngineWithProfile(ZegoEngineProfile(
  //     appId,
  //     ZegoScenario.Default,
  //     appSign: appSignId,
  //   ));
  // }

  @override
  Widget build(BuildContext context) => BlocListener<SignInCubit, SignInState>(
        listener: (c, s) async {
          switch (s.status) {
            case FormzSubmissionStatus.success:
              c.replace(OfRoutes.home, extra: s.userEmail);

              // await createEngine();
              LogIt.self.w("SUCCESS SIGN-IN");

              break;
            case FormzSubmissionStatus.failure:
              c.snacked(what: 'Authentication Failure');
              break;
            default:
              break;
          }
        },
        child: Column(
          children: [
            Expanded(
              child: Column(
                // mainAxisSize: ,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Welcome to ${AppStrings.appName}",
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.end,
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          top: 0,
                          child: Align(
                            alignment: const Alignment(0, -1 / 1.8),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                EmailField(
                                    onChanged: (val, ctx) =>
                                        ctx.cubitSignIn.onEmailChanged(val),
                                    onDisplayError: (ctx) {
                                      var err = ctx.select(
                                        (SignInCubit cbt) =>
                                            cbt.state.userEmail.displayError,
                                      );

                                      return err?.asError;
                                    }),
                                const Padding(padding: EdgeInsets.all(12)),
                                PasswordField(
                                    onChanged: (val, ctx) =>
                                        ctx.cubitSignIn.onPasswordChanged(val),
                                    onDisplayError: (ctx) {
                                      var err = ctx.select(
                                        (SignInCubit cbt) =>
                                            cbt.state.userPassword.displayError,
                                      );
                                      return err != null
                                          ? 'Invalid password'
                                          : null;
                                    }),
                                const Padding(padding: EdgeInsets.all(12)),
                                const SizedBox(height: 16),
                                SubmissionButton(
                                  label: "SIGN IN",
                                  colored: Colored.onlyGreen,
                                  onValidState: (ctx) => ctx.select(
                                    (SignInCubit bloc) => bloc.state.isValid,
                                  ),
                                  onProgressState: (ctx) => ctx.select(
                                    (SignInCubit cubit) =>
                                        cubit.state.status.isInProgress,
                                  ),
                                  onSubmit: (ctx) {
                                    context.cubitSignIn.onSubmitted();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Positioned(
                        //   top: -28,
                        //   right: 8,
                        //   // width: 100,
                        //   height: 128,
                        //   child: Image.asset(AppAssets.appLogo),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<SignInCubit, SignInState>(
                  builder: (c, s) {
                    return TextButton(
                      onPressed: (s.status.isInProgressOrSuccess)
                          ? null
                          : () {
                        c.push(OfRoutes.signup);
                      },
                      child: const Text(
                        "I want join ${AppStrings.appName}.",
                        textAlign: TextAlign.end,
                      ),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      );
}
