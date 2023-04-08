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
  late List<String> categories;

  String get fileSaveName => date.millisecondsSinceEpoch.toString();

  EntryModel({
    this.title,
    this.description,
    this.country,
    List<String>? categories,
    required this.date,
  }) {
    this.categories = categories ?? [];
  }

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

  toJson() {
    return jsonEncode({
      'title': title,
      'description': description,
      'country': country,
      'date': fileSaveName,
      'categories': categories,
    });
  }

  static EntryModel fromJson(String json) {
    var decodedJson = jsonDecode(json);
    return EntryModel(
      title: decodedJson['title'],
      description: decodedJson['description'],
      country: decodedJson['country'],
      date: DateTime.fromMillisecondsSinceEpoch(int.parse(decodedJson['date'])),
      categories: List<String>.from(decodedJson['categories']),
    );
  }

  static EntryModel newEntry() => EntryModel(date: DateTime.now());
}
