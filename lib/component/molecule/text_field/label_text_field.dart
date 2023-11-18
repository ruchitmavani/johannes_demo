import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:johannes_demo/constants/color_constants.dart';
import 'package:johannes_demo/constants/text_constants.dart';

class LabelTextField extends StatefulWidget {
  const LabelTextField({
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
    this.showEye = false,
    this.readOnly = false,
    this.isEnableInteractiveSelection = true,
    this.prefixIcon,
    this.maxLines = 1,
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
  final bool showEye;
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
  State<LabelTextField> createState() => _LabelTextFieldState();
}

class _LabelTextFieldState extends State<LabelTextField> {
  late final FocusNode _focusNode = widget.focusNode ?? FocusNode();
  bool textEditHasFocus = false;
  late bool isPassword = widget.isPassword;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        textEditHasFocus = _focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          TextFormField(
            cursorColor: ColorPallet.black,
            style: textEditHasFocus
                ? CustomTextStyle.small.copyWith(color: ColorPallet.black)
                : CustomTextStyle.small,
            autofocus: widget.autoFocus,
            enabled: widget.isEnable,
            enableInteractiveSelection: widget.isEnableInteractiveSelection,
            readOnly: widget.readOnly,
            controller: widget.controller,
            textCapitalization: widget.textCapitalization,
            keyboardType: widget.keyboardType,
            maxLength: widget.maxLength,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            focusNode: _focusNode,
            onChanged: widget.onChanged,
            validator: widget.validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: widget.textInputAction ?? TextInputAction.done,
            obscureText: isPassword,
            inputFormatters: widget.inputFormatters,
            onFieldSubmitted: widget.onFieldSubmitted,
            onTapOutside: widget.onTapOutside,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: CustomTextStyle.exSmallBold.copyWith(
                color: widget.hintTextColor ?? ColorPallet.subText,
              ),
              alignLabelWithHint: true,
              //using stack because it does not align above the prefix icon(ref: https://stackoverflow.com/q/70332783/15225566)
              floatingLabelBehavior: FloatingLabelBehavior.never,
              floatingLabelAlignment: FloatingLabelAlignment.start,
              counterText: '',
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              errorStyle: CustomTextStyle.exSmallBold.copyWith(
                color: ColorPallet.black,
              ),
              prefixIcon: widget.prefixIcon,
              prefixIconColor: MaterialStateColor.resolveWith(
                (states) => states.contains(MaterialState.focused)
                    ? ColorPallet.black
                    : ColorPallet.textFiled,
              ),
              suffixIcon: widget.suffixIcon ??
                  (widget.showEye
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              isPassword = !isPassword;
                            });
                          },
                          child: isPassword
                              ? const Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: ColorPallet.textFiled,
                                  size: 18,
                                )
                              : const Icon(
                                  Icons.visibility_off,
                                  color: ColorPallet.textFiled,
                                  size: 18,
                                ),
                        )
                      : null),
              errorMaxLines: 1,
              // labelText: widget.label,
              floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                  (Set<MaterialState> states) {
                return states.contains(MaterialState.focused)
                    ? CustomTextStyle.smallBold
                        .copyWith(color: ColorPallet.black)
                    : CustomTextStyle.smallBold
                        .copyWith(color: ColorPallet.textFiled);
              }),
              focusColor: ColorPallet.black,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(width: 2, color: ColorPallet.textFiled),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(width: 2, color: ColorPallet.textFiled),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(width: 2, color: ColorPallet.black),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                    width: 2, color: ColorPallet.subText.withOpacity(0.2)),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(width: 2, color: ColorPallet.black),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  width: 2,
                ),
              ),
            ),
          ),
          if (widget.label != null)
            Positioned(
              top: -7,
              left: 15,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 3),
                decoration: const BoxDecoration(color: ColorPallet.background),
                child: Text(
                  widget.label ?? '',
                  style: textEditHasFocus
                      ? CustomTextStyle.exSmallBold
                          .copyWith(color: ColorPallet.black)
                      : CustomTextStyle.exSmallBold
                          .copyWith(color: ColorPallet.textFiled),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
