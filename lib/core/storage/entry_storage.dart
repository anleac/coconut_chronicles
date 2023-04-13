import 'dart:io';

import 'package:coconut_chronicles/constants/storage_constants.dart';
import 'package:coconut_chronicles/core/helpers/storage_helper.dart';
import 'package:coconut_chronicles/core/models/entry_model.dart';
import 'package:path/path.dart';

class EntryStorage {
  static final Map<int, EntryModel> _entries = {};

  static Future<bool> saveEntry(EntryModel entry) async {
    var file = await StorageHelper.getEntryFile(entry);
    var fileContentsToWrite = entry.toJson();
    try {
      await file.writeAsString(fileContentsToWrite);

      // TODO: We have no way of handling duplicates yet
      _entries[entry.fileSaveName] = entry;
      return true;
    } catch (e) {
      return false;
    }
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
      var fileContents = await File(file.path).readAsString();
      try {
        var entry = EntryModel.fromJson(fileContents);
        _entries[entry.fileSaveName] = entry;
        // ignore: empty_catches TODO: Decide what to do where
      } catch (e) {}
    }

    return _entries.values.toList();
  }
}
