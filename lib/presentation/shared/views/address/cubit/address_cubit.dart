import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/presentation/shared/views/address/cubit/address_state.dart';
import 'package:pharmago_patient/presentation/views/address_list/data/models/payload/address_payload_model.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/entities/location_entity.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/usecase/location_get_list_district_use_case.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/usecase/location_get_list_province_use_case.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/usecase/location_get_list_ward_use_case.dart';

@injectable
class AddressCubit extends Cubit<AddressState> {
  AddressCubit(
    this._getProvinceUseCase,
    this._getDistrictUseCase,
    this._getListWardUseCase,
  ) : super(const AddressState());

  final GetProvinceUseCase _getProvinceUseCase;
  final GetDistrictUseCase _getDistrictUseCase;
  final GetWardUseCase _getListWardUseCase;

  void getListProvince() async {
    emit(state.copyWith(isLoading: true));
    final input = GetProvinceUseInput();
    final res = await _getProvinceUseCase.execute(input);
    final dataList = res.response.data ?? [];
    dataList.sort((a, b) => a.title!.compareTo(b.title!));
    emit(state.copyWith(listAddress: dataList, isLoading: false));
  }

  void getListDistrict(int provinceId) async {
    emit(state.copyWith(title: 'Danh sách Quận / Huyện', isLoading: true));
    for (final province in state.listAddress) {
      if (province.id == provinceId) {
        emit(state.copyWith(province: province.title, provinceId: provinceId));
      }
    }
    final input = GetDistrictInput(id: provinceId);
    final res = await _getDistrictUseCase.execute(input);
    final dataList = res.response.data ?? [];
    dataList.sort((a, b) => a.title!.compareTo(b.title!));
    emit(state.copyWith(listAddress: dataList, isLoading: false));
  }

  void getListWard(int districtId) async {
    emit(state.copyWith(title: 'Danh sách Phường / Xã', isLoading: true));
    for (final district in state.listAddress) {
      if (district.id == districtId) {
        emit(state.copyWith(district: district.title, districtId: districtId));
      }
    }
    final input = GetWardInput(id: districtId);
    final res = await _getListWardUseCase.execute(input);
    final dataList = res.response.data ?? [];
    dataList.sort((a, b) => a.title!.compareTo(b.title!));
    emit(state.copyWith(listAddress: dataList, isLoading: false));
  }

  void onTapItem(BuildContext context, LocationEntity address) {
    if (state.province != null && state.ward == null) {
      if (state.district == null) {
        getListWard(
          address.id!,
        );
        return;
      }
      _onSelectWard(context, address);
      return;
    }
    if (state.district == null) {
      getListDistrict(
        address.id!,
      );
      return;
    }
    _onSelectWard(context, address);
    return;
  }

  void onChangeStreet(String value) {
    emit(state.copyWith(street: value));
  }

  void onSearchChange({
    String? city,
    String? district,
    String? ward,
  }) {
    print('---------------${state.citySearch}');
    print(state.listAddress);
    emit(
      state.copyWith(
        citySearch: city ?? state.citySearch,
        districtSearch: district ?? state.districtSearch,
        wardsSearch: ward ?? state.wardsSearch,
      ),
    );
  }

  Future<AddressPayloadModel> onTapDone() async {
    emit(state.copyWith(isLoadingComplete: true));
    final address =
        '${state.street != null ? '${state.street}, ' : ''}${state.ward}, ${state.district}, ${state.province}';
    try {
      final List<Location> locations = await locationFromAddress(address);
      final addressPayload = AddressPayloadModel(
        title: address,
        province: state.provinceId,
        district: state.districtId,
        ward: state.wardId,
        provinceName: state.province ?? '',
        districtName: state.district ?? '',
        wardName: state.ward ?? '',
        lat: locations.first.latitude,
        long: locations.first.longitude,

      );
      return addressPayload;
    } catch (e) {
      return AddressPayloadModel(
        title: address,
        province: state.provinceId,
        district: state.districtId,
        ward: state.wardId,
        provinceName: state.province ?? '',
        districtName: state.district ?? '',
        wardName: state.ward ?? '',
        lat: null,
        long: null,
      );
    }
  }

  void onTapReselectProvince(BuildContext context) {
    emit(
      state.copyWith(
        province: null,
        district: null,
        ward: null,
        title: 'Danh sách Tỉnh / Thành phố',
        heightBottomSheet: MediaQuery.of(context).size.height * 0.7,
        citySearch: '',
        districtSearch: '',
        wardsSearch: '',
      ),
    );
    getListProvince();
  }

  void onTapReselectDistrict(BuildContext context) {
    emit(
      state.copyWith(
        district: null,
        ward: null,
        heightBottomSheet: MediaQuery.of(context).size.height * 0.7,
        districtSearch: '',
        wardsSearch: '',
      ),
    );
    getListDistrict(state.provinceId);
  }

  void onTapReselectWard(BuildContext context) {
    emit(
      state.copyWith(
        ward: null,
        heightBottomSheet: MediaQuery.of(context).size.height * 0.7,
        wardsSearch: '',
      ),
    );
    getListWard(state.districtId);
  }

  void _onSelectWard(BuildContext context, LocationEntity data) {
    emit(
      state.copyWith(
        ward: data.title,
        wardId: data.id ?? 1,
        title: '',
        listAddress: [],
        heightBottomSheet: MediaQuery.of(context).size.height * 0.37,
      ),
    );
  }
}
