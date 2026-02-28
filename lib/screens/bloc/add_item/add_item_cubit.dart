import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:router_experiment/const/key_pair_const.dart';
import 'package:router_experiment/service/shared_preference_service.dart';

part 'add_item_state.dart';

class AddItemCubit extends Cubit<AddItemState> {
  final SharedPreferenceService _sharedPreferenceService;

  AddItemCubit(this._sharedPreferenceService) : super(AddItemState()) {
    _sharedPreferenceService.init();
  }

  void onChanged(String value) {
    emit(state.copyWith(item: value));
  }

  Future<void> addItem() async {
    try {
      emit(state.copyWith(status: AddItemStatus.loading));

      // 1️⃣ Read existing list
      final existingList =
          await _sharedPreferenceService.read<List<String>>(
            KeyPairConst.listPrefsKey,
          ) ??
          [];

      // 2️⃣ Add new item
      existingList.add(state.item!);

      // 3️⃣ Save entire list
      await _sharedPreferenceService.write(
        KeyPairConst.listPrefsKey,
        existingList,
      );
      emit(state.copyWith(status: AddItemStatus.success));
    } catch (e) {
      log('[Add Item Cubit] ${e.toString()}');
      emit(state.copyWith(status: AddItemStatus.failure));
    }
  }
}
