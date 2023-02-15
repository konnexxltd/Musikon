import 'dart:developer';

import 'package:dio/dio.dart';

import '../utils/utils.dart';

class Repository {
  Dio dio = Dio();

  static String accessToken;

  static String userId;

  static String url = "https://musikon.directus.app";

  void onRequest(RequestOptions request, RequestInterceptorHandler response) {
    return response.next(request);
  }

  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 401) {
      refreshAccessToken();
    }
    return handler.next(response);
  }

  Future<dynamic> login(String email, String password) async {
    try {
      var response = await dio.post(
        "$url/auth/login",
        data: {"email": email, "password": password},
      );

      accessToken = response.data['data']["access_token"];
      String refreshToken = response.data['data']["refresh_token"];

      await Utils.saveRefreshToken(refreshToken);

      dio.interceptors.add(
          InterceptorsWrapper(onRequest: onRequest, onResponse: onResponse));

      log("Repository.login ${response.statusCode}");

      return response.data;
    } catch (e) {
      log("Repository.login ${e.toString()}");
      return null;
    }
  }

  Future<dynamic> register(
    String email,
    String password,
      String token
  ) async {
    try {
      var response = await dio.post(
        "$url/users",
        data: {
          "email": email,
          "password": password,
          "role": "0ccfebd7-b717-4962-ae16-3341eceee202",
          "token": token,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer dHd5FLfyQeWiGnha-kuWNQN0-VOUJfOT",
            "Content-Type": "application/json",
          },
        ),
      );
      log("Repository.register ${response.statusCode}");

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return null;
      }
    } catch (e) {
      log("Repository.register ${e.toString()}");
      return null;
    }
  }

  Future<dynamic> refreshAccessToken() async {
    try {
      var token = await Utils.getRefreshToken();

      var response = await dio.post(
        "$url/auth/refresh",
        data: {"refresh_token": token},
      );

      accessToken = response.data['data']["access_token"];
      String refreshToken = response.data['data']["refresh_token"];

      await Utils.saveRefreshToken(refreshToken);

      dio.interceptors.add(
          InterceptorsWrapper(onRequest: onRequest, onResponse: onResponse));

      log("Repository.refreshAccessToken ${response.statusCode}");

      return response.data;
    } catch (e) {
      log("Repository.refreshAccessToken ${e.toString()}");
      return null;
    }
  }

  Future<dynamic> getStrings() async {
    try {
      var response = await dio.get(
        "$url/items/Configuration",
      );

      log("Repository.getStrings ${response.statusCode}");

      return response.data['data']['strings'];
    } catch (e) {
      log("Repository.getStrings ${e.toString()}");
      return await getStrings();
    }
  }

  Future<dynamic> getSettings() async {
    try {
      var response = await dio.get(
        "$url/items/Configuration",
      );

      log("Repository.getSettings ${response.statusCode}");

      dynamic settings = response.data['data']['settings'];

      return settings;
    } catch (e) {
      log("Repository.getSettings ${e.toString()}");
      return await getSettings();
    }
  }
}
