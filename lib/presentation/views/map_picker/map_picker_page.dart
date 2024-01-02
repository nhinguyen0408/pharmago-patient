import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
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
import 'package:pharmago_patient/presentation/views/map_picker/cubit/map_picker_cubit.dart';
import 'package:pharmago_patient/presentation/views/map_picker/cubit/map_picker_state.dart';
import 'package:pharmago_patient/shared/views/empty_container.dart';

class AddressPickerEntity {
  final String? provinceName;
  final String? districtName;
  final String? wardName;
  final int? provinceId;
  final int? districtId;
  final int? wardId;
  final String? title;

  AddressPickerEntity({
    this.districtName,
    this.provinceName,
    this.wardName,
    this.districtId,
    this.provinceId,
    this.wardId,
    this.title,
  });
}

@RoutePage()
class MapPickerPage extends StatefulWidget {
  const MapPickerPage({super.key, this.onConfirm, this.addressInit});

  final Function(AddressPickerEntity? value, LatLng latLng)? onConfirm;
  final AddressPickerEntity? addressInit;

  @override
  State<MapPickerPage> createState() => _MapPickerPageState();
}

class _MapPickerPageState extends State<MapPickerPage> {
  GoogleMapController? mapController;

  CameraPosition? positionMap;

  LatLng? myLocation;

  final bool _isLoading = false;

  // Timer? timer;

  // List<Placemark>? placemark;

  // Future<void> getAddressFromLatLong() async {
  //   if (timer != null) {
  //     timer!.cancel();
  //   }

  //   timer = Timer(const Duration(seconds: 1), () async {
  //     await placemarkFromCoordinates(
  //       positionMap!.target.latitude,
  //       positionMap!.target.longitude,
  //     ).then((value) {
  //       print('-----------$value');
  //       setState(() {
  //         _isLoading = false;
  //         placemark = value;
  //       });
  //     });
  //   });
  // }

