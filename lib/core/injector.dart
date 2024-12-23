import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/api_client.dart';
import 'package:news_app/core/constants.dart';

class Injector {
  static final Injector _singleton = Injector._internal();
  static final dio = Dio();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  RestApiClient getClient() {
    // dio.options.connectTimeout = 10000;
    // dio.options.receiveTimeout = 3000;
    dio.options.followRedirects = false;
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.headers["Authorization"] = "";
    dio.options.headers["x-client-id"] = "news.vox_populi";
    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    dio.interceptors.clear();
    dio.interceptors.add(LoggingInterceptors());
    final client = RestApiClient(dio, baseUrl: endpoint);
    return client;
  }
}

class LoggingInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("--> ${'METHOD'} ${(options.baseUrl) + (options.path)}");
    debugPrint("Headers:");
    options.headers.forEach((k, v) => print('$k: $v'));
    debugPrint("queryParameters:");
    options.queryParameters.forEach((k, v) => debugPrint('$k: $v'));
    if (options.data != null) {
      debugPrint("Body: ${options.data}");
    }
    debugPrint("--> END ${options.method.toUpperCase()}");
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException dioError, ErrorInterceptorHandler handler) {
    debugPrint(
        "<-- ${dioError.message} ${(dioError.response?.requestOptions != null ? (dioError.response!.requestOptions.baseUrl + dioError.response!.requestOptions.path) : 'URL')}");
    debugPrint(
        "${dioError.response != null ? dioError.response!.data : 'Unknown Error'}");
    debugPrint("<-- End error");
    throw dioError;
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        "<-- ${response.statusCode} ${((response.requestOptions.baseUrl + response.requestOptions.path))}");
    debugPrint("Headers:");
    response.headers.forEach((k, v) => print('$k: $v'));
    // debugPrint("Response: ${response.data}");
    debugPrint("<-- END HTTP");
    return super.onResponse(response, handler);
  }
}
