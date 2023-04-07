class EntryModel {
  String? title;
  String? description;
  DateTime? date;
  String? country;
  List<String>? categories;

  EntryModel({
    this.title,
    this.description,
    this.date,
    this.country,
    this.categories,
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

  void clearAllProperties() {
    title = null;
    description = null;
    date = null;
    country = null;
    categories = null;
  }
}
