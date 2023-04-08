import 'package:coconut_chronicles/constants/default_constants.dart';
import 'package:coconut_chronicles/core/models/entry_model.dart';
import 'package:coconut_chronicles/core/storage/entry_storage.dart';
import 'package:coconut_chronicles/widgets/entry_form_inputs/chip_categories.dart';
import 'package:coconut_chronicles/widgets/entry_form_inputs/country_selector.dart';
import 'package:coconut_chronicles/widgets/entry_form_inputs/date_selector.dart';
import 'package:coconut_chronicles/widgets/dialogues/dialogue_builder.dart';
import 'package:coconut_chronicles/widgets/entry_form_inputs/description_text_field.dart';
import 'package:coconut_chronicles/widgets/entry_form_inputs/indented_category_text.dart';
import 'package:coconut_chronicles/widgets/entry_form_inputs/title_text_field.dart';
import 'package:flutter/material.dart';

class ChronicleEntryForm extends StatefulWidget {
  final EntryModel entry;
  final bool newEntry;

  const ChronicleEntryForm({Key? key, required this.entry, required this.newEntry}) : super(key: key);

  @override
  State<ChronicleEntryForm> createState() => _ChronicleEntryFormState();
}

class _ChronicleEntryFormState extends State<ChronicleEntryForm> {
  final _formKey = GlobalKey<FormState>();

  _saveEntry() async {
    var snackContext = ScaffoldMessenger.of(context);
    await EntryStorage.saveEntry(widget.entry);
    _clearData();
    snackContext.showSnackBar(
      const SnackBar(content: Text('Saved chronicle entry')),
    );
  }

  _clearData() {
    setState(() {
      _formKey.currentState?.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(children: [
        TitleTextField(onTitleChange: (title) => widget.entry.updateProperties(title: title)),
        const SizedBox(height: 8),
        DateSelector(
          initialDate: widget.entry.date,
          onDateChanged: (DateTime date) => widget.entry.updateProperties(date: date),
        ),
        CountrySelector(onCountryChanged: (String country) => widget.entry.updateProperties(country: country)),
        const SizedBox(height: 8),
        DescriptionTextField(
            onDescriptionChange: (description) => widget.entry.updateProperties(description: description)),
        const SizedBox(height: 8),
        const IndentedCategoryText(text: 'Categories'),
        const SizedBox(height: 8),
        ChipCategories(
            categories: DefaultConstants.defaultChipSuggestions,
            onSelected: (category) => widget.entry.addCategory(category),
            onDeselected: (category) => widget.entry.removeCategory(category)),
        const SizedBox(height: 8),
        const Divider(),
        const SizedBox(height: 8),
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
}
