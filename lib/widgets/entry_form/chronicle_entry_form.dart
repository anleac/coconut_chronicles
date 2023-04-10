import 'package:coconut_chronicles/constants/default_constants.dart';
import 'package:coconut_chronicles/widgets/entry_form/bottom_bar/new_entry_options.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/chip_categories.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/country_selector.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/date_selector.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/description_text_field.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/indented_category_text.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/title_text_field.dart';
import 'package:flutter/material.dart';

class ChronicleEntryForm extends StatefulWidget {
  const ChronicleEntryForm({Key? key}) : super(key: key);

  @override
  State<ChronicleEntryForm> createState() => _ChronicleEntryFormState();
}

class _ChronicleEntryFormState extends State<ChronicleEntryForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(children: [
        const SizedBox(height: 4),
        const TitleTextField(),
        const SizedBox(height: 8),
        const DateSelector(),
        const CountrySelector(),
        const SizedBox(height: 8),
        const DescriptionTextField(),
        const SizedBox(height: 8),
        const IndentedCategoryText(text: 'Categories'),
        const SizedBox(height: 8),
        const ChipCategories(categories: DefaultConstants.defaultChipSuggestions),
        const Divider(height: 32),
        NewEntryOptions(formKey: _formKey),
      ]),
    );
  }
}
