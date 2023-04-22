import 'package:coconut_chronicles/core/models/entry_model.dart';
import 'package:coconut_chronicles/core/models/selected_entry_model.dart';
import 'package:coconut_chronicles/widgets/dialogues/confirmation_dialogue_builder.dart';
import 'package:flutter/material.dart';

class SelectedEntryHelper {
  // Helper function to ensure that the user only navigates if they have no active changes, or willing to lose them.
  static Future<bool> safeSelectEntry(BuildContext context, EntryModel model) async {
    var selectedEntryModel = SelectedEntryModel.of(context);
    var canSelect =
        !selectedEntryModel.haveActiveChanges() || await ConfirmationDialogueBuilder.showConfirmDiscardChanges(context);

    if (canSelect) {
      selectedEntryModel.selectEntry(model);
    }

    return canSelect;
  }
}
