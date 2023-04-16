class StorageConstants {
  static const String parentFolderName = 'coconut_chronicles';

  static const String entrySaveExtension = '.coconut-entry';
  static const String encryptedEntrySaveExtension = '.coconut-entry-e';

  static const String encryptionKeyKey = 'encryption_key';
  static const String encryptionIvKey = 'encryption_iv';

  static const allowedEntrySaveExtensions = {
    entrySaveExtension,
    encryptedEntrySaveExtension,
  };
}
