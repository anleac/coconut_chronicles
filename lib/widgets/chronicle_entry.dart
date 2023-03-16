import 'package:coconut_chronicles/constants/default_constants.dart';
import 'package:coconut_chronicles/widgets/chip_categories.dart';
import 'package:flutter/material.dart';

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

  _openDatePicker() async {
    var result = await showDatePicker(
      context: context,
      helpText: "Date of memory",
      initialDate: _selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (result != null) {
      setState(() {
        _selectedDate = result;
      });
    }
  }

  _emptyTextValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  _formatDate() {
    return "${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}";
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Captive title',
          ),
          controller: _titleController,
          validator: (value) => _emptyTextValidator(value),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const SizedBox(
              width: 8,
            ),
            const Text("Date: "),
            TextButton(
              onPressed: () => _openDatePicker(),
              child: Text(_formatDate()),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Description of the day',
            ),
            maxLines: null,
            controller: _bodyController,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
            keyboardType: TextInputType.multiline,
            textCapitalization: TextCapitalization.sentences,
            validator: (value) => _emptyTextValidator(value),
          ),
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
