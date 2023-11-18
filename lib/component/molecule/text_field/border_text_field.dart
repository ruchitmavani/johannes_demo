import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:johannes_demo/constants/color_constants.dart';
import 'package:johannes_demo/constants/text_constants.dart';

class BorderTextField extends StatelessWidget {
  const BorderTextField({
    super.key,
    this.hintText = '',
    this.keyboardType,
    this.label,
    this.maxLength,
    this.focusNode,
    this.textCapitalization = TextCapitalization.sentences,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.controller,
    this.textInputAction,
    this.isPassword = false,
    this.readOnly = false,
    this.isEnableInteractiveSelection = true,
    this.prefixIcon,
    this.maxLines=1,
    this.minLines,
    this.contentPadding,
    this.inputFormatters,
    this.isEnable = true,
    this.autoFocus = false,
    this.hintTextColor,
    this.suffixIcon,
    this.onTapOutside,
  });

  final bool autoFocus;
  final String hintText;
  final String? label;
  final TextInputType? keyboardType;
  final int? maxLength;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;
  final TextCapitalization textCapitalization;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final bool isPassword;
  final bool readOnly;
  final bool isEnableInteractiveSelection;
  final bool isEnable;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? minLines;
  final Color? hintTextColor;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(PointerDownEvent)? onTapOutside;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: ColorPallet.black,
      style: CustomTextStyle.main,
      autofocus: autoFocus,
      enabled: isEnable,
      enableInteractiveSelection: isEnableInteractiveSelection,
      readOnly: readOnly,
      controller: controller,
      textCapitalization: textCapitalization,
      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLines: maxLines,
      minLines: minLines,
      focusNode: focusNode,
      onChanged: onChanged,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: textInputAction ?? TextInputAction.done,
      obscureText: isPassword,
      inputFormatters: inputFormatters,
      onFieldSubmitted: onFieldSubmitted,
      onTapOutside: onTapOutside,
      decoration: InputDecoration(
        constraints: const BoxConstraints(minHeight: 60),
        hintText: hintText,
        hintStyle: CustomTextStyle.exSmallBold.copyWith(
          color: hintTextColor ?? ColorPallet.black54,
        ),
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        counterText: '',
        contentPadding: const EdgeInsets.symmetric(horizontal: 18,vertical: 10),
        errorStyle: TextStyle(
          color: Colors.red.shade500,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        errorMaxLines: 1,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(width: 2, color: ColorPallet.grey),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 2, color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            width: 2,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
