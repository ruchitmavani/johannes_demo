import 'package:flutter/material.dart';
import 'package:johannes_demo/constants/color_constants.dart';

class ModalOverlay extends ModalRoute<void> {
  ModalOverlay({
    required this.widget,
    this.useDefaultPadding = true,
    this.isDimissible = true,
  });

  final Widget widget;
  final bool useDefaultPadding;
  final bool isDimissible;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 100);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => isDimissible;

  @override
  Color get barrierColor => ColorPallet.black.withOpacity(0.85);

  @override
  String get barrierLabel => '';

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Center(
      child: Padding(
        padding: useDefaultPadding
            ? const EdgeInsets.only(left: 20, right: 20)
            : EdgeInsets.zero,
        child: widget,
      ),
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.02),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }
}
