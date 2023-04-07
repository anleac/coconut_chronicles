import 'package:coconut_chronicles/core/helpers/format_helper.dart';
import 'package:flutter/material.dart';

class DateSelector extends StatefulWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTime> onDateChanged;

  const DateSelector({
    Key? key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onDateChanged,
  }) : super(key: key);

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  late DateTime _selectedDate = widget.initialDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 8,
        ),
        const Text("Date: "),
        TextButton(
          onPressed: () => _openDatePicker(),
          child: Text(FormatHelper.formatDate(_selectedDate)),
        ),
      ],
    );
  }

  Future<void> _openDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      helpText: "Date of memory",
      initialDate: _selectedDate,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.onDateChanged(picked);
      });
    }
  }
}
