import 'package:coconut_chronicles/core/storage/theming_model.dart';
import 'package:flutter/material.dart';

class DarkModeToggle extends StatefulWidget {
  const DarkModeToggle({super.key});

  @override
  State<DarkModeToggle> createState() => _DarkModeToggleState();
}

class _DarkModeToggleState extends State<DarkModeToggle> {
  @override
  Widget build(BuildContext context) {
    var themingModel = ThemingModel.of(context);
    return SwitchListTile(
      title: const Text('Dark Mode'),
      value: themingModel.darkMode,
      onChanged: (value) {
        setState(() {
          themingModel.setDarkMode(value);
        });
      },
    );
  }
}
