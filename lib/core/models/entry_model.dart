import 'dart:convert';

import 'package:coconut_chronicles/core/helpers/format_helper.dart';
import 'package:coconut_chronicles/core/storage/serialization/epoch_datetime_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'entry_model.g.dart';

@JsonSerializable()
class EntryModel {
  String get safeTitle => title ?? "Untitled";
  String get safeDescription => description ?? "No description";
  String get safeCountry => country ?? "No country selected";

  String get safeDate => date != null ? FormatHelper.formatDate(date!) : "No date yet";
  String get safeEndDate => endDate != null ? FormatHelper.formatDate(endDate!) : "No date yet";

  bool get isNewEntry => _isNewEntry;

  String? title;
  String? description;
  String? country;
  String? memorableSongs;

  @EpochDateTimeConverter()
  DateTime createdAt;

  @EpochDateTimeConverter()
  DateTime? date;

  // This allows support for a "date range" for a journal
  @EpochDateTimeConverter()
  DateTime? endDate;
  @EpochDateTimeConverter()
  DateTime? lastUpdated;

  late List<String> categories;
  late bool _isNewEntry;

  // This should almost -always- be unique
  int get fileSaveName => createdAt.millisecondsSinceEpoch;

  EntryModel(
      {this.title,
      this.description,
      this.country,
      List<String>? categories,
      required this.createdAt,
      this.lastUpdated,
      this.date,
      this.endDate,
      this.memorableSongs}) {
    this.categories = categories ?? [];
    _isNewEntry = title == null;
  }

  void updateProperties(
      {String? title,
      String? description,
      DateTime? date,
      DateTime? endDate,
      String? country,
      String? memorableSongs,
      List<String>? categories}) {
    this.title = title ?? this.title;
    this.description = description ?? this.description;
    this.date = date ?? this.date;
    this.endDate = endDate ?? this.endDate;
    this.country = country ?? this.country;
    this.memorableSongs = memorableSongs ?? this.memorableSongs;
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

  void markAsUpdated() {
    _isNewEntry = false;
    lastUpdated = DateTime.now();
  }

  factory EntryModel.fromJson(Map<String, dynamic> json) => _$EntryModelFromJson(json);
  factory EntryModel.fromJsonString(String json) => _$EntryModelFromJson(jsonDecode(json));
  Map<String, dynamic> toJson() => _$EntryModelToJson(this);
  String toJsonString() => jsonEncode(toJson());
}
