import 'dart:convert';

import 'package:coconut_chronicles/core/helpers/format_helper.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class EntryModel extends Model {
  static EntryModel of(BuildContext context) => ScopedModel.of<EntryModel>(context);
  static EntryModel newEntry() => EntryModel(date: DateTime.now());

  String get safeTitle => title ?? "Untitled";
  String get safeDescription => description ?? "No description";
  String get safeCountry => country ?? "No country selected";
  String get safeDate => FormatHelper.formatDate(date);
  bool get isNewEntry => _isNewEntry;

  String? title;
  String? description;
  String? country;
  DateTime date;
  late List<String> categories;
  late final bool _isNewEntry;

  String get fileSaveName => date.millisecondsSinceEpoch.toString();

  EntryModel({
    this.title,
    this.description,
    this.country,
    List<String>? categories,
    required this.date,
  }) {
    this.categories = categories ?? [];
    _isNewEntry = title == null;
  }

  void updateProperties({
    String? title,
    String? description,
    DateTime? date,
    String? country,
    List<String>? categories,
    bool rebuildListeners = false,
  }) {
    this.title = title ?? this.title;
    this.description = description ?? this.description;
    this.date = date ?? this.date;
    this.country = country ?? this.country;
    this.categories = categories ?? this.categories;

    if (rebuildListeners) {
      notifyListeners();
    }
  }

  void clearProperties() {
    title = null;
    description = null;
    date = DateTime.now();
    country = null;
    categories = [];

    notifyListeners();
  }

  void addCategory(String category) {
    if (!categories.contains(category)) {
      categories.add(category);
    }
  }

  void removeCategory(String category) {
    categories.remove(category);
  }

  void forceRefresh() {
    notifyListeners();
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
}
