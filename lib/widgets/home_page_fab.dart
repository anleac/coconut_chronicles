import 'package:flutter/material.dart';

class HomePageFab extends StatefulWidget {
  const HomePageFab({super.key});

  @override
  State<HomePageFab> createState() => _HomePageFabState();
}

class _HomePageFabState extends State<HomePageFab> {
  @override
  Widget build(BuildContext context) {
    return const FloatingActionButton(onPressed: null, child: Icon(Icons.add));
  }
}
