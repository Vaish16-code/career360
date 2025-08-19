import 'package:flutter/material.dart';

/// Show a loading dialog with a spinner and optional message
Future<void> showLoadingDialog(BuildContext context, {String? message}) async {
  await showDialog(
    context: context,
    barrierDismissible: false, // User cannot tap outside to dismiss
    builder: (_) => PopScope(
      canPop: false, // Prevents back navigation
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 26,
                height: 26,
                child: CircularProgressIndicator(strokeWidth: 3),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: Text(
                  message ?? "Please wait...",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

/// Hide the loading dialog
void hideLoadingDialog(BuildContext context) {
  if (Navigator.of(context, rootNavigator: true).canPop()) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
