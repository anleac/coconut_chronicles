import 'package:coconut_chronicles/constants/default_constants.dart';
import 'package:coconut_chronicles/core/models/entry_model.dart';
import 'package:coconut_chronicles/core/storage/entry_storage.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/chip_categories.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/country_selector.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/date_selector.dart';
import 'package:coconut_chronicles/widgets/dialogues/dialogue_builder.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/description_text_field.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/indented_category_text.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/title_text_field.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

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
        const DateSelector(),
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
              onPressed: () => DialogueBuilder.showConfirmToClearDialogue(context, onConfirm: _clearData),
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
    await EntryStorage.saveEntry(ScopedModel.of<EntryModel>(context));
    _clearData();
    snackContext.showSnackBar(
      const SnackBar(content: Text('Saved chronicle entry')),
    );
  }

  _clearData() {
    setState(() {
      var entry = ScopedModel.of<EntryModel>(context);
      if (entry.isNewEntry) {
        entry.clearProperties();
      }
    });
  }
}
