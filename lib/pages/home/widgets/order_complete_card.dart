import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tedbook/pages/home/bloc/home_bloc.dart';
import 'package:tedbook/pages/home/widgets/payment_type.dart';
import 'package:tedbook/persistance/text_style_const.dart';
import 'package:tedbook/utils/color_utils.dart';
import 'package:tedbook/utils/utils.dart';
import 'package:tedbook/widgets/custom_button.dart';

class OrderCompleteCard extends StatelessWidget {
  final String orderId;
  final String? paymentType;

  const OrderCompleteCard({super.key, required this.orderId, this.paymentType});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showConfirmOrderModal(context,
            orderId: orderId, paymentType: paymentType);
      },
      child: Container(
        margin: EdgeInsets.zero,
        height: 56,
        child: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/icons/complete.svg", height: 20),
              SizedBox(width: 12),
              Text(
                "Завершить",
                style: TextStyleS.s14w600(color: Colors.white),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: AppColor.primaryAppColor,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          border: Border.all(width: 1, color: Color(0xFFDDDDDD)),
        ),
      ),
    );
  }
}

_showConfirmOrderModal(BuildContext context,
        {required String orderId, String? paymentType}) =>
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      backgroundColor: Colors.transparent,
      builder: (_) {
        debugLog("_showConfirmOrderModal");
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PaymentTypeCard(paymentType: paymentType),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(vertical: 36, horizontal: 12),
              // width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: CustomButton(
                      text: "Доставлен",
                      height: 50,
                      textStyle: TextStyleS.s14w600(color: Colors.white),
                      onTap: () => context.read<HomeBloc>().add(
                          PutOrderEvent(orderId: orderId, status: "delivered")),
                    ),
                  ),
                  SizedBox(width: 16),
                  Flexible(
                      child: CustomButton(
                    text: "Клиент отказался",
                    height: 50,
                    textStyle: TextStyleS.s14w600(color: Colors.white),
                    backColor: AppColor.redColor,
                    onTap: () => context.read<HomeBloc>().add(
                        PutOrderEvent(orderId: orderId, status: "decline")),
                  )),
                ],
              ),
              alignment: Alignment.center,
            ),
          ],
        );
      },
    );
