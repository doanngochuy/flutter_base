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

  //job
  @GET("jobs/current")
  Future<CurrentJobResponse> getCurrentJob();

  @GET("jobs/start")
  Future<StartJobResponse> startJob({
    @Query("job_id") required int jobId,
    @Query("current_id") required int currentId,
  });

  @GET("jobs/finish")
  Future finishJob({
    @Query("token") required String token,
    @Query("value_page") required String valuePage,
  });


  @GET("jobs/done")
  Future<ResponseSync<Job>> getDoneJobs({
    @Query("user_id") required int userId,
    @Query("page_size") int pageSize = 10,
    @Query("page") int page = 1,
    @Query("sort_by") String sort = "id",
    @Query("order") String order = "desc",
  });

  /// Always show error with snackBar,
  /// if you want to handle error by yourself:
  ///
  /// Declare showDefaultError = false and handle Error with catchError
  static ApiService create({bool showDefaultError = true}) =>
      ApiService(DioManager.getDio(showDefaultError: showDefaultError));
}
