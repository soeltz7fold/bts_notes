import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:go_router/go_router.dart';
import 'package:bts_notes/utils/log_it.dart';

part 'home_navigation_state.dart';

class HomeNavigationCubit extends Cubit<HomeNavigationState> {
  HomeNavigationCubit(int currentIndex)
      : super(HomeNavigationState(idx: currentIndex)) {
    LogIt.self.w("SHELL INDEX $currentIndex");
    // if (state.idx < 0) state._copyWith(idx: 0);
  }

  // final StatefulNavigationShell navigationShell;

  void tapIndex(int navigationIdx) {
    emit(state._indexWith(idx: navigationIdx));
  }
}
