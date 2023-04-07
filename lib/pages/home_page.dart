import 'package:coconut_chronicles/widgets/chronicle_entry_form.dart';
import 'package:coconut_chronicles/widgets/home_page_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  static const double innerPadding = 32;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Coconut Chronicles'),
        ),
        // floatingActionButton: const HomePageFab(),
        drawer: const HomePageDrawer(),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: innerPadding),
          child: ChronicleEntryForm(),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
