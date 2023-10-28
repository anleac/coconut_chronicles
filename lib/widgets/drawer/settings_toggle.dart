import 'package:coconut_chronicles/pages/settings_page.dart';
import 'package:flutter/material.dart';

class SettingsToggle extends StatelessWidget {
  const SettingsToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Other Settings'),
      trailing: const Icon(Icons.settings),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
      },
    );
  }
}
