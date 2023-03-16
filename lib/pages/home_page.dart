import 'package:calendar_date_picker2/calendar_date_picker2.dart';
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
      body: Padding(
        padding: const EdgeInsets.only(bottom: 32, left: 32, right: 32),
        child: Column(
          children: [
            TextButton(
              onPressed: () => showCalendarDatePicker2Dialog(
                context: context,
                config: CalendarDatePicker2WithActionButtonsConfig(),
                dialogSize: const Size(325, 400),
                initialValue: [],
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Text('Select Date'),
            ),
            const SizedBox(height: 16),
            // We want a title and body input field, with the body filling the remaining space
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 16),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Body',
                ),
                maxLines: null,
                expands: true,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
          ]
        ),
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}