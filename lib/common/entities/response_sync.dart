import 'package:json_annotation/json_annotation.dart';

part 'response_sync.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ResponseSync<T> {
  String code;
  String message;
  List<T> data;
  Metadata metadata;

  ResponseSync(this.code, this.message, this.data, this.metadata);

  factory ResponseSync.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ResponseSyncFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(T Function(Object? json) fromJsonT) =>
      _$ResponseSyncToJson(this, fromJsonT);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Metadata {
  int currentPage;
  int pageSize;
  int totalItems;

  Metadata(this.currentPage, this.pageSize, this.totalItems);

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}
