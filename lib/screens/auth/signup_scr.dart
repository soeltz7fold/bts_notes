import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
// import 'package:go_router/go_router.dart';
import 'package:bts_notes/blocs/signup_scr/sign_up_cubit.dart';
import 'package:bts_notes/constants/app_strings.dart';
import 'package:bts_notes/extensions/ctx.dart';
import 'package:bts_notes/extensions/cublocers.dart';
import 'package:bts_notes/models/formz/auth_sign/auth_sign.dart';
import 'package:bts_notes/repos/users.dart';
// import 'package:bts_notes/configs/router_helper.dart';
// import 'package:bts_notes/configs/routes/routes.dart';

import '../../components/forms/email_field.dart';
import '../../components/forms/password_field.dart';
import '../../components/forms/submission_button.dart';
import '../../constants/colored.dart';
import '../../utils/log_it.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            "Sign Up",
            style: TextStyle(color: Colored.onlyWhite),
          ),
          backgroundColor: Colored.youngBrown,
        ),
        body: Container(
          color: Colors.green.shade50,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: BlocProvider(
            create: (ctx) => SignUpCubit(authenticationsRepos: ctx.authRepos),
            child: const _SignUpForm(),
          ),
          // child: sampleCenter(context)
        ),
      );
}

class _SignUpForm extends StatelessWidget {
  const _SignUpForm({super.key});

  @override
  Widget build(BuildContext context) => BlocListener<SignUpCubit, SignUpState>(
        listener: (c, s) async {
          switch (s.status) {
            case FormzSubmissionStatus.success:
              // c.go(OfRoutes.home, extra: s.userEmail);
              await c.snacked(
                what: s.messages,
                voided: (ctx) {
                  ctx.goBack();
                  LogIt.self.w("SUCCESS SIGN-UP");
                },
              );
              // await createEngine();
              break;
            case FormzSubmissionStatus.failure:
              c.snacked(what: s.messages ?? 'Signup Failure', isError: true);
              break;
            default:
              break;
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "become ${AppStrings.appName} user",
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.end,
            ),
            Expanded(
              child: Align(
                alignment: const Alignment(0, -1 / 1.5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    EmailField(
                        onChanged: (val, ctx) =>
                            ctx.cubitSignUp.onEmailChanged(val),
                        onDisplayError: (ctx) {
                          var err = ctx.select(
                            (SignUpCubit cbt) =>
                                cbt.state.userEmail.displayError,
                          );
                          return err?.asError;
                        }),
                    const Padding(padding: EdgeInsets.all(12)),
                    PasswordField(
                        onChanged: (val, ctx) =>
                            ctx.cubitSignUp.onPasswordChanged(val),
                        onDisplayError: (ctx) {
                          var err = ctx.select(
                            (SignUpCubit cbt) =>
                                cbt.state.userPassword.displayError,
                          );
                          return err != null ? 'Invalid password' : null;
                        }),
                    const Padding(padding: EdgeInsets.all(12)),
                    const SizedBox(height: 16),
                    SubmissionButton(
                      label: "SIGN UP",
                      colored: Colored.shadowPink,
                      onValidState: (ctx) => ctx.select(
                        (SignUpCubit bloc) => bloc.state.isValid,
                      ),
                      onProgressState: (ctx) => ctx.select(
                        (SignUpCubit cubit) => cubit.state.status.isInProgress,
                      ),
                      onSubmit: (ctx) {
                        context.cubitSignUp.onSubmitted();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
