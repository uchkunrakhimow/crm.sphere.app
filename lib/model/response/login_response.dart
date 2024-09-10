class LoginResponse {
  LoginResponse({
    this.responseCode,
    this.nextStep,
    this.code,
    this.success,
    this.message,
    this.data,
  });

  int? responseCode;
  String? nextStep;
  int? code;
  bool? success;
  String? message;
  String? data;

  LoginResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    nextStep = json['nextStep'];
    code = json['code'];
    success = json['success'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['responseCode'] = responseCode;
    data['nextStep'] = nextStep;
    data['code'] = code;
    data['success'] = success;
    data['message'] = message;
    data['data'] = data;
    return data;
  }
}
