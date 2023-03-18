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
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
        bottomSheetHeight: 500, // Optional. Country list modal height
        //Optional. Sets the border radius for the bottomsheet.
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        //Optional. Styles the search field.
        inputDecoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Start typing to search',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xFF8C98A8).withOpacity(0.2),
            ),
          ),
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
