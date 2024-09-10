import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tedbook/model/response/error_response.dart';
import 'package:tedbook/utils/constant.dart';

debugLog(String s) {
  if (kDebugMode) log(s);
}

String getErrorMessage(error) {
  String errorMessage = SERVER_ERROR;
  if (error is DioException && error.response != null) {
    try {
      final response = ErrorResponse.fromJson(error.response?.data);
      debugLog("response ${response.error}");
      errorMessage = response.error ?? SERVER_ERROR;
    } catch (e) {
      debugLog(e.toString());
    }
  }
  return errorMessage;
}

String currencyFormatter(double? number, {decimalDigit = 2}) {
  final formatCurrency = NumberFormat.currency(
      locale: "en_US", symbol: "", decimalDigits: decimalDigit);
  return formatCurrency.format(number).replaceAll(",", " ");
}

const int intMaxValue = 9223372036854775807;

String timerFormat(num seconds) =>
    "${(seconds ~/ 60).toString().padLeft(2, "0")}:${(seconds % 60).toString().padLeft(2, "0")}";

String accessTokenExpDate(int sec) => DateFormat("yyyy-MM-dd hh:mm:ss")
    .format(DateTime.now().add(Duration(seconds: sec)));

extension BuildContextX on BuildContext {
  void replaceSnackbar({
    required Widget content,
  }) {
    final scaffoldMessenger = ScaffoldMessenger.of(this);
    scaffoldMessenger.removeCurrentSnackBar();
    scaffoldMessenger.showSnackBar(
      SnackBar(content: content),
    );
  }
}

int osType() {
  var result = 0;
  if (Platform.isAndroid) result = 1;
  if (Platform.isIOS) result = 2;
  return result;
}
