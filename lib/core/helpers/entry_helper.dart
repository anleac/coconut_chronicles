import 'package:coconut_chronicles/constants/storage_constants.dart';
import 'package:coconut_chronicles/core/models/entry_model.dart';
import 'package:coconut_chronicles/core/models/selected_entry_model.dart';
import 'package:coconut_chronicles/core/storage/hidden_segment.dart';
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

  // The hidden segments are defined by StorageConstants.hiddenSegmentStartTag and StorageConstants.hiddenSegmentEndTag
  static (String sanitisedSegment, List<HiddenSegment> hiddenSegments) processParagraph(String paragraph) {
    // Initialize an empty list of hidden segments
    List<HiddenSegment> hiddenSegments = [];
    var sanitisedSegment = StringBuffer();
    bool isHidden = false;

    // Initialize a string buffer for the current hidden segment
    var hiddenSegment = StringBuffer();

    // Initialize a counter for the index of the hidden segment in the sanitised paragraph
    int hiddenIndex = 0;

    for (int i = 0; i < paragraph.length; i++) {
      // Get the current character
      String char = paragraph[i];

      // If we encounter the start tag of a hidden segment, set the flag to true and store the index
      if (char == StorageConstants.hiddenSegmentStartTag[0] &&
          paragraph.startsWith(StorageConstants.hiddenSegmentStartTag, i)) {
        isHidden = true;
        hiddenIndex = sanitisedSegment.length;
        // Skip the rest of the tag
        i += StorageConstants.hiddenSegmentStartTag.length - 1;
      }
      // If we encounter the end tag of a hidden segment, set the flag to false and add the hidden segment to the list
      else if (char == StorageConstants.hiddenSegmentEndTag[0] &&
          paragraph.startsWith(StorageConstants.hiddenSegmentEndTag, i)) {
        isHidden = false;
        hiddenSegments.add(HiddenSegment(hiddenSegment.toString(), hiddenIndex));
        // Clear the hidden segment buffer
        hiddenSegment.clear();
        // Skip the rest of the tag
        i += StorageConstants.hiddenSegmentEndTag.length - 1;
      }
      // If we are inside a hidden segment, append the character to the hidden segment buffer
      else if (isHidden) {
        hiddenSegment.write(char);
      }
      // If we are not inside a hidden segment, append the character to the sanitised paragraph buffer
      else {
        sanitisedSegment.write(char);
      }
    }

    // Return the sanitised paragraph and the list of hidden segments as a tuple
    return (sanitisedSegment.toString(), hiddenSegments);
  }
}
