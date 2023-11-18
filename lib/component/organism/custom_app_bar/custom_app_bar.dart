import 'package:flutter/material.dart';
import 'package:johannes_demo/constants/color_constants.dart';
import 'package:johannes_demo/constants/fontawesome_icon_constants.dart';
import 'package:johannes_demo/constants/text_constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.leftActionWidget,
    this.title,
    this.titleIcon,
    this.rightActionWidget,
  });

  final Widget? leftActionWidget;
  final String? title;
  final IconData? titleIcon;
  final Widget? rightActionWidget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (leftActionWidget != null)
                leftActionWidget!
              else
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      child: const Icon(
                            FontAwesomeIconData.arrowLeft,
                            size: 18,
                            color: ColorPallet.black,
                          ),
                        ),
                      ),
                    ),
              if (rightActionWidget != null) rightActionWidget!,
            ],
          ),
          if (title != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (titleIcon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(
                      titleIcon,
                      size: 12,
                      color: ColorPallet.black,
                    ),
                  ),
                Text(
                  title!,
                  style: CustomTextStyle.smallBold,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
