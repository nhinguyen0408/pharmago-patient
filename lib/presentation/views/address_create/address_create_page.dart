import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pharmago_patient/presentation/base/button.dart';
import 'package:pharmago_patient/presentation/base/text_field.dart';
import 'package:pharmago_patient/presentation/constants/colors.dart';
import 'package:pharmago_patient/presentation/constants/size_device.dart';
import 'package:pharmago_patient/presentation/constants/spacing.dart';
import 'package:pharmago_patient/presentation/constants/typography.dart';
import 'package:pharmago_patient/presentation/di/di.dart';
import 'package:pharmago_patient/presentation/router/router.gr.dart';
import 'package:pharmago_patient/presentation/views/address_create/cubit/address_create_cubit.dart';
import 'package:pharmago_patient/presentation/views/address_create/cubit/address_create_state.dart';
import 'package:pharmago_patient/presentation/views/address_list/cubit/address_list_cubit.dart';
import 'package:pharmago_patient/presentation/views/address_list/data/models/payload/address_payload_model.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/entities/address_entity.dart';
import 'package:pharmago_patient/presentation/views/map_picker/map_picker_page.dart';
import 'package:pharmago_patient/shared/utils/dialog_utils.dart';
import 'package:pharmago_patient/shared/utils/event.dart';
import 'package:pharmago_patient/shared/views/address_with_map.dart';

@RoutePage()
class AddressCreatePage extends StatefulWidget {
  const AddressCreatePage({super.key, required this.addressListCubit, this.data});
  final AddressListCubit addressListCubit;
  final AddressEntity? data;
 
  @override
  State<AddressCreatePage> createState() => _AddressCreatePageState();
}

class _AddressCreatePageState extends State<AddressCreatePage> {
  final bloc = getIt.get<AddressCreateCubit>();
  late TextEditingController _addressDetailTec;


