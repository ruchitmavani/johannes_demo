import 'package:flutter/material.dart';
import 'package:johannes_demo/component/atom/scale_button/scale_button.dart';
import 'package:johannes_demo/constants/color_constants.dart';
import 'package:johannes_demo/constants/fontawesome_icon_constants.dart';
import 'package:johannes_demo/constants/text_constants.dart';
import 'package:johannes_demo/main.dart';
import 'package:johannes_demo/services/navigator_service/navigator_service.dart';

class GoBackButton extends StatelessWidget {
  const GoBackButton({super.key, this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ScaleButton(
      onTap: () {
        if (onTap != null) {
          onTap!();
        } else {
          locator<NavigatorService>().goBack();
        }
      },
      child: Row(
        children: [
          const Icon(
            FontAwesomeIconData.arrowLeft,
            size: 18,
            color: ColorPallet.black,
          ),
          const SizedBox(width: 8),
          Text('Back', style: CustomTextStyle.main),
        ],
      ),
    );
  }
}
