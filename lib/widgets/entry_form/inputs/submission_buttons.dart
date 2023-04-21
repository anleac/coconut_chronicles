import 'package:coconut_chronicles/core/helpers/entry_helper.dart';
import 'package:coconut_chronicles/core/models/entry_model.dart';
import 'package:coconut_chronicles/core/models/selected_entry_model.dart';
import 'package:coconut_chronicles/core/storage/entry_storage.dart';
import 'package:coconut_chronicles/widgets/dialogues/confirmation_dialogue_builder.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SubmissionButtons extends StatefulWidget {
  const SubmissionButtons({Key? key}) : super(key: key);

  @override
  State<SubmissionButtons> createState() => _SubmissionButtonsState();
}

class _SubmissionButtonsState extends State<SubmissionButtons> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SelectedEntryModel>(builder: (context, child, model) {
      return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Wrap(
            alignment: WrapAlignment.end,
            spacing: 8,
            children: [
              if (!model.isNewEntry)
                TextButton(
                  onPressed: () => _deleteEntry(),
                  child: const Text('Delete entry'),
                ),
              if (!model.isNewEntry)
                TextButton(
                  onPressed: () => EntryHelper.safeSelectEntry(context, EntryModel.newEntry()),
                  child: const Text('New entry'),
                ),
              TextButton(
                onPressed: () => _clearData(),
                child: Text(model.isNewEntry ? 'Clear' : 'Undo changes'),
              ),
              TextButton(
                onPressed: () {
                  if (model.entryFormKey.currentState!.validate()) {
                    _saveEntry();
                  }
                },
                child: Text(model.isNewEntry ? 'Save entry' : 'Update entry'),
              ),
            ],
          ));
    });
  }

  _deleteEntry() async {
    var selectedModel = SelectedEntryModel.of(context);
    var result = await ConfirmationDialogueBuilder.showConfirmDeleteEntry(context);
    if (result) {
      await EntryStorage.deleteEntry(selectedModel.selectedEntry);
      selectedModel.resetEntryForm();
    }
  }

  _saveEntry() async {
    var snackContext = ScaffoldMessenger.of(context);
    bool success = await EntryStorage.saveEntry(SelectedEntryModel.getSelectedEntry(context));
    if (success) {
      _clearData();
      snackContext.showSnackBar(
        const SnackBar(content: Text('Saved chronicle entry')),
      );
    } else {
      snackContext.showSnackBar(
        const SnackBar(content: Text('Error saving chronicle entry')),
      );
    }
  }

  _clearData() async {
    var selectedModel = SelectedEntryModel.of(context);
    var clearDialogue = selectedModel.isNewEntry
        ? ConfirmationDialogueBuilder.showClearEntryForm(context)
        : ConfirmationDialogueBuilder.showConfirmUndoChanges(context);

    var result = await clearDialogue;
    if (result) {
      selectedModel.resetEntryForm();
    }
  }
}
