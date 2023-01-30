import 'package:json_annotation/json_annotation.dart';

part 'response_sync.g.dart';

@JsonSerializable(
    fieldRename: FieldRename.pascal, genericArgumentFactories: true)
class ResponseSync<T> {
  List<T> data;
  String latestSync;

  ResponseSync(this.data, this.latestSync);

  factory ResponseSync.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ResponseSyncFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(T Function(Object? json) fromJsonT) =>
      _$ResponseSyncToJson(this, fromJsonT);
}
