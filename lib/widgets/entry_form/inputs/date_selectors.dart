import 'package:coconut_chronicles/core/helpers/validator_helper.dart';
import 'package:coconut_chronicles/core/models/selected_entry_model.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/indented_category_text.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/validation_error_text.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class DateSelectors extends StatefulWidget {
  const DateSelectors({super.key});

  @override
  State<DateSelectors> createState() => _DateSelectorsState();
}

class _DateSelectorsState extends State<DateSelectors> {
  // Adhoc values I believe should be sufficient for any journaling.
  static final DateTime _earliestDate = DateTime(2000);
  static final DateTime _latestDate = DateTime.now().add(const Duration(days: 31));

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SelectedEntryModel>(
      builder: (context, child, model) => Column(children: [
        Row(
          children: [
            FormField<DateTime>(
              builder: (state) => Column(
                children: [
                  Row(children: [
                    const IndentedCategoryText(text: 'Date: '),
                    TextButton(
                      onPressed: () => _openDatePicker(currentDate: model.selectedEntry.date, endDate: false),
                      child: Text(model.selectedEntry.safeDate),
                    ),
                  ]),
                  if (state.hasError)
                    ValidationErrorText(
                      errorText: state.errorText!,
                    ),
                ],
              ),
              validator: (_) => ValidatorHelper.emptyDateValidator(model.selectedEntry.date),
            )
          ],
        ),
        Row(children: [
          const IndentedCategoryText(
            text: 'End Date (Optional): ',
          ),
          TextButton(
              onPressed: () => _openDatePicker(currentDate: model.selectedEntry.endDate, endDate: true),
              child: Text(model.selectedEntry.safeEndDate)),
        ]),
      ]),
    );
  }

  Future<void> _openDatePicker({required DateTime? currentDate, required bool endDate}) async {
    var entry = ScopedModel.of<SelectedEntryModel>(context).selectedEntry;
    final DateTime? picked = await showDatePicker(
      context: context,
      helpText: "Date of memory",
      initialDate: currentDate ?? DateTime.now(),
      firstDate: _earliestDate,
      lastDate: _latestDate,
    );

    if (picked != null && picked != currentDate) {
      setState(() {
        if (endDate) {
          entry.updateProperties(endDate: picked);
        } else {
          entry.updateProperties(date: picked);
        }
      });
    }
  }
}