  @override
  void initState() {
    super.initState();

    _addressDetailTec = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddressCreateCubit>(
      create: (context) => bloc..innitialize(addressData: widget.data),
      child: BlocBuilder<AddressCreateCubit, AddressCreateState>(
        builder: (context, state) {
          _addressDetailTec.text =
                          state.addressPayload?.title ?? '';
          return Scaffold(
            backgroundColor: bg_5,
            body: SafeArea(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: InkWell(
                      onTap: () => FocusScope.of(context).unfocus(),
                      child: Container(
                        width: widthDevice(context),
                        padding: const EdgeInsets.all(sp16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(sp8),
                          color: whiteColor,
                        ),
                        child: Form(
                          key: bloc.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 60),
                              Text(
                                widget.data != null ? 'Sửa địa chỉ' : 'Đăng ký một địa chỉ mới',
                                style: h5,
                              ),
                              const SizedBox(height: 16),
                              AppInputSupport(
                                initialValue: state.fullname,
                                label: 'Họ tên',
                                hintText: 'Nhập họ tên',
                                validate: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return 'Vui lòng nhập';
                                  }
                                },
                                required: true,
                                onChanged: bloc.changeFullname,
                              ),
                              const SizedBox(height: sp16),
                              AppInputSupport(
                                initialValue: state.phone,
                                label: 'Số điện thoại',
                                hintText: 'Nhập số điện thoại',
                                textInputType: TextInputType.phone,
                                validate: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return 'Vui lòng nhập số điện thoại';
                                  } else if (!isPhoneNumberValid(value ?? '')) {
                                    return 'Sai định dạng số điện thoại.';
                                  }
                                },
                                required: true,
                                onChanged: bloc.changePhone,
                              ),
                              const SizedBox(height: sp16),
                              AppInputSupport(
                                controller: TextEditingController(
                                    text: state.addressPayload?.title ?? ''),
                                label: 'Tỉnh/ Thành phố',
                                hintText: 'Nhấn để chọn tỉnh/ thành phố',
                                validate: (value) {},
                                required: true,
                                suffixIcon: const Icon(
                                  Icons.arrow_drop_down_rounded,
                                  size: sp24,
                                ),
                                readOnly: true,
                                onTap: () =>
                                    bloc.tapToOpenBottomSheetAddress(context),
                              ),
                              Visibility(
                                visible: state.addressPayload != null,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () => context.router.push(
                                      MapPickerRoute(
                                        onConfirm: (address, position) {
                                          final addressPayload = AddressPayloadModel(
                                            lat: position.latitude,
                                            long: position.longitude,
                                          );
                                          bloc.changeCoordinate(addressPayload);
                                        },
                                        addressInit: AddressPickerEntity(
                                          provinceId: state.addressPayload!.province,
                                          provinceName: state.addressPayload!.provinceName,
                                          districtId: state.addressPayload!.district,
                                          districtName: state.addressPayload!.districtName,
                                          wardId: state.addressPayload!.ward,
                                          wardName: state.addressPayload!.wardName,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      'Sửa định vị',
                                      style: p5.copyWith(color: blue_1),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: sp16),
                              AppInputSupport(
                                controller: TextEditingController(text: state.addressTitle),
                                label: 'Địa chỉ chi tiết',
                                hintText: 'Nhập địa chỉ chi tiết',
                                validate: (value) {},
                                required: true,
                                // onChanged: bloc.changeAddressTitle,
                              ),
                              const SizedBox(height: sp16),
                              InkWell(
                                onTap: bloc.changeIsDefaultAddress,
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: state.isDefaultAddress,
                                      activeColor: mainColor,
                                      onChanged: (value) {},
                                    ),
                                    const Text('Đặt làm địa chỉ mặc định'),
                                  ],
                                ),
                              ),
                              const SizedBox(height: sp16),
                              SizedBox(
                                width: double.infinity,
                                child: MainButton(
                                  event: () {
                                    widget.data == null ?  _createAddress(context) : _updateAddress(context);
                                  },
                                  title: 'Xác nhận',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(sp16),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: borderColor_2,
                            width: 1.0,
                          ),
                        ),
                        color: whiteColor,
                      ),
                      width: widthDevice(context),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.chevron_left,
                                  color: blackColor,
                                ),
                              ),
                              const SizedBox(width: sp8),
                              const Text('Thêm địa chỉ', style: h5),
                              const Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _createAddress(BuildContext context) async {
    final validate = bloc.formKey.currentState!.validate();
    if (validate == false) {
      return;
    }

    if (bloc.state.addressPayload == null) {
      DialogUtils.showErrorDialog(
        context,
        content: 'Vui lòng chọn địa chỉ.',
      );
      return;
    }

    DialogUtils.showLoadingDialog(
      context,
      content: 'Đang tạo địa chỉ, vui lòng đợi',
    );
    final res = await bloc.createAddress();
    Navigator.of(context).pop();
    if (res.code == 200 && context.mounted) {
      widget.addressListCubit.getListAddress();
      DialogUtils.showSuccessDialog(
        context,
        content: 'Thêm địa chỉ thành công',
        titleConfirm: 'Đồng ý',
        accept: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        close: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      );
    } else {
      DialogUtils.showErrorDialog(
        context,
        content: 'Thêm địa chỉ thất bại. \n ${res.message}',
      );
    }
  }

  Future<void> _updateAddress(BuildContext context) async {
    final validate = bloc.formKey.currentState!.validate();
    if (validate == false) {
      return;
    }

    if (bloc.state.addressPayload == null) {
      DialogUtils.showErrorDialog(
        context,
        content: 'Vui lòng chọn địa chỉ.',
      );
      return;
    }

    DialogUtils.showLoadingDialog(
      context,
      content: 'Đang sửa địa chỉ, vui lòng đợi',
    );
    final res = await bloc.updateAddress();
    Navigator.of(context).pop();
    if (res.code == 200 && context.mounted) {
      widget.addressListCubit.getListAddress();
      DialogUtils.showSuccessDialog(
        context,
        content: 'Sửa địa chỉ thành công',
        titleConfirm: 'Đồng ý',
        accept: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        close: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      );
    } else {
      DialogUtils.showErrorDialog(
        context,
        content: 'Sửa địa chỉ thất bại. \n ${res.message}',
      );
    }
  }
}
