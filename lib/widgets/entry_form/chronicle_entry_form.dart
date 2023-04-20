import 'package:coconut_chronicles/constants/default_constants.dart';
import 'package:coconut_chronicles/core/models/selected_entry_model.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/chip_categories.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/country_selector.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/date_selectors.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/description_text_field.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/indented_category_text.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/submission_buttons.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/title_text_field.dart';
import 'package:flutter/material.dart';

class ChronicleEntryForm extends StatelessWidget {
  const ChronicleEntryForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: SelectedEntryModel.of(context).entryFormKey,
      child: ListView(children: const [
        SizedBox(height: 4),
        TitleTextField(),
        SizedBox(height: 8),
        DateSelectors(),
        Divider(),
        CountrySelector(),
        SizedBox(height: 8),
        DescriptionTextField(),
        SizedBox(height: 8),
        IndentedCategoryText(text: 'Categories'),
        SizedBox(height: 8),
        ChipCategories(categories: DefaultConstants.defaultChipSuggestions),
        Divider(height: 32),
        SubmissionButtons(),
      ]),
    );
  }
}
