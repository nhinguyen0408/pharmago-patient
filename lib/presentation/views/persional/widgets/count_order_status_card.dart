import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pharmago_patient/presentation/constants/colors.dart';
import 'package:pharmago_patient/presentation/constants/spacing.dart';
import 'package:pharmago_patient/presentation/constants/typography.dart';
import 'package:pharmago_patient/presentation/router/router.gr.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/entities/order_count_entity.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/repositories/order_repository.dart';
import 'package:pharmago_patient/presentation/views/persional/cubit/persional_cubit.dart';

class CountOrderStatusCart extends StatelessWidget {
  const CountOrderStatusCart({super.key, required this.data, required this.persionalCubit});
  final CountOrderEntity data;
  final PersionalCubit persionalCubit;

  Color getColor( int status ) {
    if (status == StatusOrder.NEW.getValue) {
      return blackColor;
    }
    if (status == StatusOrder.TRANSPORT.getValue) {
      return blue_1;
    }
    if (status == StatusOrder.COMPLETE.getValue) {
      return mainColor;
    }
    if (status == StatusOrder.CANCEL.getValue) {
      return red_3;
    }
    return blackColor;
  }

  StatusOrder getStatus(int status) {
    if (status == StatusOrder.NEW.getValue) {
      return StatusOrder.NEW;
    }
    if (status == StatusOrder.TRANSPORT.getValue) {
      return StatusOrder.TRANSPORT;
    }
    if (status == StatusOrder.COMPLETE.getValue) {
      return StatusOrder.COMPLETE;
    }
    if (status == StatusOrder.CANCEL.getValue) {
      return StatusOrder.CANCEL;
    }
    return StatusOrder.NEW;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.router.push(OrderListRoute(status: getStatus(data.key ?? 0), persionalCubit: persionalCubit));
      },
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(sp16),
        decoration: BoxDecoration(
          color: bg_6,
          borderRadius: BorderRadius.circular(sp8),
        ),
        child: Column(
          children: [
            Text(data.status ?? ''),
            const SizedBox(height: sp8),
            Text('${data.count}', style: h5.copyWith(color: getColor(data.key ?? 0))),
          ],
        ),
      ),
    );
  }
}