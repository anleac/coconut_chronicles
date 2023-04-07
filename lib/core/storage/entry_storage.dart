import 'dart:io';

import 'package:coconut_chronicles/core/helpers/storage_helper.dart';
import 'package:coconut_chronicles/core/models/entry.dart';

class EntryStorage {
  static Map<String, EntryModel> _entries = {};

  static Future saveEntry(EntryModel entry) async {
    var storageDirectory = await StorageHelper.getStorageDirectory();
    var file = File('${storageDirectory.path}/${entry.fileSaveName}.json');

    await file.writeAsString(entry.toJson());
  }

  static Future<List<EntryModel>> loadEntries() async {
    if (_entries.isNotEmpty) {
      return _entries.values.toList();
    }

    var storageDirectory = await StorageHelper.getStorageDirectory();
    var files = await storageDirectory.list().toList();

    for (var file in files) {
      var entry = EntryModel.fromJson(await File(file.path).readAsString());
      _entries[entry.fileSaveName] = entry;
    }

    return _entries.values.toList();
  }
}
