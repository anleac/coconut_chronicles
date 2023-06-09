import 'package:json_annotation/json_annotation.dart';

class EpochDateTimeConverter implements JsonConverter<DateTime?, int?> {
  const EpochDateTimeConverter();

  @override
  DateTime? fromJson(int? epoch) => epoch == null ? null : DateTime.fromMillisecondsSinceEpoch(epoch);

  @override
  int? toJson(DateTime? object) => object?.millisecondsSinceEpoch;
}
