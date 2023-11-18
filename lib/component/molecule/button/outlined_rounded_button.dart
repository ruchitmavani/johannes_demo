import 'package:flutter/material.dart';
import 'package:johannes_demo/constants/color_constants.dart';
import 'package:johannes_demo/constants/text_constants.dart';

class OutlinedRoundedButton extends StatelessWidget {
  const OutlinedRoundedButton(
      {required this.text, super.key, this.onTap, this.color, this.textStyle,});

  final String text;
  final Color? color;
  final void Function()? onTap;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(40),
      child: Container(
        height: 54,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: color ?? ColorPallet.white),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Text(
          text,
          style: textStyle ?? CustomTextStyle.exLargeBold,
        ),
      ),
    );
  }
}
