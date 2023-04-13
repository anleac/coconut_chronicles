import 'dart:convert';

import 'package:coconut_chronicles/core/helpers/format_helper.dart';
import 'package:coconut_chronicles/core/helpers/io_helper.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class EntryModel extends Model {
  static EntryModel of(BuildContext context) => ScopedModel.of<EntryModel>(context);
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

  void updateProperties({
    String? title,
    String? description,
    DateTime? date,
    DateTime? endDate,
    String? country,
    List<String>? categories,
    bool rebuildListeners = false,
  }) {
    this.title = title ?? this.title;
    this.description = description ?? this.description;
    this.date = date ?? this.date;
    this.endDate = endDate ?? this.endDate;
    this.country = country ?? this.country;
    this.categories = categories ?? this.categories;

    if (rebuildListeners) {
      notifyListeners();
    }
  }

  void clearProperties() {
    title = null;
    description = null;
    createdAt = DateTime.now();
    date = null;
    endDate = null;
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

  toJson() {
    return jsonEncode({
      'title': title,
      'description': description,
      'country': country,
      'createdAt': IoHelper.saveDateToFile(createdAt),
      'date': IoHelper.saveDateToFile(date!),
      'endDate': endDate != null ? IoHelper.saveDateToFile(endDate!) : null,
      'categories': categories,
    });
  }

  static EntryModel fromJson(String json) {
    var decodedJson = jsonDecode(json);
    return EntryModel(
      title: decodedJson['title'],
      description: decodedJson['description'],
      country: decodedJson['country'],
      createdAt: IoHelper.readDateFromSave(decodedJson['createdAt']),
      date: IoHelper.readDateFromSave(decodedJson['createdAt']),
      endDate: IoHelper.readDateFromSave(decodedJson['createdAt']),
      categories: List<String>.from(decodedJson['categories']),
    );
  }
}
