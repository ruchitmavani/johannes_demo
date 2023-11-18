import 'package:flutter/material.dart';
import 'package:johannes_demo/component/atom/scale_button/scale_button.dart';
import 'package:johannes_demo/constants/text_constants.dart';

import '../../../constants/color_constants.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    this.text = '',
    this.icon,
    this.disabled = false,
    required this.onTap,
    this.color,
    this.textStyle,
    this.isLoading = false,
    this.border,
  });

  final String text;
  final IconData? icon;
  final bool disabled;
  final bool isLoading;
  final Color? color;
  final void Function() onTap;
  final TextStyle? textStyle;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return ScaleButton(
      impact: 0.95,
      isDisabled: disabled || isLoading,
      onTap: onTap,
      child: Opacity(
        opacity: disabled ? 0.3 : 1,
        child: Container(
          height: 54,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color ?? ColorPallet.black,
            border: border,
            borderRadius: BorderRadius.circular(8),
          ),
          child: isLoading
              ? const SizedBox(
                  width: 54,
                  height: 54,
                  child: CircularProgressIndicator(color: ColorPallet.black),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      Icon(
                        icon,
                        color: textStyle?.color ?? Colors.white,
                      ),
                      if (text.isNotEmpty) const SizedBox(width: 8),
                    ],
                    Text(
                      text,
                      style: textStyle ??
                          CustomTextStyle.mainBold
                              .copyWith(color: Colors.white),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
