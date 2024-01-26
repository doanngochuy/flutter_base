import 'package:json_annotation/json_annotation.dart';

part 'response_bff.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ResponseBff<T> {
  T? data;
  String code;
  String message;

  ResponseBff(this.data, this.code, this.message);

  factory ResponseBff.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ResponseBffFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(T Function(Object? json) fromJsonT) =>
      _$ResponseBffToJson(this, fromJsonT);
}

@JsonSerializable()
class ResponsePostBff {
  String code;
  String message;

  ResponsePostBff(this.code, this.message);

  factory ResponsePostBff.fromJson(Map<String, dynamic> json) => _$ResponsePostBffFromJson(json);

  Map<String, dynamic> toJson() => _$ResponsePostBffToJson(this);
}
