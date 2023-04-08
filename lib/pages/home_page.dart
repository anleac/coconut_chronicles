import 'package:coconut_chronicles/core/models/entry_model.dart';
import 'package:coconut_chronicles/widgets/chronicle_entry_form.dart';
import 'package:coconut_chronicles/widgets/home_page_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  static const double horizontalPadding = 32;

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
          child: ChronicleEntryForm(
            entry: EntryModel.newEntry(),
            newEntry: true,
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
