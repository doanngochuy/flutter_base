import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  final int id;
  final String email;
  final String userName;
  final String password;
  final String fullName;

  const User({
    this.id = -1,
    this.email = "",
    this.userName = "",
    this.password = "",
    this.fullName = "",
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() => jsonEncode(this).toString();

}

@JsonSerializable()
class LoginResponse {
  final String accessToken;

  const LoginResponse({
    this.accessToken = '',
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
