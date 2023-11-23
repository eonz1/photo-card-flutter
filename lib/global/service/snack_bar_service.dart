import 'package:flutter/material.dart';

import 'global_keys.dart';

class SnackBarService {
  void show(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      backgroundColor: Colors.indigoAccent,
    );
    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }

  void showError(String message, {Duration? duration}) {
    final snackBar = SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      duration: duration ?? const Duration(minutes: 1),
      showCloseIcon: true,
      backgroundColor: Colors.red,
    );
    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }
}
