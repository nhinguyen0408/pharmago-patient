import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pharmago_patient/presentation/base/button.dart';
import 'package:pharmago_patient/presentation/constants/colors.dart';
import 'package:pharmago_patient/presentation/constants/spacing.dart';
import 'package:pharmago_patient/presentation/constants/typography.dart';
import 'package:pharmago_patient/presentation/router/router.gr.dart';
import 'package:pharmago_patient/presentation/views/drugstore/domain/entities/drugstore_entity.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/entities/order_entity.dart';
import 'package:pharmago_patient/presentation/views/order_list/domain/repositories/order_repository.dart';
import 'package:pharmago_patient/shared/utils/event.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.status,
    required this.data,
    this.onUpdateSuccess,
  });
  final StatusOrder status;
  final OrderEntity data;
  final Function()? onUpdateSuccess;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.router.push(OrderDetailRoute(
            id: data.id!, status: status, onUpdateSuccess: onUpdateSuccess));
      },
      child: Container(
        padding: const EdgeInsets.all(sp16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(sp8),
          color: whiteColor,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              spreadRadius: 4,
              blurRadius: 16,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                DrugstoreMiniCard(data: DrugstoreEntity()),
                const Spacer(),
                StatusOrderCart(status: status)
              ],
            ),
            const SizedBox(
              height: sp8,
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final item = data.items![index];
                return Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(sp4),
                      child: item.variant?.image != null
                          ? Image.network(
                              item.variant!.image!,
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/imgs/logo.png',
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                            ),
                    ),
                    const SizedBox(
                      width: sp16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              item.variant?.title ?? '',
                              style: p4,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          const SizedBox(
                            height: sp8,
                          ),
                          Text(
                            item.unit?.title ?? '',
                            style: p6.copyWith(color: greyColor),
                          ),
                          const SizedBox(
                            height: sp8,
                          ),
                          Row(
                            children: [
                              Text(
                                FormatCurrency(item.price ?? 0),
                                style: h5.copyWith(color: red_3),
                              ),
                              const Spacer(),
                              Text(
                                'x${item.quantity}',
                                style: p5,
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
              itemCount: data.items?.length ?? 0,
            ),
            const SizedBox(
              height: sp8,
            ),
            const Divider(),
            Row(
              children: [
                Text(
                  '${data.items?.length} sản phẩm',
                  style: p7.copyWith(color: greyColor),
                ),
                const Spacer(),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Thành tiền: ',
                        style: p7.copyWith(color: greyColor),
                      ),
                      TextSpan(
                        text: FormatCurrency(data.totalCost),
                        style: p5.copyWith(color: red_3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Visibility(
              visible: status == StatusOrder.COMPLETE,
              child: Column(
                children: [
                  const Divider(),
                  MainButton(
                    title: 'Mua lại',
                    event: () {},
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrugstoreMiniCard extends StatelessWidget {
  const DrugstoreMiniCard({super.key, required this.data});
  final DrugstoreEntity data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: borderColor_3,
              )),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(sp16),
            child: Image.asset(
              'assets/imgs/logo.png',
              width: 20,
              height: 20,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: sp4,
        ),
        Text(
          data.name ?? 'Chưa cập nhật',
          style: p5,
        )
      ],
    );
  }
}

class StatusOrderCart extends StatelessWidget {
  const StatusOrderCart({super.key, required this.status});
  final StatusOrder status;

  String getName(StatusOrder status) {
    switch (status) {
      case StatusOrder.NEW:
        return 'Chờ xác nhận';
      case StatusOrder.TRANSPORT:
        return 'Đã xác nhận';
      case StatusOrder.COMPLETE:
        return 'Hoàn thành';
      case StatusOrder.CANCEL:
        return 'Đã huỷ';
      default:
        return 'Chờ xác nhận';
    }
  }

  IconData getIcon(StatusOrder status) {
    switch (status) {
      case StatusOrder.NEW:
        return Icons.watch_later_outlined;
      case StatusOrder.TRANSPORT:
        return Icons.local_shipping_outlined;
      case StatusOrder.COMPLETE:
        return Icons.done_all;
      case StatusOrder.CANCEL:
        return Icons.cancel_outlined;
      default:
        return Icons.watch_later_outlined;
    }
  }

  Color getColor(StatusOrder status) {
    switch (status) {
      case StatusOrder.NEW:
        return greyColor;
      case StatusOrder.TRANSPORT:
        return blue_3;
      case StatusOrder.COMPLETE:
        return mainColor;
      case StatusOrder.CANCEL:
        return red_3;
      default:
        return greyColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          getIcon(status),
          color: getColor(status),
        ),
        const SizedBox(
          width: sp4,
        ),
        Text(
          getName(status),
          style: h6.copyWith(color: getColor(status)),
        )
      ],
    );
  }
}
