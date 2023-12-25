import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmago_patient/presentation/base/infinite_list.dart';
import 'package:pharmago_patient/presentation/constants/colors.dart';
import 'package:pharmago_patient/presentation/constants/size_device.dart';
import 'package:pharmago_patient/presentation/constants/spacing.dart';
import 'package:pharmago_patient/presentation/constants/typography.dart';
import 'package:pharmago_patient/presentation/di/di.dart';
import 'package:pharmago_patient/presentation/views/drugstore/domain/entities/drugstore_entity.dart';
import 'package:pharmago_patient/presentation/views/drugstore_detail/cubit/drugstore_detail_cubit.dart';
import 'package:pharmago_patient/presentation/views/drugstore_detail/cubit/drugstore_detail_state.dart';
import 'package:pharmago_patient/presentation/views/drugstore_detail/widgets/drugstore_infor_cart.dart';
import 'package:pharmago_patient/presentation/views/product_list/domain/entities/variant_entity.dart';
import 'package:pharmago_patient/shared/views/empty_container.dart';

@RoutePage()
class DrugstoreDetailPage extends StatefulWidget {
  const DrugstoreDetailPage({super.key, required this.id});
  final String id;

  @override
  State<DrugstoreDetailPage> createState() => _DrugstoreDetailPageState();
}

class _DrugstoreDetailPageState extends State<DrugstoreDetailPage> {
  final bloc = getIt.get<DrugstoreDetailCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DrugstoreDetailCubit>(
      create: (context) =>
          bloc..innitialize(drugstore: widget.id),
      child: BlocBuilder<DrugstoreDetailCubit, DrugstoreDetailState>(
        builder: (context, state) => Scaffold(
          backgroundColor: bg_5,
          body: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child:
                    DrugstoreInformationCard(data: state.dataDrugstore, cubit: bloc),
                ),
                Container(
                  height: heightDevice(context),
                  width: widthDevice(context),
                  padding: const EdgeInsets.all(sp16),
                  child: Column(
                    children: [
                      const SizedBox(height: 130),
                      const Row(
                        children: [
                          Text('Sản phẩm', style: p3),
                        ],
                      ),
                      const SizedBox(height: sp16),
                      InfiniteList<VariantEntity>(
                        shrinkWrap: true,
                        getData: (page) => bloc.getListVariantOfDrugstore(page: page + 1, drugstore: widget.id,),
                        noItemFoundWidget: const EmptyContainer(),
                        itemBuilder: (context, item, index) {
                          return InkWell(
                            onTap: () {},
                            child: Text(item.title ?? 'Null'),
                          );
                        },
                        scrollController: bloc.scrollController,
                        infiniteListController: bloc.infiniteListController,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
