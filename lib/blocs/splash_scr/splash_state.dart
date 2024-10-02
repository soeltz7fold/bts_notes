part of 'splash_cubit.dart';

@immutable
sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

final class SplashInitial extends SplashState {
  const SplashInitial();
}

final class SplashLoaded extends SplashState {
  final AuthStatus status;

  const SplashLoaded(this.status);

  @override
  List<Object?> get props => [status];
}
