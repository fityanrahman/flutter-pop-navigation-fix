import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:router_experiment/const/key_pair_const.dart';
import 'package:router_experiment/service/shared_preference_service.dart';

part 'list_screen_state.dart';

class ListScreenCubit extends Cubit<ListScreenState> {
  final SharedPreferenceService _sharedPreferenceService;
  ListScreenCubit(this._sharedPreferenceService) : super(ListScreenState());

  Future<void> loadData() async {
    try {
      log('[ListScreenCubit] loadData');
      emit(state.copyWith(status: ListScreenStatus.loading));

      await _sharedPreferenceService.init();

      final value = await _sharedPreferenceService.read(
        KeyPairConst.listPrefsKey,
      );
      emit(state.copyWith(list: value, status: ListScreenStatus.success));
    } catch (e) {
      emit(
        state.copyWith(status: ListScreenStatus.failure, error: e.toString()),
      );
    }
  }

  Future<void> clearData() async {
    try {
      await _sharedPreferenceService.clear();

      emit(state.copyWith(list: [], status: ListScreenStatus.success));
    } catch (e) {
      emit(state.copyWith(status: ListScreenStatus.failure));
    }
  }
}
