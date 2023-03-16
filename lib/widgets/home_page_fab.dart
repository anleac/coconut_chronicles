import 'package:flutter/material.dart';

class HomePageFab extends StatefulWidget {
  const HomePageFab({Key? key}) : super(key: key);

  @override
  State<HomePageFab> createState() => _HomePageFabState();
}

class _HomePageFabState extends State<HomePageFab> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => null,
      child: const Icon(Icons.add)
    );
  }
}
