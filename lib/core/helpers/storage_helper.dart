import 'dart:io';

import 'package:coconut_chronicles/core/helpers/permission_helper.dart';
import 'package:coconut_chronicles/core/helpers/platform_helper.dart';
import 'package:path_provider/path_provider.dart';

class StorageHelper {
  static Directory? _storageDirectory;

  static Future<Directory> getStorageDirectory() async {
    if (_storageDirectory != null) {
      return _storageDirectory!;
    }

    if (PlatformHelper.isWeb) {
      throw UnsupportedError("No support yet for web storage");
    }

    await PermissionHelper.ensureStoragePermissions();

    _storageDirectory = await getApplicationDocumentsDirectory();
    await _ensureDirectoryExists(_storageDirectory!);

    return _storageDirectory!;
  }

  static Future _ensureDirectoryExists(Directory directory) async {
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
  }
}
