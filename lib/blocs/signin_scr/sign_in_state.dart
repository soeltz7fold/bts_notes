part of 'sign_in_cubit.dart';

final class SignInState extends Equatable {
  const SignInState({
    this.status = FormzSubmissionStatus.initial,
    this.userEmail = const UserEmail.pure(),
    this.userPassword = const UserPassword.pure(),
    this.isValid = false,
  });

  final FormzSubmissionStatus status;
  final UserEmail userEmail;
  final UserPassword userPassword;
  final bool isValid;

  get isInProgressOrSuccess => status.isInProgressOrSuccess;

  get isFailure => status.isFailure;

  get resetSubmissionStatus =>
      status.isFailure ? FormzSubmissionStatus.initial : null;

  SignInState _copyWith({
    FormzSubmissionStatus? status,
    UserEmail? userEmail,
    UserPassword? userPassword,
    bool? isValid,
  }) =>
      SignInState(
        status: status ?? this.status,
        userEmail: userEmail ?? this.userEmail,
        userPassword: userPassword ?? this.userPassword,
        isValid: isValid ?? this.isValid,
      );

  /// case AuthStatus.unknown: skip, default as unknown state
  SignInState _authWith({required AuthStatus authStatus}) => _copyWith(
        status: authStatus.isAuthenticated
            ? FormzSubmissionStatus.success
            : FormzSubmissionStatus.failure,
      );

  @override
  List<Object> get props => [status, userEmail, userPassword];
}
