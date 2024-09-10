import 'package:tedbook/utils/constant.dart';

class CustomException implements Exception {
  final message;
  final _prefix;

  CustomException([this.message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException({String? message})
      : super(message ?? SERVER_ERROR, "Error During Communication: ");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends CustomException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}

class StatusCodeException extends CustomException {
  StatusCodeException([int? code]) : super(code, "");
}

enum StatusCode { simple, code403 }
