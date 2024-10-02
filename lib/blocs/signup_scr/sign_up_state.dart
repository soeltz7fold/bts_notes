part of 'sign_up_cubit.dart';

// sealed
final class SignUpState extends Equatable {
  const SignUpState({
    this.status = FormzSubmissionStatus.initial,
    this.userEmail = const UserEmail.pure(),
    this.userPassword = const UserPassword.pure(),
    this.isValid = false,
    this.messages,
  });

  final FormzSubmissionStatus status;
  final UserEmail userEmail;
  final UserPassword userPassword;
  final bool isValid;
  final String? messages;

  bool get isInProgressOrSuccess => status.isInProgressOrSuccess;

  bool get isFailure => status.isFailure;

  FormzSubmissionStatus? get resetSubmissionStatus =>
      status.isFailure ? FormzSubmissionStatus.initial : null;

  SignUpState _copyWith({
    FormzSubmissionStatus? status,
    UserEmail? userEmail,
    UserPassword? userPassword,
    bool? isValid,
    String? messages,
  }) =>
      SignUpState(
        status: status ?? this.status,
        userEmail: userEmail ?? this.userEmail,
        userPassword: userPassword ?? this.userPassword,
        isValid: isValid ?? this.isValid,
        messages: messages
      );

  @override
  List<Object> get props => [status, userEmail, userPassword];
}
