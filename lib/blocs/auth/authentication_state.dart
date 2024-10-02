part of 'authentication_bloc.dart';

// sealed
class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthStatus.unknown,
    this.user = SelfUser.emptyUser,
  });

  final AuthStatus status;
  final SelfUser user;

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(SelfUser user)
      : this._(status: AuthStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthStatus.failed);

  bool get isUnknown => AuthStatus.unknown == status;

  bool get isFailed => AuthStatus.failed == status;

  bool get isAuthenticated => AuthStatus.authenticated == status;

  @override
  List<Object> get props => [status, user];
}

// final class AuthenticationInitial extends AuthenticationState {
//   @override
//   List<Object> get props => [];
// }
