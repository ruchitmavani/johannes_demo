// Flutter imports:

import 'package:flutter/material.dart';

// Project imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:johannes_demo/component/molecule/button/rounded_button.dart';
import 'package:johannes_demo/constants/color_constants.dart';
import 'package:johannes_demo/constants/text_constants.dart';
import 'package:johannes_demo/helper/modal_helper.dart';

class ErrorModal extends HookConsumerWidget {
  const ErrorModal({
    super.key,
    required this.title,
    required this.description,
    this.primaryButton,
    this.secondaryButton,
    required this.pop,
  });

  final String title;
  final String description;
  final ModalButtonProps? primaryButton;
  final ModalButtonProps? secondaryButton;
  final void Function() pop;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: ColorPallet.background,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              title,
              style: CustomTextStyle.heroTitle,
            ),
          ),
          Text(
            description,
            style: CustomTextStyle.main,
            maxLines: 4,
          ),
          const SizedBox(height: 10),
          RoundedButton(
            text: primaryButton?.label ?? "Dismiss",
            onTap: () async {
              if (primaryButton?.extraAction != null) {
                await primaryButton!.extraAction!();
              }
              pop();
            },
          ),
          const SizedBox(
            height: 5,
          ),
          if (secondaryButton != null)
            Center(
              child: GestureDetector(
                onTap: () async {
                  if (secondaryButton!.extraAction != null) {
                    await secondaryButton!.extraAction!();
                  }
                  pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Text(
                    secondaryButton!.label,
                    style: CustomTextStyle.mainBold.copyWith(
                      color: ColorPallet.subText,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
