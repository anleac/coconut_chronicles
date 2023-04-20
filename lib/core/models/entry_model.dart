import 'dart:convert';

import 'package:coconut_chronicles/core/helpers/format_helper.dart';
import 'package:coconut_chronicles/core/helpers/io_helper.dart';

class EntryModel {
  static EntryModel newEntry() => EntryModel(createdAt: DateTime.now());

  String get safeTitle => title ?? "Untitled";
  String get safeDescription => description ?? "No description";
  String get safeCountry => country ?? "No country selected";

  String get safeDate => date != null ? FormatHelper.formatDate(date!) : "No date yet";
  String get safeEndDate => endDate != null ? FormatHelper.formatDate(endDate!) : "No date yet";

  bool get isNewEntry => _isNewEntry;

  String? title;
  String? description;
  String? country;

  DateTime createdAt;

  DateTime? date;
  // This allows support for a "date range" for a journal
  DateTime? endDate;

  late List<String> categories;
  late final bool _isNewEntry;

  // This should almost -always- be unique
  int get fileSaveName => createdAt.millisecondsSinceEpoch;

  EntryModel(
      {this.title,
      this.description,
      this.country,
      List<String>? categories,
      required this.createdAt,
      this.date,
      this.endDate}) {
    this.categories = categories ?? [];
    _isNewEntry = title == null;
  }

  void updateProperties(
      {String? title,
      String? description,
      DateTime? date,
      DateTime? endDate,
      String? country,
      List<String>? categories}) {
    this.title = title ?? this.title;
    this.description = description ?? this.description;
    this.date = date ?? this.date;
    this.endDate = endDate ?? this.endDate;
    this.country = country ?? this.country;
    this.categories = categories ?? this.categories;
  }

  void addCategory(String category) {
    if (!categories.contains(category)) {
      categories.add(category);
    }
  }

  void removeCategory(String category) {
    categories.remove(category);
  }

  toJson() {
    return jsonEncode({
      'title': title,
      'description': description,
      'country': country,
      'createdAt': IoHelper.saveDateToFile(createdAt),
      'date': IoHelper.saveDateToFile(date),
      'endDate': IoHelper.saveDateToFile(endDate),
      'categories': categories,
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

  static EntryModel clone(EntryModel entry) => fromJson(entry.toJson());
}
