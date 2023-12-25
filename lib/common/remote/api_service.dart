import 'dart:async';

import 'package:EMO/common/entities/entities.dart';
import 'package:EMO/common/remote/remote.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST("/login")
  Future<LoginResponse> login(
    @Body() Map<String, dynamic> request,
  );

  @POST("/register")
  Future<SignUpResponse> signup(
    @Body() Map<String, dynamic> request,
  );

  @POST("/logout")
  Future logout();

  @GET("/users/me")
  Future<User> getUser();

  @PUT("/users/me")
  Future<User> updateUser({
    @Body() required Map<String, dynamic> request,
  });

  //job
  @GET("/jobs/current")
  Future<CurrentJobResponse> getCurrentJob({@Query("device_id") required String deviceId});

  @GET("/jobs/start")
  Future<StartJobResponse> startJob({
    @Query("job_id") required int jobId,
    @Query("current_id") required int currentId,
  });

  @POST("/jobs/finish")
  Future finishJob({
    @Body() required Map<String, dynamic> request,
  });

  @POST("/jobs/cancel")
  Future<ResponsePostBff> cancelJob({
    @Body() required Map<String, dynamic> request,
  });

  @GET("/transactions")
  Future<ResponseTransaction> getTransactions({
    @Query("page_size") int pageSize = 10,
    @Query("page") int page = 1,
    @Query("sort_by") String sort = "id",
    @Query("order") String order = "desc",
  });

  @GET("/withdraws")
  Future<ResponseSync<Withdraw>> getWithdraws({
    @Query("page_size") int pageSize = 10,
    @Query("page") int page = 1,
    @Query("sort_by") String sort = "id",
    @Query("order") String order = "desc",
  });

  @POST("/withdraws")
  Future postWithdraws(
    @Body() Map<String, dynamic> request,
  );

  /// Always show error with snackBar,
  /// if you want to handle error by yourself:
  ///
  /// Declare showDefaultError = false and handle Error with catchError
  static ApiService create({bool showDefaultError = true}) =>
      ApiService(DioManager.getDio(showDefaultError: showDefaultError));
}