  // Future<void> getMyLocation() async {
  //   final geolocationService = GeolocationService();
  //   final Position location = await geolocationService.determinePosition();
  //   final addressMylocation =
  //       await placemarkFromCoordinates(location.latitude, location.longitude);
  //   setState(() {
  //     myLocation = LatLng(location.latitude, location.longitude);
  //     positionMap = CameraPosition(target: myLocation!);
  //     placemark = addressMylocation;
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   getMyLocation().then(
  //     (value) {
  //       setState(() {
  //         _isLoadingDidChange = false;
  //       });
  //     },
  //   );
  // }

  final myBloc = getIt.get<MapPickerCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MapPickerCubit>(
      create: (context) => myBloc
        ..getMyLocation()
        ..onFieldChange(
          addressInit: widget.addressInit,
          //  '${widget.addressInit?.title ?? ''}, ${widget.addressInit?.wardName ?? ''}, ${widget.addressInit?.districtName ?? ''}, ${widget.addressInit?.provinceName ?? ''}',
        ),
      child: BlocBuilder<MapPickerCubit, MapPickerState>(
        builder: (context, state) {
          return Material(
            child: Stack(
              children: [
                state.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Stack(
                        children: [
                          Container(
                            width: widthDevice(context),
                            height: heightDevice(context),
                            child: GoogleMap(
                              myLocationButtonEnabled: false,
                              onMapCreated: myBloc.initGMSController,
                              // onCameraMove: (position) {
                              //   setState(() {
                              //     positionMap = position;
                              //   });
                              // },
                              initialCameraPosition: CameraPosition(
                                target: state.myLocation,
                                zoom: 14,
                              ),
                              markers: state.markers,
                              // onTap: (argument) {
                              //   setState(() {
                              //     myLocation = argument;
                              //   });
                              // },
                              gestureRecognizers: Set()
                                ..add(
                                  Factory<PanGestureRecognizer>(
                                    () => PanGestureRecognizer(),
                                  ),
                                ),
                              // gestureRecognizers: <Factory<OneSequenceGestureRecognizer>> [
                              //   new Factory<OneSequenceGestureRecognizer>(() => new EagerGestureRecognizer())
                              // ].toSet(),
                            ),
                          ),
                          // const Positioned(
                          //   child: Center(
                          //     child: Icon(
                          //       Icons.location_pin,
                          //       size: 32,
                          //       color: red_1,
                          //     ),
                          //   ),
                          // ),
                          Positioned(
                            top: sp48,
                            left: sp16,
                            right: sp16,
                            child: Column(
                              children: [
                                AppInputSupport(
                                  hintText: 'Nhập địa chỉ tìm kiếm',
                                  backgroundColor: whiteColor,
                                  validate: (value) {},
                                  prefixIcon: const Icon(
                                    Icons.location_pin,
                                    size: sp20,
                                    color: mainColor,
                                  ),
                                  onChanged: (value) =>
                                      myBloc.searchEvent(value),
                                  suffixIcon: state.addressSearch.isNotEmpty
                                      ? InkWell(
                                          child: const Padding(
                                            padding: EdgeInsets.all(sp12),
                                            child: CircleAvatar(
                                              radius: sp4,
                                              backgroundColor: greyColor,
                                              child: Icon(
                                                Icons.close_rounded,
                                                size: sp12,
                                                color: whiteColor,
                                              ),
                                            ),
                                          ),
                                        )
                                      : null,
                                ),
                                const SizedBox(height: sp8),
                                Visibility(
                                  visible: state.listPlaceSearch.isNotEmpty,
                                  child: Container(
                                    padding: const EdgeInsets.all(sp16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(sp8),
                                      color: whiteColor,
                                    ),
                                    constraints: const BoxConstraints(
                                      minHeight: 0,
                                      maxHeight: 300,
                                    ),
                                    child: ListView.separated(
                                      padding: const EdgeInsets.all(sp0),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) =>
                                          InkWell(
                                        onTap: () => myBloc.geocode(
                                          placeId: state
                                              .listPlaceSearch[index].placeId,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(sp16),
                                          child: Text(
                                            state.listPlaceSearch[index]
                                                    .description ??
                                                '',
                                          ),
                                        ),
                                      ),
                                      separatorBuilder: (context, index) =>
                                          const Divider(
                                        height: 1,
                                      ),
                                      itemCount: state.listPlaceSearch.length,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: BaseContainer(
                    context,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_isLoading)
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                        // else
                        //   RichText(
                        //     text: TextSpan(
                        //       text: 'Địa chỉ CHTH là: ',
                        //       style: p6.copyWith(color: greyColor),
                        //       children: [
                        //         if (placemark != null)
                        //           TextSpan(
                        //             text:
                        //                 '${placemark![0].street}, ${placemark![0].subAdministrativeArea}, ${placemark![0].administrativeArea}',
                        //             style: h6.copyWith(color: mainColor),
                        //           ),
                        //       ],
                        //     ),
                        //   ),
                        Row(
                          children: [
                            const Icon(
                              Icons.circle,
                              color: blue_1,
                              size: sp12,
                            ),
                            const SizedBox(width: sp8),
                            Text(
                              state.addressInit?.provinceName ??
                                  'Chưa có thông tin',
                              style: p5,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: Text(
                            '|',
                            textAlign: TextAlign.left,
                            style: p4.copyWith(color: greyColor),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.circle,
                              color: blue_1,
                              size: sp12,
                            ),
                            const SizedBox(width: sp8),
                            Text(
                              state.addressInit?.districtName ??
                                  'Chưa có thông tin',
                              style: p5,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: Text(
                            '|',
                            textAlign: TextAlign.left,
                            style: p4.copyWith(color: greyColor),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.circle,
                              color: blue_1,
                              size: sp12,
                            ),
                            const SizedBox(width: sp8),
                            Text(
                              state.addressInit?.wardName ??
                                  'Chưa có thông tin',
                              style: p5,
                            )
                          ],
                        ),
                        const SizedBox(height: sp24),
                        Container(
                          width: double.infinity,
                          child: MainButton(
                            title: 'Xác nhận địa chỉ',
                            event: () {
                              confirmAddress();
                            },
                            largeButton: true,
                            icon: null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void confirmAddress() {
    widget.onConfirm?.call(
      myBloc.state.addressInit,
      LatLng(
        myBloc.state.latLng?.latitude ?? 20.998912971915075,
        myBloc.state.latLng?.longitude ?? 105.79476852273238,
      ),
    );
    context.router.pop();
  }
}
