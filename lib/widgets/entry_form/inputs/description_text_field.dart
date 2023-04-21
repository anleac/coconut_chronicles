import 'package:coconut_chronicles/core/helpers/validator_helper.dart';
import 'package:coconut_chronicles/core/models/selected_entry_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class DescriptionTextField extends StatelessWidget {
  const DescriptionTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SelectedEntryModel>(
        builder: (context, child, model) => TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
                labelText: 'Description of the day(s)',
              ),
              maxLines: 25,
              minLines: 10,
              controller: SelectedEntryModel.of(context).descriptionController,
              onChanged: (value) => model.selectedEntry.updateProperties(description: value),
              textAlignVertical: TextAlignVertical.top,
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
              validator: (value) => ValidatorHelper.emptyTextValidator(value),
            ));
  }
}
