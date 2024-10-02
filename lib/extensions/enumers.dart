import '../repos/authentications.dart';

extension ExtAuthStatus on AuthStatus {
  bool get isAuthenticated => AuthStatus.authenticated == this;

  bool get isFailed => AuthStatus.failed == this;

  bool get isUnknown => AuthStatus.unknown == this;

  bool get shouldEmit => isAuthenticated || isFailed;
}

// extension ExtFormzStatus on FormzSubmissionStatus {
//   bool get isSuccess => FormzSubmissionStatus.success == this;
//   bool get isFailure => FormzSubmissionStatus.failure == this;
// }
