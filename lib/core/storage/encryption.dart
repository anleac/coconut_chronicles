import 'dart:io';

import 'package:coconut_chronicles/constants/storage_constants.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Encryption {
  static const int encryptionKeyLength = 32;
  static const int ivLength = 16;

  static const _encryptedKeyStorage = FlutterSecureStorage();

  // List of platforms that support encryption
  static bool get supportedPlatform =>
      Platform.isAndroid ||
      Platform.isIOS ||
      Platform.isMacOS ||
      Platform.isWindows ||
      Platform.isLinux;

  static Future<bool> isEncryptionEnabled() async {
    if (!supportedPlatform) {
      return false;
    }

    return await _encryptedKeyStorage.containsKey(
        key: StorageConstants.encryptionKeyKey);
  }

  static Future<void> setEncryptionKey(String key) async {
    await _encryptedKeyStorage.write(
        key: StorageConstants.encryptionKeyKey, value: _padKeyIfNeeded(key));
    await _encryptedKeyStorage.write(
        key: StorageConstants.encryptionIvKey,
        value: IV.fromLength(ivLength).base64);
  }

  static Future<void> clearEncryptionKey() async {
    var currentKey = await _getKey();
    var currentIv = await _getIv();

    if (currentKey != null && currentIv != null) {
      return;
    }

    // TODO if this fails, we should probably do something about it
    var succeededConverting = await _decryptAllEntries(currentKey!, currentIv!);

    await _encryptedKeyStorage.delete(key: StorageConstants.encryptionKeyKey);
    await _encryptedKeyStorage.delete(key: StorageConstants.encryptionIvKey);
  }

  static Future<String> encrypt(String data) async {
    final key = await _getKey();
    final iv = await _getIv();
    if (key == null || iv == null) {
      return data;
    }

    final encrypter = _getEncrypter(key);
    return encrypter.encrypt(data, iv: IV.fromBase64(iv)).base64;
  }

  static Future<String> decrypt(String data) async {
    final key = await _getKey();
    final iv = await _getIv();
    if (key == null || iv == null) {
      return data;
    }

    final encrypter = _getEncrypter(key);
    return encrypter.decrypt64(data, iv: IV.fromBase64(iv));
  }

  static Future<String?> _getKey() async =>
      await _encryptedKeyStorage.read(key: StorageConstants.encryptionKeyKey);
  static Future<String?> _getIv() async =>
      await _encryptedKeyStorage.read(key: StorageConstants.encryptionIvKey);

  static Future<bool> _decryptAllEntries(String key, String iv) async {
    // TODO Implement this method to decrypt all entries in the storage
    return true;
  }

  static String _padKeyIfNeeded(String key) {
    if (key.length < encryptionKeyLength) {
      // TODO improve the padding security
      return key.padRight(encryptionKeyLength, '0');
    }

    return key;
  }

  static Encrypter _getEncrypter(String stringKey) {
    final encryptionKey = Key.fromUtf8(stringKey);
    return Encrypter(AES(encryptionKey));
  }
}
