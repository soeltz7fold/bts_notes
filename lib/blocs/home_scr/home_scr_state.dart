part of 'home_scr_cubit.dart';

sealed class HomeScrState extends Equatable {
  const HomeScrState();

  @override
  List<Object> get props => [];
}

final class HomeScrLoading extends HomeScrState {
  const HomeScrLoading();
}

final class HomeScrLoaded extends HomeScrState {
  const HomeScrLoaded(this.user);

  final SelfUser user;

  @override
  List<Object> get props => [user];
}
