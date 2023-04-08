import 'dart:io';

import 'package:coconut_chronicles/constants/storage_constants.dart';
import 'package:coconut_chronicles/core/helpers/permission_helper.dart';
import 'package:coconut_chronicles/core/helpers/platform_helper.dart';
import 'package:coconut_chronicles/core/models/entry.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class StorageHelper {
  static Directory? _storageDirectory;

  static Future<File> getEntryFile(EntryModel model) async {
    return File(await getEntrySavePath(model));
  }

  static Future<String> getEntrySavePath(EntryModel model) async {
    return join((await getStorageDirectory()).path, '${model.fileSaveName}${StorageConstants.entrySaveExtension}');
  }

  static Future<Directory> getStorageDirectory() async {
    if (_storageDirectory != null) {
      return _storageDirectory!;
    }

    if (PlatformHelper.isWeb) {
      throw UnsupportedError("No support yet for web storage");
    }

    await PermissionHelper.ensureStoragePermissions();

    var rootDirectory = await getApplicationDocumentsDirectory();
    _storageDirectory = Directory(join(rootDirectory.path, StorageConstants.parentFolderName));

    await _ensureDirectoryExists(_storageDirectory!);

    return _storageDirectory!;
  }

  static Future _ensureDirectoryExists(Directory directory) async {
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
  }
}
