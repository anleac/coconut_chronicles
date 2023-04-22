import 'package:coconut_chronicles/core/helpers/format_helper.dart';

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

  DateTime createdAt;

  DateTime? date;
  // This allows support for a "date range" for a journal
  DateTime? endDate;
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

  void markAsUpdated() {
    _isNewEntry = false;
    lastUpdated = DateTime.now();
  }
}
