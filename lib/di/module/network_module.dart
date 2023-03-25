import 'package:grouu/data/network/constants/endpoints.dart';
import 'package:grouu/data/sharedpref/shared_preference_helper.dart';
import 'package:dio/dio.dart';
import 'package:grouu/env/env.dart';
import 'package:grouu/models/base/base_response.dart';

import '../../data/network/exceptions/network_exceptions.dart';

abstract class NetworkModule {
  /// A singleton dio provider.
  ///
  /// Calling it multiple times will return the same instance.
  static Dio provideDio(SharedPreferenceHelper sharedPrefHelper) {
    final dio = Dio();

    dio
      ..options.baseUrl = Constants.baseApi
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..options.headers = {'Content-Type': 'application/json; charset=utf-8'}
      ..interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ))
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options,
              RequestInterceptorHandler handler) async {
            // getting token
            var token = await sharedPrefHelper.authToken;
            if (token != null) {
              options.headers.addAll({'Authorization': "Bearer $token"});
            } else {
              print('Auth token is null');
            }

            return handler.next(options);
          },
        ),
      );

    return dio;
  }

  static Future<BaseResponse> handleDioErrorResponse(DioError error) async {
    switch (error.type) {
      case DioErrorType.response:
        if (checkIfResponseValid(error.response!.data)) {
          return handleApiResponse(error.response!);
        }
        break;
      case DioErrorType.connectTimeout:
        return Future.error(TimeoutException());
      case DioErrorType.sendTimeout:
        return Future.error(TimeoutException());
      case DioErrorType.receiveTimeout:
        return Future.error(TimeoutException());
      default:
        return Future.error(TimeoutException());
    }
    return Future.error(TimeoutException());
  }

  static Future<BaseResponse> handleApiResponse(Response response) async {
    if (!checkIfResponseValid(response.data)) {
      return Future.error(ApiResponseNotValidException());
    }
    final BaseResponse _parsedResponse =
        BaseResponse.fromJson(response.data, (data) {
      return data;
    });

    if (response.statusCode.toString()[0] == "2") {
      return _parsedResponse;
    }

    switch (response.statusCode) {
      case 400:
        return Future.error(BadRequestException(_parsedResponse));
      case 401:
        return Future.error(UnauthorizedException(_parsedResponse));
      case 404:
        return Future.error(NotFoundException(_parsedResponse));
      case 403:
        return Future.error(ForbiddenException(_parsedResponse));
      case 412:
        return Future.error(PreConditionedException(_parsedResponse));
      case 422:
        return Future.error(UnprocessableEntityException(_parsedResponse));
      case 500:
        return Future.error(ServerErrorException(_parsedResponse));
      default:
        return Future.error(ApiResponseNotValidException());
    }
  }

  static List<String> validResponseKeys = ['data'];

  static bool checkIfResponseValid(dynamic data) {
    if (data is Map<String, dynamic>) {
      for (String key in validResponseKeys) {
        if (data.containsKey(key)) {
          return true;
        }
      }
    }
    return false;
  }
}
