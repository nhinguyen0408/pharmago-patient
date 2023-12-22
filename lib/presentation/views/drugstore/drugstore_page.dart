import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmago_patient/presentation/base/infinite_list.dart';
import 'package:pharmago_patient/presentation/base/text_field.dart';
import 'package:pharmago_patient/presentation/constants/colors.dart';
import 'package:pharmago_patient/presentation/constants/size_device.dart';
import 'package:pharmago_patient/presentation/constants/spacing.dart';
import 'package:pharmago_patient/presentation/constants/typography.dart';
import 'package:pharmago_patient/presentation/di/di.dart';
import 'package:pharmago_patient/presentation/views/drugstore/cubit/drugstore_cubit.dart';
import 'package:pharmago_patient/presentation/views/drugstore/cubit/drugstore_state.dart';
import 'package:pharmago_patient/presentation/views/drugstore/domain/entities/drugstore_entity.dart';
import 'package:pharmago_patient/presentation/views/drugstore/widgets/drugstore_card.dart';
import 'package:pharmago_patient/shared/views/empty_container.dart';

@RoutePage()
class DrugstorePage extends StatefulWidget {
  const DrugstorePage({super.key});

  @override
  State<DrugstorePage> createState() => _DrugstorePageState();
}

class _DrugstorePageState extends State<DrugstorePage> {
  final drugstoreBloc = getIt.get<DrugstoreCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DrugstoreCubit>(
      create: (context) => drugstoreBloc..getAllDrugstores(page: 1),
      child: BlocBuilder<DrugstoreCubit, DrugstoreState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: bg_5,
            body: SafeArea(
              child: Stack(
                children: [
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
                      ),
                      width: widthDevice(context),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('Danh sách nhà thuốc', style: p3),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  drugstoreBloc.onChangeShowSearch();
                                },
                                child: state.showSearch
                                    ? const Icon(
                                        Icons.close,
                                        size: 20,
                                      )
                                    : const Icon(
                                        Icons.search,
                                        size: 20,
                                      ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: state.showSearch,
                            child: Container(
                              padding: const EdgeInsets.only(top: sp8),
                              child: AppInputSupport(
                                hintText: 'Tìm kiếm',
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: blackColor,
                                  size: 20,
                                ),
                                initialValue: state.search,
                                onConfirm: drugstoreBloc.onChangeSearch,
                                borderColor: borderColor_2,
                                validate: (String? value) {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: heightDevice(context),
                    width: widthDevice(context),
                    padding: const EdgeInsets.all(sp16),
                    child: Column(
                      children: [
                        SizedBox(height: state.showSearch ? 100 : 60),
                        InfiniteList<DrugstoreEntity>(
                          shrinkWrap: true,
                          getData: (page) => drugstoreBloc.getAllDrugstores(page: page + 1),
                          noItemFoundWidget: const EmptyContainer(),
                          itemBuilder: (context, item, index) {
                            return InkWell(
                              onTap: () {},
                              child: DrugstoreCard(data: item),
                            );
                          },
                          scrollController: drugstoreBloc.scrollController,
                          infiniteListController: drugstoreBloc.infiniteListController,
                        )
                      ],
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
}
