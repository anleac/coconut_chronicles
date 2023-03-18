import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class CountrySelector extends StatefulWidget {
  final ValueChanged<String> onCountryChanged;
  final String initialCountry;

  const CountrySelector({
    Key? key,
    required this.initialCountry,
    required this.onCountryChanged,
  }) : super(key: key);

  @override
  State<CountrySelector> createState() => _CountrySelectorState();
}

class _CountrySelectorState extends State<CountrySelector> {
  late String _selectedCountry = widget.initialCountry;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 8,
        ),
        const Text("Country: "),
        TextButton(
          onPressed: () => _openCountryPicker(),
          child: Text(_selectedCountry),
        ),
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
        bottomSheetHeight: 500, // Optional. Country list modal height
        //Optional. Sets the border radius for the bottomsheet.
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        //Optional. Styles the search field.
        inputDecoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Start typing to search',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
      ),
      onSelect: (Country country) => {
        setState(() {
          _selectedCountry = country.name;
          widget.onCountryChanged(country.name);
        })
      },
    );
  }
}
