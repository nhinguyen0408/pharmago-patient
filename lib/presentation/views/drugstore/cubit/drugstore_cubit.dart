import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/presentation/base/infinite_list.dart';
import 'package:pharmago_patient/presentation/views/drugstore/cubit/drugstore_state.dart';
import 'package:pharmago_patient/presentation/views/drugstore/domain/entities/drugstore_entity.dart';
import 'package:pharmago_patient/presentation/views/drugstore/domain/usecase/get_list_drugstore_use_case.dart';

@injectable
class DrugstoreCubit extends Cubit<DrugstoreState> {
  DrugstoreCubit(this._getListDrugstoreUsecase) : super(const DrugstoreState());

  final GetListDrugstoreUsecase _getListDrugstoreUsecase;
  final ScrollController scrollController = ScrollController();
  final InfiniteListController<DrugstoreEntity> infiniteListController = InfiniteListController<DrugstoreEntity>.init();
  
  void onChangeShowSearch() {
    emit(state.copyWith(showSearch: !state.showSearch));
  }

  void onChangeSearch(String? value) {
    emit(state.copyWith(search: value));
    infiniteListController.onRefresh();
  }

  Future<List<DrugstoreEntity>> getAllDrugstores({required int? page}) async {
    final input = GetListDrugstoreInput(page: page ?? 1, limit: 10, search: state.search);
    final res = await _getListDrugstoreUsecase.buildUseCase(input);
    return res.response.data ?? [];
  }
}
