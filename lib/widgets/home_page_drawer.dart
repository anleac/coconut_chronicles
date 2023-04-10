import 'package:coconut_chronicles/core/models/entry_model.dart';
import 'package:coconut_chronicles/core/storage/preferences_model.dart';
import 'package:coconut_chronicles/widgets/chronicle_entry_list.dart';
import 'package:coconut_chronicles/widgets/drawer/version_text.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePageDrawer extends StatefulWidget {
  final Function(EntryModel) onEntrySelect;

  const HomePageDrawer({Key? key, required this.onEntrySelect}) : super(key: key);

  @override
  State<HomePageDrawer> createState() => _HomePageDrawerState();
}

class _HomePageDrawerState extends State<HomePageDrawer> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<PreferencesModel>(builder: (context, child, model) {
      return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
          const SizedBox(height: 40),
          ChronicleEntryList(onEntrySelect: widget.onEntrySelect),
          const Divider(),
          const VersionText()
        ]),
      );
    });
  }
}
