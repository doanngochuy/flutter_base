import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_base/common/entities/entities.dart';
import 'package:flutter_base/common/remote/remote.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST("/login")
  Future<LoginResponse> login(
      @Body() Map<String, dynamic> request,
  );

  @POST("/logout")
  Future logout();

  /// Always show error with snackBar,
  /// if you want to handle error by yourself:
  ///
  /// Declare showDefaultError = false and handle Error with catchError
  static ApiService create({bool showDefaultError = true}) =>
      ApiService(DioManager.getDio(showDefaultError: showDefaultError));
}
