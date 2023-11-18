import 'dart:async';

import 'package:flutter/foundation.dart';

///Debouncing is needed when there is a possibility of multiple calls to a method being made within
///a short duration of each other, and it's desirable that only the last of those calls actually invoke
///the target method.

/// So basically each call starts a timer, and if another call happens before the timer executes, the timer is
/// reset and starts waiting for the desired duration again. When the timer finally does time out, the target
/// method is invoked.
///
///for more https://stackoverflow.com/questions/51791501/how-to-debounce-textfield-onchange-in-dart

class Debouncer {
  Debouncer({required this.milliseconds});

  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  void run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
