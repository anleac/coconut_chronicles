import 'dart:convert';

import 'package:coconut_chronicles/core/helpers/format_helper.dart';

class EntryModel {
  String get safeTitle => title ?? "Untitled";
  String get safeDescription => description ?? "No description";
  String get safeDate => FormatHelper.formatDate(date);

  String? title;
  String? description;
  String? country;
  DateTime date;
  List<String> categories;

  String get fileSaveName => date.toIso8601String();

  EntryModel({
    this.title,
    this.description,
    this.country,
    this.categories = const [],
    required this.date,
  });

  void updateProperties({
    String? title,
    String? description,
    DateTime? date,
    String? country,
    List<String>? categories,
  }) {
    this.title = title ?? this.title;
    this.description = description ?? this.description;
    this.date = date ?? this.date;
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

  void clearAllProperties() {
    title = null;
    description = null;
    country = null;
    date = DateTime.now();
    categories.clear();
  }

  toJson() {
    return jsonEncode({
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'country': country,
      'categories': categories,
    });
  }

  static EntryModel fromJson(String json) {
    var decodedJson = jsonDecode(json);
    return EntryModel(
      title: decodedJson['title'],
      description: decodedJson['description'],
      date: DateTime.parse(decodedJson['date']),
      country: decodedJson['country'],
      categories: decodedJson['categories'],
    );
  }
}
