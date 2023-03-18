import 'package:coconut_chronicles/constants/default_constants.dart';
import 'package:coconut_chronicles/widgets/chip_categories.dart';
import 'package:coconut_chronicles/widgets/country_selector.dart';
import 'package:coconut_chronicles/widgets/date_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ChronicleEntry extends StatefulWidget {
  const ChronicleEntry({Key? key}) : super(key: key);

  @override
  State<ChronicleEntry> createState() => _ChronicleEntryState();
}

class _ChronicleEntryState extends State<ChronicleEntry> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _country = 'No country selected';

  _emptyTextValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(children: [
        TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Captive title',
          ),
          controller: _titleController,
          validator: (value) => _emptyTextValidator(value),
        ),
        const SizedBox(height: 8),
        DateSelector(
          initialDate: _selectedDate,
          firstDate: DateTime(2010),
          lastDate: _selectedDate.add(const Duration(days: 31)),
          onDateChanged: (DateTime date) => _selectedDate = date,
        ),
        CountrySelector(initialCountry: _country, onCountryChanged: (String country) => _country = country),
        const SizedBox(height: 8),
        TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Description of the day',
          ),
          maxLines: null,
          controller: _bodyController,
          minLines: 12,
          textAlignVertical: TextAlignVertical.top,
          keyboardType: TextInputType.multiline,
          textCapitalization: TextCapitalization.sentences,
          validator: (value) => _emptyTextValidator(value),
        ),
        const SizedBox(height: 8),
        Row(children: const [
          SizedBox(
            width: 8,
          ),
          Text(
            'Categories',
          ),
        ]),
        const SizedBox(height: 8),
        const ChipCategories(categories: DefaultConstants.defaultChipSuggestions),
        const SizedBox(height: 8),
        const Divider(),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => {}, // TODO
              child: const Text('Clear'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Saved chronicle entry')),
                  );
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
