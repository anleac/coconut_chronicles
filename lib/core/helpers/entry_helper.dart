import 'dart:convert';

import 'package:coconut_chronicles/core/helpers/io_helper.dart';
import 'package:coconut_chronicles/core/models/entry_model.dart';

class EntryHelper {
  static EntryModel newEntry() => EntryModel(createdAt: DateTime.now());

  static String toJson(EntryModel entry) {
    return jsonEncode({
      'title': entry.title,
      'description': entry.description,
      'country': entry.country,
      'createdAt': IoHelper.saveDateToFile(entry.createdAt),
      'date': IoHelper.saveDateToFile(entry.date),
      'endDate': IoHelper.saveDateToFile(entry.endDate),
      'categories': entry.categories,
    });
  }

  static EntryModel fromJson(String json) {
    var decodedJson = jsonDecode(json);
    return EntryModel(
      title: decodedJson['title'],
      description: decodedJson['description'],
      country: decodedJson['country'],
      createdAt: IoHelper.readDateFromSave(decodedJson['createdAt'])!, // This should never be null
      date: IoHelper.readDateFromSave(decodedJson['date']),
      endDate: IoHelper.readDateFromSave(decodedJson['endDate']),
      categories: List<String>.from(decodedJson['categories']),
    );
  }

  static EntryModel clone(EntryModel entry) => fromJson(toJson(entry));
}
