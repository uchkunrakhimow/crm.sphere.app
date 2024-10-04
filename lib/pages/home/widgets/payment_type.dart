import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tedbook/utils/color_utils.dart';

class PaymentTypeCard extends StatelessWidget {
  final String? paymentType;

  const PaymentTypeCard({super.key, this.paymentType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      margin: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _paymentTypeItem(
            title: "Платежные системы",
            iconPath: "archive",
            isSelected: paymentType == "payment systems",
          ),
          _paymentTypeItem(
            title: "Наличные",
            iconPath: "cash",
            isSelected: paymentType == "cash",
          ),
          _paymentTypeItem(
            title: "Карта",
            iconPath: "card",
            isSelected: paymentType == "card",
          ),
        ],
      ),
      alignment: Alignment.center,
    );
  }

  Widget _paymentTypeItem({
    required String title,
    required String iconPath,
    bool isSelected = false,
  }) =>
      SizedBox(
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 48,
              child: SvgPicture.asset(
                "assets/icons/$iconPath.svg",
                height: 48,
                color: isSelected ? AppColor.orangeColor : AppColor.blackColor,
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                decoration: isSelected ? TextDecoration.underline : null,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
}
