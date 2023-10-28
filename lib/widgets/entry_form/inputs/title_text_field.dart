import 'package:coconut_chronicles/core/helpers/validator_helper.dart';
import 'package:coconut_chronicles/core/models/selected_entry_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class TitleTextField extends StatelessWidget {
  const TitleTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SelectedEntryModel>(builder: (context, child, model) {
      return TextFormField(
        autofocus: true,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Captivating title',
        ),
        controller: SelectedEntryModel.of(context).titleController,
        onChanged: (value) => model.selectedEntry.updateProperties(title: value),
        validator: (value) => ValidatorHelper.emptyTextValidator(value),
        textCapitalization: TextCapitalization.sentences,
      );
    });
  }
}
