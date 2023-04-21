import 'package:coconut_chronicles/core/helpers/entry_helper.dart';
import 'package:coconut_chronicles/core/models/entry_model.dart';
import 'package:coconut_chronicles/core/models/selected_entry_model.dart';
import 'package:coconut_chronicles/core/storage/entry_storage.dart';
import 'package:coconut_chronicles/widgets/entry_list_tile.dart';
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
          height: 400,
          child: FutureBuilder(
            future: EntryStorage.loadEntries(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var entries = snapshot.data as List<EntryModel>;

                if (entries.isEmpty) {
                  return const Center(child: Text("No entries yet"));
                }

                return ListView.builder(
                  itemCount: entries.length,
                  itemBuilder: (context, index) {
                    var entry = entries[index];
                    return EntryListTitle(
                        entry: entry,
                        onTap: () async {
                          var navigator = Navigator.of(context);
                          var selected = await EntryHelper.safeSelectEntry(context, entry);
                          if (selected) {
                            // TODO this only works within the context of a drawer
                            navigator.pop();
                          }
                        });
                  },
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          ))
    ]);
  }
}
