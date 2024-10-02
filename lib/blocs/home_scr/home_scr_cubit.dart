import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bts_notes/blocs/auth/authentication_bloc.dart';
import 'package:bts_notes/models/users.dart';
import 'package:bts_notes/utils/helpers.dart';
import 'package:bts_notes/utils/shared_prefs.dart';

part 'home_scr_state.dart';

class HomeScrCubit extends Cubit<HomeScrState> {
  HomeScrCubit({required AuthenticationBloc authenticationBloc})
      : _authenticationBloc = authenticationBloc,
        super(const HomeScrLoading()) {
    _onPrepare();
  }

  final AuthenticationBloc _authenticationBloc;

  void _onPrepare() async {
    final user = _authenticationBloc.getUser;
    await Helpers.self.delayed(voided: () {
      emit(HomeScrLoaded(user));
    });
  }
}
