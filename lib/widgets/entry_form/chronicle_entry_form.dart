import 'package:coconut_chronicles/core/models/selected_entry_model.dart';
import 'package:coconut_chronicles/widgets/entry_form/sections/optional_inputs.dart';
import 'package:coconut_chronicles/widgets/entry_form/sections/required_inputs.dart';
import 'package:coconut_chronicles/widgets/entry_form/sections/submission_buttons.dart';
import 'package:flutter/material.dart';

class ChronicleEntryForm extends StatelessWidget {
  const ChronicleEntryForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: SelectedEntryModel.of(context).entryFormKey,
      child: ListView(children: const [
        SizedBox(height: 4),
        RequiredInputs(),
        SizedBox(height: 8),
        OptionalInputs(),
        Divider(height: 32),
        SubmissionButtons(),
      ]),
    );
  }
}
