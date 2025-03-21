import 'package:flutter/material.dart';

class DialogUtil {
  DialogUtil._();

  static final DialogUtil instance = DialogUtil._();

  final _dialogAnimationTween = Tween<double>(begin: 0.97, end: 1);
  final _dialogTransitionDuration = const Duration(milliseconds: 200);

  Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    bool dismissible = true,
    bool useRootNavigator = true,
  }) async {
    return showGeneralDialog<T>(
      context: context,
      barrierLabel: 'Dialog',
      barrierDismissible: dismissible,
      useRootNavigator: useRootNavigator,
      transitionDuration: _dialogTransitionDuration,
      pageBuilder: (context, animation, secondaryAnimation) {
        return child;
      },
      transitionBuilder: (_, animation, __, child) {
        return ScaleTransition(
          scale: _dialogAnimationTween.animate(
            CurvedAnimation(
              curve: Curves.decelerate,
              reverseCurve: Curves.ease,
              parent: animation,
            ),
          ),
          child: child,
        );
      },
    );
  }

  void pop<T>(BuildContext context, [T? result]) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop(result);
    }
  }
}
