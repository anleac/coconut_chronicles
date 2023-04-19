import 'package:coconut_chronicles/core/helpers/validator_helper.dart';
import 'package:coconut_chronicles/core/models/selected_entry_model.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/indented_category_text.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/validation_error_text.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CountrySelector extends StatefulWidget {
  const CountrySelector({Key? key}) : super(key: key);

  @override
  State<CountrySelector> createState() => _CountrySelectorState();
}

class _CountrySelectorState extends State<CountrySelector> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SelectedEntryModel>(
      builder: (context, child, model) => FormField<String>(
        builder: (state) => Column(children: [
          Row(
            children: [
              const IndentedCategoryText(text: 'Country: '),
              TextButton(
                onPressed: () => _openCountryPicker(),
                child: Text(model.selectedEntry.safeCountry),
              ),
            ],
          ),
          if (state.hasError)
            ValidationErrorText(
              errorText: state.errorText!,
            ),
        ]),
        validator: (_) => ValidatorHelper.emptyCountryValidator(model.selectedEntry.country),
      ),
    );
  }

  _openCountryPicker() async {
    showCountryPicker(
      context: context,
      searchAutofocus: true,
      countryListTheme: const CountryListThemeData(
        flagSize: 25,
        textStyle: TextStyle(fontSize: 16),
        bottomSheetHeight: 500,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        inputDecoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Start typing to search',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
      ),
      onSelect: (Country country) => {
        setState(() {
          ScopedModel.of<SelectedEntryModel>(context).selectedEntry.updateProperties(country: country.name);
        })
      },
    );
  }
}
