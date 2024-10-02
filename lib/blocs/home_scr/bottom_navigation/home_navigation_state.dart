part of 'home_navigation_cubit.dart';

// sealed
class HomeNavigationState extends Equatable {
  const HomeNavigationState({this.idx = 2});

  final int idx;

  @override
  List<Object> get props => [idx];

  HomeNavigationState _indexWith({int? idx}) =>
      HomeNavigationState(idx: idx ?? this.idx);
}

// final class HomeNavigationLoading extends HomeNavigationState {
//   const HomeNavigationLoading();
// }
//
//
// final class HomeNavigationLoading extends HomeNavigationState {
//   const HomeNavigationLoading();
// }
