import 'package:coconut_chronicles/core/models/selected_entry_model.dart';
import 'package:coconut_chronicles/widgets/entry_form/chronicle_entry_form.dart';
import 'package:coconut_chronicles/widgets/home_page_drawer.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const double horizontalPadding = 32;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ScopedModelDescendant<SelectedEntryModel>(builder: (context, child, model) {
          return Text(model.isNewEntry ? 'New entry' : model.selectedEntry.safeTitle);
        }),
      ),
      // floatingActionButton: const HomePageFab(),
      drawer: const HomePageDrawer(),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: ChronicleEntryForm(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
