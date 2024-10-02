import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bts_notes/blocs/auth/authentication_bloc.dart';
import 'package:bts_notes/constants/hardcodeds.dart';
import 'package:bts_notes/configs/types.dart';
import 'package:bts_notes/utils/helpers.dart';
import 'package:bts_notes/utils/shared_prefs.dart';

part 'setting_state.dart';

class SettingScrCubit extends Cubit<SettingScrState> {
  SettingScrCubit() : super(const SettingScrLoading()) {
    _prepareMenus();
  }

  // final AuthenticationBloc _authenticationBloc;

  Future<void> _prepareMenus() async {
    _onLoading();
    await Helpers.self.delayed(
        ms: 1200,
        voided: () {
          emit(SettingScrLoaded(Hardcodeds.self.menuSettings));
        });
  }

  void _onLoading() {
    if (state is SettingScrLoading) return;
    emit(const SettingScrLoading());
  }
}
