import 'package:coconut_chronicles/constants/default_constants.dart';
import 'package:coconut_chronicles/core/models/selected_entry_model.dart';
import 'package:coconut_chronicles/core/storage/entry_storage.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/chip_categories.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/country_selector.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/date_selectors.dart';
import 'package:coconut_chronicles/widgets/dialogues/confirmation_dialogue_builder.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/description_text_field.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/indented_category_text.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/title_text_field.dart';
import 'package:flutter/material.dart';

class ChronicleEntryForm extends StatefulWidget {
  const ChronicleEntryForm({Key? key}) : super(key: key);

  @override
  State<ChronicleEntryForm> createState() => _ChronicleEntryFormState();
}

class _ChronicleEntryFormState extends State<ChronicleEntryForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(children: [
        const SizedBox(height: 4),
        const TitleTextField(),
        const SizedBox(height: 8),
        const DateSelectors(),
        const Divider(),
        const CountrySelector(),
        const SizedBox(height: 8),
        const DescriptionTextField(),
        const SizedBox(height: 8),
        const IndentedCategoryText(text: 'Categories'),
        const SizedBox(height: 8),
        const ChipCategories(categories: DefaultConstants.defaultChipSuggestions),
        const Divider(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () =>
                  ConfirmationDialogueBuilder.showConfirmToClearEntryFormDialogue(context, onConfirm: _clearData),
              child: const Text('Clear'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _saveEntry();
                }
              },
              child: const Text('Save'),
            ),
            const SizedBox(
              width: 8,
            ),
          ],
        ),
      ]),
    );
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

  _clearData() {
    var entry = SelectedEntryModel.getSelectedEntry(context);
    if (entry.isNewEntry) {
      entry.clearProperties();
    }

    _formKey.currentState?.reset();
  }
}
