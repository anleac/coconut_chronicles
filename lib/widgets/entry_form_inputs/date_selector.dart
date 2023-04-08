import 'package:coconut_chronicles/core/helpers/format_helper.dart';
import 'package:coconut_chronicles/widgets/entry_form_inputs/indented_category_text.dart';
import 'package:flutter/material.dart';

class DateSelector extends StatefulWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime> onDateChanged;

  const DateSelector({
    Key? key,
    required this.initialDate,
    required this.onDateChanged,
  }) : super(key: key);

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  // Adhoc values I believe should be sufficient for any journaling.
  static final DateTime _earliestDate = DateTime(2000);
  static final DateTime _latestDate = DateTime.now().add(const Duration(days: 31));

  late DateTime _selectedDate = widget.initialDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const IndentedCategoryText(text: 'Date: '),
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
      firstDate: _earliestDate,
      lastDate: _latestDate,
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.onDateChanged(picked);
      });
    }
  }
}
