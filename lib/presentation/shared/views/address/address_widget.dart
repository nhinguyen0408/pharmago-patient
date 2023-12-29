import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmago_patient/presentation/base/loading.dart';
import 'package:pharmago_patient/presentation/base/select_address_widget.dart';
import 'package:pharmago_patient/presentation/base/text_field.dart';
import 'package:pharmago_patient/presentation/constants/asset_path.dart';
import 'package:pharmago_patient/presentation/constants/colors.dart';
import 'package:pharmago_patient/presentation/constants/size_device.dart';
import 'package:pharmago_patient/presentation/constants/spacing.dart';
import 'package:pharmago_patient/presentation/constants/typography.dart';
import 'package:pharmago_patient/presentation/di/di.dart';
import 'package:pharmago_patient/presentation/shared/views/address/cubit/address_cubit.dart';
import 'package:pharmago_patient/presentation/shared/views/address/cubit/address_state.dart';
import 'package:pharmago_patient/presentation/views/address_list/data/models/payload/address_payload_model.dart';
import 'package:pharmago_patient/presentation/views/address_list/domain/entities/location_entity.dart';

class AddressWidget extends StatefulWidget {
  AddressWidget({super.key, required this.onDone});

  final Function(AddressPayloadModel) onDone;

  @override
  State<AddressWidget> createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  final myBloc = getIt.get<AddressCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddressCubit>(
      create: (context) => myBloc..getListProvince(),
      child: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          // height:
          //     state.heightBottomSheet ?? MediaQuery.of(context).size.height * 0.7,
          color: whiteColor,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: sp16,
                    vertical: sp16,
                  ),
                  color: borderColor_1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: context.router.pop,
                        child: Text(
                          'Đóng',
                          style: p5.copyWith(color: blue_1),
                        ),
                      ),
                      BlocBuilder<AddressCubit, AddressState>(
                        builder: (context, state) {
                          return InkWell(
                            onTap: state.ward != null
                                ? () async {
                                    final addressPayload =
                                        await myBloc.onTapDone();
                                    Navigator.of(context).pop();
                                    widget.onDone(addressPayload);
                                  }
                                : null,
                            child: state.isLoadingComplete
                                ? const BaseLoading(
                                    size: sp12,
                                  )
                                : Text(
                                    'Hoàn thành',
                                    style: p5.copyWith(
                                      color: state.ward != null
                                          ? blue_1
                                          : borderColor_3,
                                    ),
                                  ),
                          );
                        },
                      )
                    ],
                  ),
                ),
                BlocBuilder<AddressCubit, AddressState>(
                  builder: (context, state) {
                    return _timeSelectAddress(
                      context: context,
                      province: state.province,
                      district: state.district,
                      ward: state.ward,
                      onChangeStreet: myBloc.onChangeStreet,
                      onTapReselectProvince: myBloc.onTapReselectProvince,
                      onTapReselectDistrict: myBloc.onTapReselectDistrict,
                      onTapReselectWard: myBloc.onTapReselectWard,
                      addressCubit: myBloc,
                    );
                  },
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: borderColor_2,
                ),
                // if (state.isLoading)
                //   const Expanded(child: BaseLoading())
                // else
                //   Expanded(
                //     child: Padding(
                //       padding: const EdgeInsets.all(sp16),
                //       child: _listSelect(
                //         title: state.title,
                //         listAddress: state.listAddress
                //             .where(
                //               (e) =>
                //                   (e.title ?? '').toLowerCase().contains(state.citySearch.toLowerCase()),
                //             )
                //             .toList(),
                //         onTapItem: myBloc.onTapItem,
                //       ),
                //     ),
                //   ),
                BlocBuilder<AddressCubit, AddressState>(
                  builder: (context, state) {
                    late String searchValue;
                    if (state.province == null) {
                      searchValue = state.citySearch;
                    } else if (state.district == null) {
                      searchValue = state.districtSearch;
                    } else {
                      searchValue = state.wardsSearch;
                    }
                    if (state.isLoading) {
                      return SizedBox(
                        height: heightDevice(context) * 0.4,
                        child: const Center(child: BaseLoading()),
                      );
                    } else if (!state.isLoading && state.ward == null) {
                      return Padding(
                        padding: const EdgeInsets.all(sp16),
                        child: _listSelect(
                          title: state.title,
                          listAddress: state.listAddress
                              .where(
                                (e) => (e.title ?? '')
                                    .toLowerCase()
                                    .contains(searchValue.toLowerCase()),
                              )
                              .toList(),
                          onTapItem: (_, value) =>
                              myBloc.onTapItem.call(_, value),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _timeSelectAddress({
    required BuildContext context,
    String? province,
    String? district,
    String? ward,
    Function(String value)? onChangeStreet,
    required Function(BuildContext value) onTapReselectProvince,
    required Function(BuildContext value) onTapReselectDistrict,
    required Function(BuildContext value) onTapReselectWard,
    required AddressCubit addressCubit,
  }) {
    return Padding(
      padding: const EdgeInsets.all(sp16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Chọn khu vực', style: p3),
          const SizedBox(height: sp16),
          province == null
              ? SelectAddressWidget(
                  hintText: 'Chọn Tỉnh / Thành phố',
                  onSearch: (value) => addressCubit.onSearchChange(city: value),
                )
              : Column(
                  children: [
                    SelectAddressWidget(
                      value: province,
                      onTap: () => addressCubit.onTapReselectProvince(context),
                    ),
                    district == null
                        ? SelectAddressWidget(
                            hintText: 'Chọn Quận / Huyện',
                            onSearch: (value) =>
                                addressCubit.onSearchChange(district: value),
                          )
                        : Column(
                            children: [
                              SelectAddressWidget(
                                value: district,
                                onTap: () => onTapReselectDistrict(context),
                              ),
                              ward == null
                                  ? SelectAddressWidget(
                                      hintText: 'Chọn Phường / Xã',
                                      onSearch: (value) => addressCubit
                                          .onSearchChange(ward: value),
                                    )
                                  : SelectAddressWidget(
                                      value: ward,
                                      onTap: () => onTapReselectWard(context),
                                    ),
                            ],
                          ),
                  ],
                ),
          if (ward != null)
            AppInputSupport(
              hintText: 'Số nhà, đường',
              validate: (String? value) {},
              onChanged: onChangeStreet,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SvgPicture.asset(
                  '${AssetsPath.icon}/ic_selected.svg',
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget _listSelect({
    String? title,
    required Function(BuildContext, LocationEntity) onTapItem,
    required List<LocationEntity> listAddress,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? 'Danh sách Tỉnh / Thành phố',
          style: p3,
        ),
        SizedBox(
          height: heightDevice(context) * 0.4,
          child: ListView.separated(
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => onTapItem(context, listAddress[index]),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: sp16,
                  ),
                  child: Row(
                    children: [
                      Text(
                        listAddress[index].title!.substring(0, 1),
                        style: p4.copyWith(
                          color: borderColor_3,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        listAddress[index].title!,
                        style: p4,
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.only(left: 27),
                child: Divider(
                  height: 1,
                  color: borderColor_2,
                  thickness: 1,
                ),
              );
            },
            itemCount: listAddress.length,
          ),
        )
      ],
    );
  }
}
