import 'package:coconut_chronicles/core/models/entry.dart';
import 'package:coconut_chronicles/core/storage/entry_storage.dart';
import 'package:flutter/material.dart';

class ChronicleEntryList extends StatefulWidget {
  const ChronicleEntryList({Key? key}) : super(key: key);

  @override
  State<ChronicleEntryList> createState() => _ChronicleEntryListState();
}

class _ChronicleEntryListState extends State<ChronicleEntryList> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text("Past entries"),
      SizedBox(
          height: 300,
          child: FutureBuilder(
            future: EntryStorage.loadEntries(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var entries = snapshot.data as List<EntryModel>;
                return ListView.builder(
                  itemCount: entries.length,
                  itemBuilder: (context, index) {
                    var entry = entries[index];
                    return ListTile(
                      title: Text(entry.safeTitle),
                      subtitle: Text(entry.safeDate),
                    );
                  },
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          ))
    ]);
  }
}
