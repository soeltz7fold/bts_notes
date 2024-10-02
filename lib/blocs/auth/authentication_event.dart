part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => const [];
}

final class _AuthenticationSubscriptionEvent extends AuthenticationEvent {
  const _AuthenticationSubscriptionEvent({required this.isRecheck});

  final bool isRecheck;
  @override
  List<Object?> get props => [isRecheck];

}

final class AuthenticationSignInEvent extends AuthenticationEvent {
  const AuthenticationSignInEvent(this.email, this.password);

  final String email;
  final String password;
}

final class AuthenticationSignOutEvent extends AuthenticationEvent {
  const AuthenticationSignOutEvent();
}
