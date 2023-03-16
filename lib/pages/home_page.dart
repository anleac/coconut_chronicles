import 'package:coconut_chronicles/widgets/home_page_drawer.dart';
import 'package:coconut_chronicles/widgets/home_page_fab.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coconut Chronicles'),
      ),
      floatingActionButton: const HomePageFab(),
      drawer: const HomePageDrawer(),
      body: Container(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}