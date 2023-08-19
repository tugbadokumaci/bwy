import 'dart:convert';

import 'package:bwy/utils/resource.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/material.dart';
import 'package:retrofit/retrofit.dart';

import '../models/service_model.dart';
import '../models/user_model.dart';
import 'constants.dart';

part 'generator.g.dart';

@RestApi(baseUrl: ApiConstants.BASE_URL)
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  static RestClient create() {
    final dio = Dio();
    RestClient.debugHttpInterceptors(dio); // Burada çağrılıyor
    return RestClient(dio);
  }

  @GET('/codeocean/getdata.php')
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
    "charset": "utf-8",
  })
  Future<List<UserModel>> getData();

  @POST('/codeocean/register.php')
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
    "charset": "utf-8",
  })
  Future<Resource<UserModel>> signup(@Body() Map<String, dynamic> user);

  @POST('/codeocean/login.php')
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
    "charset": "utf-8",
  })
  Future<Resource<UserModel>> login(@Body() Map<String, dynamic> user);

  @POST('/codeocean/getservices.php')
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
    "charset": "utf-8",
  })
  Future<Resource<List<ServiceModel>>> getServices(@Body() Map<String, dynamic> user);

  static void debugHttpInterceptors(Dio dio) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        debugPrint('onRequest');
        debugPrint("--> ${options.method} ${options.uri}");
        debugPrint("Headers: ${options.headers}");
        debugPrint("Data: ${options.data}");
        return handler.next(options);
      },
      onResponse: (response, handler) {
        debugPrint('onResponse');
        debugPrint("<-- ${response.statusCode} ${response.requestOptions.uri}");
        debugPrint("Response: ${response.data}");
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        debugPrint('onError');
        debugPrint("<-- Error ${e.response?.statusCode} ${e.response?.requestOptions.uri}");
        debugPrint("Message: ${e.message}");
        return handler.next(e);
      },
    ));
  }
}
