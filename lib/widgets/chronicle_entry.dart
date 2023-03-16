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
            labelText: 'Title',
          ),
          controller: _titleController,
          validator: (value) => _emptyTextValidator(value),
        ),
        const SizedBox(height: 16),
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
        const SizedBox(height: 16),
        Expanded(
          child: TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Body',
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
      ]),
    );
  }
}
