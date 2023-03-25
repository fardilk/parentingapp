import 'package:dio/dio.dart';

import '../../../../models/base/base_response.dart';
import '../../constants/endpoints.dart';
import '../../dio_client.dart';

class AuthenticationApi {
  final DioClient _dioClient;
  AuthenticationApi(this._dioClient);

  Future<BaseResponse<Object?>> postLogin(String email, String password) async {
    final response = await _dioClient.post(
      Endpoints.postLogin,
      data: {
        "email": email,
        "password": password,
      },
      options: Options(validateStatus: (status) => status! < 500),
    );
    return BaseResponse.fromJson(
      response,
      (data) {
        return data;
      },
    );
  }

  Future<BaseResponse<Object?>> postForgotPassword(String email) async {
    final response = await _dioClient.post(Endpoints.postForgotPassword, data: {
      "email": email,
    });
    return BaseResponse.fromJson(
      response,
      (data) {
        return data;
      },
    );
  }

  Future<BaseResponse<Object?>> postVerifyEmail(String email) async {
    final response = await _dioClient.post(Endpoints.postVerifyEmail,
        data: {"email": email},
        options: Options(receiveDataWhenStatusError: true));
    return BaseResponse.fromJson(
      response,
      (data) {
        return data;
      },
    );
  }

  Future<BaseResponse<Object?>> postForgotOtp(String otp) async {
    final response =
        await _dioClient.post(Endpoints.postVerifyForgotOtp, data: {
      "forgot_otp": otp,
    });
    return BaseResponse.fromJson(
      response,
      (data) {
        return data;
      },
    );
  }

  Future<BaseResponse<Object?>> postVerifyOtp(String otp) async {
    final response =
        await _dioClient.post(Endpoints.postVerifyOtp, data: {"otp": otp});
    return BaseResponse.fromJson(
      response,
      (data) {
        return data;
      },
    );
  }

  Future<BaseResponse<Object?>> postUpdatePassword(
      String email, String password) async {
    final response = await _dioClient.post(
      Endpoints.postUpdatePassword,
      data: {
        "email": email,
        "password": password,
      },
    );
    return BaseResponse.fromJson(
      response,
      (data) {
        return data;
      },
    );
  }

  Future<BaseResponse<Object?>> postRegister(
      String email, String password) async {
    try {
      final response = await _dioClient.post(
        Endpoints.postRegister,
        data: {"email": email, "password": password},
        options: Options(validateStatus: (status) => status! < 500),
      );
      return BaseResponse.fromJson(
        response,
        (data) {
          return data;
        },
      );
    } catch (e) {
      throw e;
    }
  }
}
