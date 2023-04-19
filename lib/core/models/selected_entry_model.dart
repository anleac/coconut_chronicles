import 'package:coconut_chronicles/core/models/entry_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SelectedEntryModel extends Model {
  static SelectedEntryModel of(BuildContext context) => ScopedModel.of<SelectedEntryModel>(context);
  static EntryModel getSelectedEntry(BuildContext context) => of(context).selectedEntry;

  EntryModel _selectedEntry = EntryModel.newEntry();
  EntryModel get selectedEntry => _selectedEntry;

  void selectEntry(EntryModel entry) {
    _selectedEntry = entry;
    notifyListeners();
  }
}
