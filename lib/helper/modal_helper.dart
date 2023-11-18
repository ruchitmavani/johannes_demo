import 'dart:math';

import 'package:flutter/material.dart';
import 'package:johannes_demo/component/organism/error_modal/error_modal.dart';
import 'package:johannes_demo/component/organism/full_screen_overlay.dart/modal_overlay.dart';
import 'package:johannes_demo/component/organism/modal_overlay/modal_overlay.dart';
import 'package:johannes_demo/main.dart';
import 'package:johannes_demo/services/navigator_service/navigator_service.dart';
import 'package:johannes_demo/view/setup/complete_profile/complete_profile_view.dart';

class ModalButtonProps {
  ModalButtonProps({required this.label, this.extraAction});

  String label;
  Future<void> Function()? extraAction;
}

class ErrorModalButton {
  ErrorModalButton({required this.label, this.action});

  String label;
  void Function()? action;
}

class ModalHelper {
  // limit count of error modals to 1
  static int stackCount = 0;

  static DialogRoute<void>? networkRoute;
  static DialogRoute<void>? enteredSpotRoute;

  static void showModal(
    Widget widget, {
    bool isDismissible = true,
    Future<void> Function()? onDismiss,
  }) {
    if (locator.get<NavigatorService>().navigatorKey.currentContext == null) {
      return;
    }

    stackCount++;

    Navigator.of(locator.get<NavigatorService>().navigatorKey.currentContext!)
        .push(
      ModalOverlay(
        isDimissible: isDismissible,
        widget: widget,
      ),
    )
        .then((value) async {
      if (onDismiss != null) {
        await onDismiss();
      }
    });
  }

  static void showFullScreenModal(Widget widget) {
    if (locator.get<NavigatorService>().navigatorKey.currentContext == null) {
      return;
    }

    stackCount++;

    Navigator.of(locator.get<NavigatorService>().navigatorKey.currentContext!)
        .push(
      FullScreenOverlay(
        widget: widget,
      ),
    );
  }

  static void showErrorDialog({
    String? title,
    required String body,
    ModalButtonProps? primaryButton,
    ModalButtonProps? secondaryButton,
  }) {
    if (locator.get<NavigatorService>().navigatorKey.currentContext == null) {
      return;
    }

    stackCount++;

    Navigator.of(locator.get<NavigatorService>().navigatorKey.currentContext!)
        .push(
      ModalOverlay(
        isDimissible: false,
        widget: ErrorModal(
          title: title ?? "Oops!",
          description: body,
          primaryButton: primaryButton,
          secondaryButton: secondaryButton,
          pop: pop,
        ),
      ),
    );
  }

  static Future<void> showNetWorkErrorDialog({
    String? title,
    required String body,
    ModalButtonProps? primaryButton,
    ModalButtonProps? secondaryButton,
  }) async {
    //only show this dialog once
    if (locator.get<NavigatorService>().navigatorKey.currentContext == null ||
        (networkRoute?.isActive ?? false)) {
      return;
    }

    networkRoute = DialogRoute<void>(
      context: locator.get<NavigatorService>().navigatorKey.currentContext!,
      settings: const RouteSettings(name: 'Network-Error'),
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: ErrorModal(
            title: title ?? "Oops!",
            description: body,
            primaryButton: primaryButton,
            secondaryButton: secondaryButton,
            pop: pop,
          ),
        );
      },
    );

    await Navigator.of(
            locator.get<NavigatorService>().navigatorKey.currentContext!)
        .push(networkRoute!);
  }

  static void removeNetworkModal() {
    if (networkRoute != null) {
      if (networkRoute!.isActive) {
        Navigator.of(
                locator.get<NavigatorService>().navigatorKey.currentContext!)
            .removeRoute(networkRoute!);
      }
    }
  }

  static void pop() {
    if (locator.get<NavigatorService>().navigatorKey.currentContext == null) {
      return;
    }
    Navigator.of(locator.get<NavigatorService>().navigatorKey.currentContext!)
        .pop();
    stackCount = max(0, stackCount - 1);
  }

  static void showSystemError() {
    if (locator.get<NavigatorService>().navigatorKey.currentContext == null ||
        stackCount >= 1) {
      return;
    }

    stackCount++;

    showErrorDialog(
        title: "Something went wrong!",
        body: "there is some issue on our side, we are working hard on it");
  }
}
