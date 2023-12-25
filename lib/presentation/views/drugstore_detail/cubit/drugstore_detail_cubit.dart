import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/presentation/base/infinite_list.dart';
import 'package:pharmago_patient/presentation/views/drugstore/domain/entities/drugstore_entity.dart';
import 'package:pharmago_patient/presentation/views/drugstore/domain/usecase/get_detial_drugstore_use_case.dart';
import 'package:pharmago_patient/presentation/views/drugstore_detail/cubit/drugstore_detail_state.dart';
import 'package:pharmago_patient/presentation/views/product_list/domain/entities/product_entity.dart';
import 'package:pharmago_patient/presentation/views/product_list/domain/entities/variant_entity.dart';
import 'package:pharmago_patient/presentation/views/product_list/domain/usecase/get_list_product_use_case.dart';
import 'package:pharmago_patient/presentation/views/product_list/domain/usecase/get_list_variant_use_case.dart';

@injectable
class DrugstoreDetailCubit extends Cubit<DrugstoreDetailState> {
  DrugstoreDetailCubit(
    this._getListProductUsecase,
    this._getDetailDrugstoreUsecase,
    this._getListVariantUsecase,
  ) : super(const DrugstoreDetailState());
  final GetListProductUsecase _getListProductUsecase;
  final GetDetailDrugstoreUsecase _getDetailDrugstoreUsecase;
  final GetListVariantUsecase _getListVariantUsecase;


  final ScrollController scrollController = ScrollController();
  final InfiniteListController<VariantEntity> infiniteListController = InfiniteListController<VariantEntity>.init();

  void innitialize({required String drugstore}) async {
    final DrugstoreEntity? drugstoreData =
        await getDetailDrugstore(drugstore: drugstore);
    emit(state.copyWith(dataDrugstore: drugstoreData));
  }

  void onChangeKeySearchVariant(String? value) {
    emit(state.copyWith(keySearchVariant: value));
  }

  Future<List<ProductEntity>> getListProductsOfDrugstore({
    required String drugstore,
  }) async {
    final input = GetListProductInput(page: 1, limit: 10, drugstore: drugstore);
    final res = await _getListProductUsecase.buildUseCase(input);
    return res.response.data ?? [];
  }

  Future<List<VariantEntity>> getListVariantOfDrugstore({
    required String drugstore,
    required int page,
  }) async {
    final input = GetListVariantInput(
      page: page,
      limit: 10,
      drugstore: drugstore,
      search: state.keySearchVariant,
    );
    final res = await _getListVariantUsecase.buildUseCase(input);
    return res.response.data ?? [];
  }

  Future<DrugstoreEntity?> getDetailDrugstore({
    required String drugstore,
  }) async {
    final input = GetDetailDrugstoreInput(id: drugstore);
    final res = await _getDetailDrugstoreUsecase.buildUseCase(input);
    return res.response.data;
  }
}
