import 'dart:io';

import 'package:coconut_chronicles/constants/storage_constants.dart';
import 'package:coconut_chronicles/core/helpers/storage_helper.dart';
import 'package:coconut_chronicles/core/models/entry_model.dart';
import 'package:path/path.dart';

class EntryStorage {
  static final Map<String, EntryModel> _entries = {};

  static Future saveEntry(EntryModel entry) async {
    var file = await StorageHelper.getEntryFile(entry);
    await file.writeAsString(entry.toJson());
  }

  static Future<List<EntryModel>> loadEntries() async {
    if (_entries.isNotEmpty) {
      return _entries.values.toList();
    }

    var storageDirectory = await StorageHelper.getStorageDirectory();
    var files = await storageDirectory.list().toList();

    for (var file in files) {
      var fileExtension = extension(file.path);
      if (fileExtension != StorageConstants.entrySaveExtension) {
        continue;
      }

      var entry = EntryModel.fromJson(await File(file.path).readAsString());
      _entries[entry.fileSaveName] = entry;
    }

    return _entries.values.toList();
  }
}
