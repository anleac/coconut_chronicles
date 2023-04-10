import 'package:coconut_chronicles/core/helpers/validator_helper.dart';
import 'package:coconut_chronicles/core/models/entry_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class DescriptionTextField extends StatelessWidget {
  const DescriptionTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<EntryModel>(
        builder: (context, child, model) => TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description of the day',
              ),
              maxLines: null,
              minLines: 10,
              onChanged: (value) => model.updateProperties(description: value),
              textAlignVertical: TextAlignVertical.top,
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
              validator: (value) => ValidatorHelper.emptyTextValidator(value),
            ));
  }
}
