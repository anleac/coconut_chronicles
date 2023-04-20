import 'package:flutter/material.dart';

class ConfirmationDialogueBuilder {
  static Future<bool> showClearEntryForm(BuildContext context) async {
    return await _showConfirmationDialogue(
      context,
      title: "Clear current entry",
      content: "Are you sure you want to clear all data?",
      confirmText: "Clear",
      cancelText: "Cancel",
    );
  }

  static Future<bool> showConfirmUndoChanges(BuildContext context) async {
    return await _showConfirmationDialogue(
      context,
      title: "Undo changes",
      content: "Are you sure you want to undo all changes?",
      confirmText: "Undo",
      cancelText: "Cancel",
    );
  }

  static Future<bool> showClearEncryptionKey(BuildContext context) async {
    return await _showConfirmationDialogue(
      context,
      title: "Clear encryption key",
      content: "Are you sure you want to clear the encryption key?",
      confirmText: "Clear",
      cancelText: "Cancel",
    );
  }

  static Future<bool> _showConfirmationDialogue(BuildContext context,
      {required String title, required String content, required String confirmText, required String cancelText}) async {
    var result = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: [
                TextButton(
                  child: Text(cancelText),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  child: Text(confirmText),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            ));
    return result ?? false;
  }
}
