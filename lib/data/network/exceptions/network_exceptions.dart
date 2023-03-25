import 'package:grouu/models/base/base_response.dart';

class NetworkException implements Exception {
  final BaseResponse model;
  final String? message;

  NetworkException(this.message, this.model);
}

class RetrofitNetworkException implements Exception {
  String? message;
  int? statusCode;

  RetrofitNetworkException({this.message, this.statusCode});
}

class BadRequestException extends NetworkException {
  BadRequestException(BaseResponse model) : super("Bad Request Error:", model);
}

class UnauthorizedException extends NetworkException {
  UnauthorizedException(BaseResponse model)
      : super("Unauthorized Error:", model);
}

class NotFoundException extends NetworkException {
  NotFoundException(BaseResponse model) : super("Not Found Error:", model);
}

class ForbiddenException extends NetworkException {
  ForbiddenException(BaseResponse model) : super("Forbidden Error:", model);
}

class PreConditionedException extends NetworkException {
  PreConditionedException(BaseResponse model) : super("Error", model);
}

class NeedToVerifyEmailException extends NetworkException {
  NeedToVerifyEmailException(BaseResponse model) : super("Error", model);
}

class PassportSubmissionAlreadyCreatedException extends NetworkException {
  PassportSubmissionAlreadyCreatedException(BaseResponse model)
      : super("Error", model);
}

class UnprocessableEntityException extends NetworkException {
  UnprocessableEntityException(BaseResponse model)
      : super("Unprocessable Entity Error:", model);
}

class ServerErrorException extends NetworkException {
  ServerErrorException(BaseResponse model) : super("Server Error:", model);
}

class DefaultException implements Exception {
  final String? _message;

  DefaultException(this._message);
  @override
  String toString() => _message ?? "No internet connection";
}

class NoInternetException extends DefaultException {
  NoInternetException() : super('No internet connection');
}

class TimeoutException extends DefaultException {
  TimeoutException() : super('Request timeout, please try again');
}

class ApiResponseNotValidException extends DefaultException {
  ApiResponseNotValidException()
      : super('Server error, please report this to us');
}

class UnknownException extends DefaultException {
  UnknownException(e)
      : super(e != null
            ? e.toString()
            : 'Unknown error, please report this to us');
}
