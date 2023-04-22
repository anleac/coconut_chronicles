import 'dart:io';

import 'package:coconut_chronicles/core/helpers/entry_helper.dart';
import 'package:coconut_chronicles/core/helpers/storage_helper.dart';
import 'package:coconut_chronicles/core/models/entry_model.dart';
import 'package:coconut_chronicles/core/storage/encryption.dart';
import 'package:path/path.dart';

class EntryStorage {
  static final Map<int, EntryModel> _entries = {};

  static Future<bool> saveEntry(EntryModel entry) async {
    var encryptionEnabled = await Encryption.isEncryptionEnabled();
    var file = await StorageHelper.getEntryFile(entry, encrypted: encryptionEnabled);
    var fileContentsToWrite = EntryHelper.toJson(entry);
    try {
      if (encryptionEnabled) {
        fileContentsToWrite = await Encryption.encrypt(fileContentsToWrite);
      }

      entry.markAsUpdated();
      await file.writeAsString(fileContentsToWrite);

      // TODO: We have no way of handling duplicates yet
      _entries[entry.fileSaveName] = entry;

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteEntry(EntryModel entry) async {
    // TODO we need to shift the encryption logic onto the entry itself.
    var encryptionEnabled = await Encryption.isEncryptionEnabled();
    var file = await StorageHelper.getEntryFile(entry, encrypted: encryptionEnabled);
    try {
      await file.delete();
      _entries.remove(entry.fileSaveName);
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
      if (!StorageHelper.allowedFileExtension(fileExtension)) {
        continue;
      }

      var fileContents = await File(file.path).readAsString();
      try {
        var encrypted = StorageHelper.isEncryptedFile(fileExtension);
        if (encrypted) {
          fileContents = await Encryption.decrypt(fileContents);
        }

        var entry = EntryHelper.fromJson(fileContents);
        _entries[entry.fileSaveName] = entry;
        // ignore: empty_catches TODO: Decide what to do where
      } catch (e) {}
    }

    return _entries.values.toList();
  }
}
