import 'package:coconut_chronicles/core/helpers/format_helper.dart';
import 'package:coconut_chronicles/core/models/entry_model.dart';
import 'package:coconut_chronicles/widgets/entry_form_inputs/indented_category_text.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class DateSelector extends StatefulWidget {
  const DateSelector({Key? key}) : super(key: key);

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  // Adhoc values I believe should be sufficient for any journaling.
  static final DateTime _earliestDate = DateTime(2000);
  static final DateTime _latestDate = DateTime.now().add(const Duration(days: 31));

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const IndentedCategoryText(text: 'Date: '),
        TextButton(
            onPressed: () => _openDatePicker(),
            child: ScopedModelDescendant<EntryModel>(
                builder: (context, child, model) => Text(FormatHelper.formatDate(model.date)))),
      ],
    );
  }

  Future<void> _openDatePicker() async {
    var entry = ScopedModel.of<EntryModel>(context);
    final DateTime? picked = await showDatePicker(
      context: context,
      helpText: "Date of memory",
      initialDate: entry.date,
      firstDate: _earliestDate,
      lastDate: _latestDate,
    );

    if (picked != null && picked != entry.date) {
      entry.updateProperties(date: picked);
    }
  }
}
