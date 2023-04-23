// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntryModel _$EntryModelFromJson(Map<String, dynamic> json) => EntryModel(
      title: json['title'] as String?,
      description: json['description'] as String?,
      country: json['country'] as String?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastUpdated:
          const EpochDateTimeConverter().fromJson(json['lastUpdated'] as int?),
      date: const EpochDateTimeConverter().fromJson(json['date'] as int?),
      endDate: const EpochDateTimeConverter().fromJson(json['endDate'] as int?),
    );

Map<String, dynamic> _$EntryModelToJson(EntryModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'country': instance.country,
      'createdAt': instance.createdAt.toIso8601String(),
      'date': const EpochDateTimeConverter().toJson(instance.date),
      'endDate': const EpochDateTimeConverter().toJson(instance.endDate),
      'lastUpdated':
          const EpochDateTimeConverter().toJson(instance.lastUpdated),
      'categories': instance.categories,
    };
