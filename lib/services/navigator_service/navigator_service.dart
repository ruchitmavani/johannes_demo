
import 'package:flutter/material.dart';

class NavigatorService {
  final navigatorKey = GlobalKey<NavigatorState>();

  Future<void> push(Widget page) async {
    await navigatorKey.currentState?.push(
      MaterialPageRoute<void>(
        builder: (context) => page,
      ),
    );
  }

  Future<void> pushReplacement(Widget page) async {
    await navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute<void>(
        builder: (context) => page,
      ),
    );
  }

  Future<void> popUntilFirst() async {
    navigatorKey.currentState?.popUntil((route) => route.isFirst);
  }

  Future<void> goBack() async {
    if (navigatorKey.currentState?.canPop() ?? false) {
      navigatorKey.currentState?.pop();
    }
  }

  Future<void> removeAllAndPush(Widget page) async {
    await navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute<void>(
        builder: (context) => page,
      ),
          (route) => false,
    );
  }
}
