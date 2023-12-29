import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/presentation/shared/views/address/address_widget.dart';
import 'package:pharmago_patient/presentation/views/address_create/cubit/address_create_state.dart';
import 'package:pharmago_patient/presentation/views/address_list/data/models/payload/address_payload_model.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/entities/address_entity.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/usecase/create_address_use_case.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/usecase/update_address_use_case.dart';

@injectable
class AddressCreateCubit extends Cubit<AddressCreateState> {
  AddressCreateCubit(this._createAddressUsecase, this._updateAddressUsecase) : super(const AddressCreateState());
  final CreateAddressUsecase _createAddressUsecase;
  final UpdateAddressUsecase _updateAddressUsecase;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void innitialize({ AddressEntity? addressData }) {
    if (addressData != null) {
      emit(state.copyWith(
        fullname: addressData.fullName ?? '',
        phone: addressData.phone ?? '',
        addressTitle: addressData.title ?? '',
        idAddress: addressData.id,
        isDefaultAddress: addressData.isDefault ?? false,
        addressPayload: AddressPayloadModel(
          // province:  addressData.province?.id,
          provinceName: addressData.province?.title,
          // district:  addressData.district?.id,
          districtName: addressData.district?.title,
          // ward:  addressData.ward?.id,
          wardName: addressData.ward?.title,
          title: addressData.title,
        ),
      ));
    }
  }

  void changeFullname(String value) {
    emit(state.copyWith(fullname: value));
  }

  void changePhone(String value) {
    emit(state.copyWith(phone: value));
  }

  void changeAddressTitle(String value) {
    emit(state.copyWith(addressTitle: value));
  }

  void changeIsDefaultAddress() {
    emit(state.copyWith(isDefaultAddress: !state.isDefaultAddress));
  }

  Future<void> tapToOpenBottomSheetAddress(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(_).viewInsets.bottom,
          ),
          child: AddressWidget(
            onDone: (value) {
              emit(state.copyWith(
                addressPayload: value,
                addressTitle: value.title ?? '',
              ));
            },
          ),
        );
      },
    );
  }

  Future<BaseResponseModel> createAddress() async {
    final payload = state.addressPayload!.copyWith(
      title: state.addressTitle,
      phone: state.phone,
      addressPayloadModelDefault: state.isDefaultAddress,
      fullName: state.fullname,
    );
    final input = CreateAddressInput(address: payload);
    final res = await _createAddressUsecase.execute(input);
    return res.response;
  }

  Future<BaseResponseModel> updateAddress() async {
    final payload = state.addressPayload!.copyWith(
      title: state.addressTitle,
      phone: state.phone,
      addressPayloadModelDefault: state.isDefaultAddress,
      fullName: state.fullname,
    );
    final input = UpdateAddressInput(address: payload, id: state.idAddress!);
    final res = await _updateAddressUsecase.execute(input);
    return res.response;
  }
}
