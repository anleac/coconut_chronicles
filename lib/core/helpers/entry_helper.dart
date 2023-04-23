import 'package:coconut_chronicles/core/models/entry_model.dart';

class EntryHelper {
  static EntryModel newEntry() => EntryModel(createdAt: DateTime.now());
  static EntryModel clone(EntryModel entry) => EntryModel.fromJson(entry.toJson());
}
