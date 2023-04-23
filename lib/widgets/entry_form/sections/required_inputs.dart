import 'package:coconut_chronicles/widgets/entry_form/inputs/country_selector.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/date_selectors.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/description_text_field.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/title_text_field.dart';
import 'package:flutter/material.dart';

class RequiredInputs extends StatelessWidget {
  const RequiredInputs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        TitleTextField(),
        SizedBox(height: 8),
        DateSelectors(),
        Divider(),
        CountrySelector(),
        SizedBox(height: 8),
        DescriptionTextField(),
      ],
    );
  }
}
