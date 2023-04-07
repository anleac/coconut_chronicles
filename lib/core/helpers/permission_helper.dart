import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static bool get hasValidStoragePermissions => _hasStoragePermission;

  // https://pub.dev/packages/permission_handler currently only android/ios/windows support this.
  static final bool _canSkipStoragePermissionCheck = !Platform.isAndroid && !Platform.isIOS && !Platform.isWindows;
  static bool _hasStoragePermission = false;

  static ensureStoragePermissions() async {
    if (_canSkipStoragePermissionCheck || _hasStoragePermission) {
      _hasStoragePermission = true;
      return;
    }

    if (!_hasStoragePermission) {
      _hasStoragePermission = await _requestPermission(Permission.storage, forceOpenSettings: true) ||
          await _requestPermission(Permission.manageExternalStorage, forceOpenSettings: true);
    }
  }

  static Future<bool> _requestPermission(Permission name, {bool forceOpenSettings = false}) async {
    try {
      var permission = await name.request();

      if (forceOpenSettings) {
        await _openSettingsIfNeeded(permission);
      }

      return _isAllowedPermission(permission);
    } catch (error) {
      return false;
    }
  }

  static Future _openSettingsIfNeeded(PermissionStatus permissionStatus) async {
    if (permissionStatus == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
    }
  }

  static bool _isAllowedPermission(PermissionStatus status) {
    return status == PermissionStatus.granted || status == PermissionStatus.limited;
  }
}
