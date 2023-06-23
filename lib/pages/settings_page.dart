import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  static const double horizontalPadding = 32;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: ListView(
              padding: EdgeInsets.zero, children: const [SizedBox(height: 24), Divider(), SizedBox(height: 24)])),
    );
  }
}
