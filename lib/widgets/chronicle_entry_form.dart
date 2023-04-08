import 'package:coconut_chronicles/constants/default_constants.dart';
import 'package:coconut_chronicles/core/models/entry_model.dart';
import 'package:coconut_chronicles/core/storage/entry_storage.dart';
import 'package:coconut_chronicles/widgets/entry_form_inputs/chip_categories.dart';
import 'package:coconut_chronicles/widgets/entry_form_inputs/country_selector.dart';
import 'package:coconut_chronicles/widgets/entry_form_inputs/date_selector.dart';
import 'package:coconut_chronicles/widgets/dialogues/dialogue_builder.dart';
import 'package:coconut_chronicles/widgets/entry_form_inputs/description_text_field.dart';
import 'package:coconut_chronicles/widgets/entry_form_inputs/title_text_field.dart';
import 'package:flutter/material.dart';

class ChronicleEntryForm extends StatefulWidget {
  const ChronicleEntryForm({Key? key}) : super(key: key);

  @override
  State<ChronicleEntryForm> createState() => _ChronicleEntryFormState();
}

class _ChronicleEntryFormState extends State<ChronicleEntryForm> {
  static final DateTime _defaultDate = DateTime.now();

  final _formKey = GlobalKey<FormState>();
  final EntryModel _entry = EntryModel(date: _defaultDate);

  _saveEntry() async {
    var snackContext = ScaffoldMessenger.of(context);
    await EntryStorage.saveEntry(_entry);
    _clearData();
    snackContext.showSnackBar(
      const SnackBar(content: Text('Saved chronicle entry')),
    );
  }

  _clearData() {
    setState(() {
      _formKey.currentState?.reset();
      _entry.clearAllProperties();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(children: [
        TitleTextField(onTitleChange: (title) => _entry.updateProperties(title: title)),
        const SizedBox(height: 8),
        DateSelector(
          initialDate: _defaultDate,
          firstDate: DateTime(2010),
          lastDate: _defaultDate.add(const Duration(days: 31)),
          onDateChanged: (DateTime date) => _entry.updateProperties(date: date),
        ),
        CountrySelector(onCountryChanged: (String country) => _entry.updateProperties(country: country)),
        const SizedBox(height: 8),
        DescriptionTextField(onDescriptionChange: (description) => _entry.updateProperties(description: description)),
        const SizedBox(height: 8),
        Row(children: const [
          SizedBox(
            width: 8,
          ),
          Text('Categories'),
        ]),
        const SizedBox(height: 8),
        ChipCategories(
            categories: DefaultConstants.defaultChipSuggestions,
            onSelected: (category) => _entry.addCategory(category),
            onDeselected: (category) => _entry.removeCategory(category)),
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
