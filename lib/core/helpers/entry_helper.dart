import 'package:coconut_chronicles/core/models/entry_model.dart';
import 'package:coconut_chronicles/core/models/selected_entry_model.dart';
import 'package:coconut_chronicles/widgets/dialogues/confirmation_dialogue_builder.dart';
import 'package:flutter/material.dart';

class EntryHelper {
  static EntryModel newEntry() => EntryModel(createdAt: DateTime.now());
  static EntryModel clone(EntryModel entry) => EntryModel.fromJson(entry.toJson());

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

  (String sanitisedSegment, List<(String segment, int index)> hiddenSegments) processParagraph(String paragraph) {
    String sanitised = '';
    List<(String, int)> hiddenSegments = [];
    bool isHidden = false;
    StringBuffer hiddenBuffer = StringBuffer();
    int index = 0;

    // Loop through each character in the original paragraph
    for (int i = 0; i < paragraph.length; i++) {
      // Get the current character
      String char = paragraph[i];

      // If the character is ~, check the next two characters
      if (char == '~') {
        // If the next two characters are also ~, toggle the isHidden flag and skip them
        if (i + 2 < paragraph.length && paragraph[i + 1] == '~' && paragraph[i + 2] == '~') {
          isHidden = !isHidden;
          i += 2;
          continue;
        }
      }

      // If we are in a hidden segment, append the character to the hidden buffer
      if (isHidden) {
        hiddenBuffer.write(char);
      } else {
        // Otherwise, append the character to the sanitised paragraph and increment the index
        sanitised += char;
        index++;
      }

      // If we are at the end of a hidden segment, add the hidden buffer and the index to the hidden list
      // and clear the hidden buffer
      if (isHidden && (i == paragraph.length - 1 || paragraph[i + 1] == '~')) {
        hiddenSegments.add((hiddenBuffer.toString(), index));
        hiddenBuffer.clear();
      }
    }

    return (sanitised, hiddenSegments);
  }
}
