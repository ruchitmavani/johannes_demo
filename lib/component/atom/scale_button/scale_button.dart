import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ScaleButton extends HookConsumerWidget {
  const ScaleButton({
    required this.child,
    super.key,
    this.isDisabled = false,
    this.onTap,
    this.onTapUp,
    this.onTapDown,
    this.onLongPressStart,
    this.onLongPress,
    this.onLongPressEnd,
    this.impact = 0.9,
  });

  final Widget child;

  /// onTap and onTapUp is called at the same
  /// the difference is that onTapUp includes pointer details
  final void Function()? onTap;
  final void Function(TapUpDetails details)? onTapUp;

  final void Function(TapDownDetails details)? onTapDown;
  final void Function(LongPressStartDetails details)? onLongPressStart;
  final void Function()? onLongPress;
  final void Function(LongPressEndDetails details)? onLongPressEnd;
  final bool? isDisabled;
  final double? impact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOnLongPressStarted = useState<bool>(false);
    final isTapped = useState<bool>(false);

    return Transform.scale(
      scale: isTapped.value && isDisabled == false ? impact : 1,
      child: GestureDetector(
        // the order of event
        // single tap: onTapDown, onTapUp, (onTap)
        // or onTapDown, onTapCancel (when the user shifts their finger after a tap and does not complete the tap)
        // long press: onTapDown, onTapCancel, onLongPressStart, onLongPress, (onLongPressMoveUpdate), onLongPressEnd, (onLongPressUp)

        // not sure the difference between 'onLongPressEnd' and 'onLongPressUp'

        onTapDown: (details) {
          if (isDisabled ?? false) {
            return;
          }
          if (onTapDown != null) {
            HapticFeedback.selectionClick();
            onTapDown!(details);
          }
          isTapped.value = true;
        },

        onTapCancel: () {
          Future.delayed(const Duration(milliseconds: 50), () {
            if (!isOnLongPressStarted.value) {
              if (context.mounted) {
                isTapped.value = false;
              }
            }
          });
        },
        onTap: () {
          if (isDisabled ?? false) {
            return;
          }
          if (onTap != null) {
            HapticFeedback.selectionClick();
            onTap!();
          }
        },
        onTapUp: (details) {
          if (onTapUp != null) {
            onTapUp?.call(details);
          }
          Future.delayed(const Duration(milliseconds: 50), () {
            if (context.mounted) {
              isTapped.value = false;
            }
          });
        },

        onLongPressStart: (details) {
          if (isDisabled ?? false) {
            return;
          }
          isOnLongPressStarted.value = true;
          if (onLongPressStart != null) {
            onLongPressStart?.call(details);
          }
        },
        onLongPress: () {
          if (isDisabled ?? false) {
            return;
          }
          if (onLongPress != null) {
            onLongPress?.call();
          }
        },
        onLongPressEnd: (details) {
          if (onLongPressEnd != null) {
            onLongPressEnd?.call(details);
          }
          isTapped.value = false;
        },
        child: child,
      ),
    );
  }
}
