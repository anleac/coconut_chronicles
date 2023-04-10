import 'package:coconut_chronicles/core/models/entry_model.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/indented_category_text.dart';
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
    return Row(
      children: [
        const IndentedCategoryText(text: 'Country: '),
        ScopedModelDescendant<EntryModel>(
          builder: (context, child, model) => TextButton(
            onPressed: () => _openCountryPicker(),
            child: Text(model.safeCountry),
          ),
        )
      ],
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
          ScopedModel.of<EntryModel>(context).updateProperties(country: country.name);
        })
      },
    );
  }
}
