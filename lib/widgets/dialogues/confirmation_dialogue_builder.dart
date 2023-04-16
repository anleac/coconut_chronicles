import 'package:flutter/material.dart';

class ConfirmationDialogueBuilder {
  static void showConfirmToClearEntryFormDialogue(BuildContext context, {required VoidCallback onConfirm}) {
    showConfirmationDialogue(
      context,
      title: "Clear current entry",
      content: "Are you sure you want to clear all data?",
      confirmText: "Clear",
      cancelText: "Cancel",
      onConfirm: onConfirm,
    );
  }

  static void showConfirmToClearEncryptionKeyDialogue(BuildContext context, {required VoidCallback onConfirm}) {
    showConfirmationDialogue(
      context,
      title: "Clear encryption key",
      content: "Are you sure you want to clear the encryption key?",
      confirmText: "Clear",
      cancelText: "Cancel",
      onConfirm: onConfirm,
    );
  }

  static void showConfirmationDialogue(
    BuildContext context, {
    required String title,
    required String content,
    required String confirmText,
    required String cancelText,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            child: Text(cancelText),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(confirmText),
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
          ),
        ],
      ),
    );
  }
}
