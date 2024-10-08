// ignore_for_file: unused_import

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../routing/routes.dart';
import '../services/shared_perferences.dart';
import '../utils/constants.dart';

class DioHelper {
  static final DioHelper _dioHelper = DioHelper._internal();
  late Dio dio;
  DioHelper._internal() {
    dio = Dio(BaseOptions(
        contentType: Headers.jsonContentType,
        baseUrl: AppConstants.baseURL,
        receiveDataWhenStatusError: true));

    dio.interceptors.addAll([
      /* InterceptorsWrapper(
        onRequest: (options, handler) {
          if (AppConstants.userToken != null) {
            options.headers.addAll({
              "Authorization": "Bearer ${AppConstants.userToken}",
            });
          }
          return handler.next(options);
        },
        onError: (e, handler) async {
          if (e.response?.statusCode == 401) {
            /*     CacheHelper.casheHelper.removeData('userToken').then((value) {
              AppConstants.userToken = null;
              CacheHelper.casheHelper.removeData('userId').then((value) {
                AppConstants.userId = null;
                CacheHelper.casheHelper.removeData('name').then((value) {
                  AppConstants.name = null;
                  CacheHelper.casheHelper.removeData('userType').then((value) {
                    AppConstants.userType = null;
                    Navigator.of(AppConstants.navKey.currentContext!)
                        .pushReplacementNamed(Routes.login);
                  });
                });
              });
            });*/
          }

          return handler.next(e);
        },
      ),*/
      LogInterceptor(
        requestHeader: true, responseHeader: false,
        responseBody: true,
        requestBody: true,
        //  request: true,
      ),
    ]);
  }

  static DioHelper get instance => _dioHelper;

  Future<Response> post(String path,
      {Object? body,
      String? token,
      Map<String, dynamic>? queryParameters}) async {
    Response res = await dio.post(path,
        data: body ?? {},
        queryParameters: queryParameters ?? {},
        options: Options(
            headers: token == null ? {} : {'Authorization': 'Bearer $token'}));
    return res;
  }

  Future<Response> update(String path,
      {Map? body, String? token, Map<String, dynamic>? queryParameters}) async {
    Response res = await dio.put(path,
        data: body ?? {},
        queryParameters: queryParameters ?? {},
        options: Options(
            headers: token == null ? {} : {'Authorization': 'Bearer $token'}));
    return res;
  }

  Future<Response> delete(String path,
      {Map? body, String? token, Map<String, dynamic>? queryParameters}) async {
    Response res = await dio.delete(path,
        data: body ?? {},
        queryParameters: queryParameters ?? {},
        options: Options(
            headers: token == null ? {} : {'Authorization': 'Bearer $token'}));
    return res;
  }

  Future<Response> get(String path,
      {Map? body, String? token, Map<String, dynamic>? queryParameters}) async {
    Response res = await dio.get(path,
        data: body ?? {},
        queryParameters: queryParameters ?? {},
        options: Options(
            headers: token == null ? {} : {'Authorization': 'Bearer $token'}));
    return res;
  }
}
