import 'package:coconut_chronicles/core/models/entry_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SelectedEntryModel extends Model {
  static SelectedEntryModel of(BuildContext context) => ScopedModel.of<SelectedEntryModel>(context);
  static EntryModel getSelectedEntry(BuildContext context) => of(context).selectedEntry;

  EntryModel _selectedEntry = EntryModel.newEntry();
  EntryModel get selectedEntry => _selectedEntry;

  // Global variables related to the entry form
  final GlobalKey<FormState> _entryFormKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  GlobalKey<FormState> get entryFormKey => _entryFormKey;
  TextEditingController get titleController => _titleController;
  TextEditingController get descriptionController => _descriptionController;

  void selectEntry(EntryModel entry) {
    if (_selectedEntry.fileSaveName == entry.fileSaveName) return;

    // Clone to avoid modifying the original entry
    _selectedEntry = EntryModel.clone(entry);

    _titleController.text = entry.title ?? '';
    _descriptionController.text = entry.description ?? '';

    notifyListeners();
  }

  void clearEntryForm() {
    selectEntry(EntryModel.newEntry());
  }
}
