import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tedbook/model/request/login_request.dart';
import 'package:tedbook/model/request/set_device_info_request.dart';
import 'package:tedbook/model/response/general_user_data_response.dart';
import 'package:tedbook/model/response/login_response.dart';
import 'package:tedbook/model/response/set_device_info_response.dart';
import 'package:tedbook/model/response/verify_sms_response.dart';
import 'package:tedbook/persistance/service_locator.dart';
import 'package:tedbook/persistance/user_data.dart';
import 'package:tedbook/utils/utils.dart';
import 'exceptions.dart';

class ApiProvider {
  final Dio _dio = Dio();

  ApiProvider._() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          UserData userData = getInstance();
          if (!options.path.contains("/refresh-token")) {
            var token = await userData.accessToken();
            String? accessTokenExpDate =
                await userData.accessTokenExpirationDate();
            if (token?.isNotEmpty == true &&
                !options.headers.containsKey(HttpHeaders.authorizationHeader)) {
              final tokenExpired = accessTokenExpDate != null
                  ? DateTime.now().isAfter(DateTime.parse(accessTokenExpDate))
                  : false;
              if (tokenExpired) {
                final token = await getAccessToken();
                if (token == null) {
                  return;
                } else {
                  options.headers.putIfAbsent(
                      HttpHeaders.authorizationHeader, () => 'Bearer $token');
                }
              } else {
                options.headers.putIfAbsent(
                    HttpHeaders.authorizationHeader, () => 'Bearer $token');
              }
            }
          }
          options.headers.putIfAbsent(HttpHeaders.contentTypeHeader,
              () => 'application/json; charset=UTF-8');
          final preferences = await SharedPreferences.getInstance();
          final strLocale = preferences.getString('locale');
          options.headers["Accept-Language"] = strLocale ?? "uz";
          if (kDebugMode) {
            debugLog(
                "----------------------------------------------------------------\n\t\t\tRequest\n\tMethod: ${options.method}\n\tPath: ${options.path}\n\tHeader: ${options.headers}\n${options.data != null ? "\tBody: ${getBodyData(options.data)}\n" : ""}\n----------------------------------------------------------------------");
          }
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          retryCount = 0;
          debugLog(
              "----------------------------------------------------------------\n\t\t\tResponse\n\tMethod: ${response.requestOptions.method}\n\tPath: ${response.requestOptions.path}\n\tStatusCode: ${response.statusCode}\n\tStatusMessage: ${response.statusMessage}\n\tHeader: ${response.requestOptions.headers}\n${response.data != null ? "\tBody: ${getBodyData(response.data)}\n" : ""}\n----------------------------------------------------------------------");
          return handler.next(response);
        },
        onError: (DioException e, ErrorInterceptorHandler handler) async {
          debugLog("DioException $e");
          debugLog(
              "----------------------------------------------------------------\n\t\t\t\tError\n\tMethod: ${e.requestOptions.method}\n\tPath: ${e.requestOptions.path}\n\tStatusCode: ${e.response?.statusCode}\n\tStatusMessage: ${e.response?.statusMessage}\n\tHeader: ${e.requestOptions.headers}\n${e.requestOptions.data != null ? "\tBody: ${getBodyData(e.requestOptions.data)}\n" : ""}\n\tResponse body: ${e.response?.data}\n----------------------------------------------------------------------");
          if (e.response?.statusCode == HttpStatus.unauthorized) {
            return handler.next(e);
          } else {
            return handler.next(e);
          }
        },
      ),
    );
  }

  // Attention!!!
  // Don't use create or default constructor. Use getInstance() method to get ApiProvider object
  factory ApiProvider.create() => ApiProvider._();

  static const baseUrl = 'https://dev.api.pharmagency.uz';

  static const authApi = '$baseUrl/auth-api/v1/mobile-auth';

  var retryCount = 0;

  String getBodyData(dynamic data) {
    try {
      if (data is FormData) {
        return data.fields.toString();
      }
      return jsonEncode(data);
    } catch (e) {
      return data;
    }
  }

  bool _isRefreshing = false;
  final Queue<Completer<String>> _tokenRefreshQueue = Queue();

  Future<String?> getAccessToken() async {
    String? accessToken;
    if (_isRefreshing) {
      Completer<String> completer = Completer();
      _tokenRefreshQueue.add(completer);
      return completer.future;
    }
    _isRefreshing = true;
    try {
      String newToken = await refreshToken();
      accessToken = newToken;
      while (_tokenRefreshQueue.isNotEmpty) {
        _tokenRefreshQueue.removeFirst().complete(newToken);
      }
    } catch (error) {
      // final context = MyApp.navigatorKey.currentContext;
      // context?.read<MainBloc>().add(LogoutEvent());
      while (_tokenRefreshQueue.isNotEmpty) {
        _tokenRefreshQueue.removeFirst().completeError(error);
      }
    } finally {
      _isRefreshing = false;
    }
    return accessToken;
  }

  Future refreshToken() async {
    debugLog("-------------------refreshToken-------------------");
    var res;
    try {
      var url = '$baseUrl/auth-api/v1/auth/get-token-by-user-id';
      Map<String, dynamic> body = {};
      UserData userData = getInstance();
      body["userId"] = await userData.userId();
      body["appVersion"] = "0.0.1";
      final response = await _dio.post(url, data: jsonEncode(body));
      TokenData successResponse = TokenData.fromJson(response.data);
      if (successResponse.accessToken != null) {
        UserData userData = getInstance();
        await userData.saveAccessToken(successResponse.accessToken!);
        // if (successResponse.refreshToken != null) {
        //   await userData.saveAccessToken(
        //     successResponse.accessToken!,
        //   );
        // }
        res = successResponse.accessToken;
      }
    } on FetchDataException {
      throw FetchDataException(message: "No Internet connection");
    }
    return res;
  }

  Future<SetDeviceInfoResponse> setDeviceInfo(
      SetDeviceInfoRequest request) async {
    try {
      debugLog("${request.toJson()}");

      final response =
          (await _dio.post("$authApi/device-info", data: request.toJson()))
              .data;
      return SetDeviceInfoResponse.fromJson(response);
    } catch (e) {
      debugLog("$e");
      throw FetchDataException(message: getErrorMessage(e));
    }
  }

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      debugLog("${request.toJson()}");

      final response = (await _dio.post(
        "$authApi/sms-confirmation-request",
        data: request.toJson(),
      ))
          .data;
      return LoginResponse.fromJson(response);
    } catch (e) {
      debugLog("$e");
      throw FetchDataException(message: getErrorMessage(e));
    }
  }

  Future<GeneralUserDataResponse> generalAuthUserData(String token) async {
    try {
      final response = (await _dio.get(
        "$baseUrl/auth-api/v1/auth/get-mobile-user",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      ))
          .data;

      return GeneralUserDataResponse.fromJson(response);
    } catch (e) {
      debugLog("$e");
      throw FetchDataException(message: getErrorMessage(e));
    }
  }
}
