import 'package:json_annotation/json_annotation.dart';

class DateTimeConverter implements JsonConverter<DateTime, String> {
  @override
  DateTime fromJson(String json) => json.isNotEmpty ? DateTime.parse(json).toLocal() : DateTime.now();

  @override
  String toJson(DateTime object) => object.toIso8601String();

  const DateTimeConverter();
}
