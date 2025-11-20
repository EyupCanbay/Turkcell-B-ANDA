import 'package:flutter/material.dart';

class AppSnackBar {
  static void showError(BuildContext context, String message) {
    _show(
      context,
      message,
      Colors.redAccent,
    );
  }

  static void showSuccess(BuildContext context, String message) {
    _show(
      context,
      message,
      Colors.green,
    );
  }

  static void _show(
    BuildContext context,
    String message,
    Color color,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
