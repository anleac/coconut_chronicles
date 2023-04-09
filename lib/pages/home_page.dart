import 'package:coconut_chronicles/core/models/entry_model.dart';
import 'package:coconut_chronicles/widgets/chronicle_entry_form.dart';
import 'package:coconut_chronicles/widgets/home_page_drawer.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  static const double horizontalPadding = 32;
  static final EntryModel _newEntry = EntryModel.newEntry();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('New entry'),
        ),
        // floatingActionButton: const HomePageFab(),
        drawer: const HomePageDrawer(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: ScopedModel<EntryModel>(
            model: _newEntry,
            child: const ChronicleEntryForm(),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
