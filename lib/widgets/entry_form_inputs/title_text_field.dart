import 'package:coconut_chronicles/core/helpers/validator_helper.dart';
import 'package:coconut_chronicles/core/models/entry_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class TitleTextField extends StatelessWidget {
  const TitleTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<EntryModel>(
        builder: (context, child, model) => TextFormField(
              autofocus: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Captivating title',
              ),
              initialValue: model.title,
              onChanged: (value) => model.updateProperties(title: value),
              validator: (value) => ValidatorHelper.emptyTextValidator(value),
            ));
  }
}
