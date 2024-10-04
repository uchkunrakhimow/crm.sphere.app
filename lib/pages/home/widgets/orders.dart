import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tedbook/model/response/order_response.dart';
import 'package:tedbook/pages/home/bloc/home_bloc.dart';
import 'package:tedbook/pages/home/widgets/messages.dart';
import 'package:tedbook/pages/home/widgets/contacts_card.dart';
import 'package:tedbook/pages/home/widgets/order_complete_card.dart';
import 'package:tedbook/pages/home/widgets/send_message.dart';
import 'package:tedbook/persistance/base_status.dart';
import 'package:tedbook/persistance/text_style_const.dart';
import 'package:tedbook/utils/color_utils.dart';
import 'package:tedbook/utils/utils.dart';

class OrdersWidget extends StatelessWidget {
  final bool isArchive;

  const OrdersWidget({super.key, required this.isArchive});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (p, c) =>
          p.status.type != c.status.type || c.status.type == StatusType.sent,
      builder: (_, state) {
        if (state.status.type == StatusType.loading)
          return Center(child: CircularProgressIndicator());
        else if ((!isArchive && state.orders?.isNotEmpty == true) ||
            (isArchive && state.archives?.isNotEmpty == true))
          return RefreshIndicator(
            onRefresh: () async {
              debugLog("RefreshIndicator");
              return context.read<HomeBloc>().add(RefreshEvent());
            },
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 12),
              itemBuilder: (_, int index) {
                OrderModel order =
                    isArchive ? state.archives![index] : state.orders![index];
                return _orderItem(
                    isArchive: isArchive, order: order, index: index + 1);
              },
              separatorBuilder: (_, __) => SizedBox(height: 8),
              itemCount: isArchive ? state.archives!.length : state.orders!.length,
            ),
          );
        else {
          return Center(
            child: Text(
              "${isArchive ? "Архивы" : "Заказов"} пока нет",
              style: TextStyleS.s15w600(),
            ),
          );
        }
      },
    );
  }

  _orderItem(
      {required bool isArchive,
      required OrderModel order,
      required int index}) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: ExpansionTile(
            leading: Text(
              "${index < 10 ? "0$index" : "$index"}",
              style: TextStyleS.s14w600(color: AppColor.textGreyColor),
            ),
            title: Text(
              order.fullName ?? "-",
              style: TextStyleS.s15w500(color: AppColor.textColor),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            tilePadding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            childrenPadding: EdgeInsets.only(bottom: 8),
            dense: true,
            shape: Border.all(color: Colors.transparent, width: 0),
            collapsedShape: Border.all(color: Colors.transparent, width: 0),
            children: [
              SizedBox(
                height: isArchive ? 60 : 108,
                child: Stack(
                  children: [
                    if (!isArchive)
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: OrderCompleteCard(
                          orderId: order.id ?? "",
                          paymentType: order.paymentType,
                        ),
                      ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: ContactsCard(
                        address: order.address ?? "-",
                        phone: order.phoneNumber ?? "-",
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              if (order.messages?.isNotEmpty == true)
                Messages(messages: order.messages!),
              if (!isArchive) SendMessage(orderId: order.id ?? ""),
            ],
          ),
        ),
      ],
    );
  }
}
