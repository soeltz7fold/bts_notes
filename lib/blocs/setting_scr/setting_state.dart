part of 'setting_cubit.dart';

sealed class SettingScrState extends Equatable {
  const SettingScrState();
  @override
  List<Object> get props => [];
}

final class SettingScrLoading extends SettingScrState {
  const SettingScrLoading();
}

// final class SettingScrSignOut extends SettingScrState {
//   const SettingScrSignOut();
// }

final class SettingScrLoaded extends SettingScrState {
  const SettingScrLoaded(this.menus, {this.isExit = false});

  final List<StrStr> menus;
  final bool isExit;

  @override
  List<Object> get props => [menus, isExit];

  SettingScrLoaded _signOut() => SettingScrLoaded(menus, isExit: true);

}
