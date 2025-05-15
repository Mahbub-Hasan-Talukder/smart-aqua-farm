import 'package:flutter/material.dart';

class AppAlerts {
  static void showSnackBar({
    required BuildContext context,
    required String message,
    required bool isError,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    Color backgroundColor = isError ? colorScheme.error : colorScheme.primary;
    Color textColor = Colors.white;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: textColor)),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
