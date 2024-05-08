// clipboard_utils.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void copyToClipboardAndShowSnackbar(BuildContext context, String textToCopy) {
  Clipboard.setData(ClipboardData(text: textToCopy)).then(
    (value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Copied to clipboard!'),
          duration: Duration(seconds: 2),
        ),
      );
    },
  ).catchError((error) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Failed to copy to clipboard!'),
        duration: Duration(seconds: 2),
      ),
    );
  });
}
