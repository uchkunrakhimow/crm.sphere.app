class ResendSmsRequest {
  String? sessionTicketId;
  String? code;


  ResendSmsRequest({this.sessionTicketId, this.code});

  ResendSmsRequest.fromJson(Map<String, dynamic> json) {
    sessionTicketId = json['sessionTicketId'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sessionTicketId'] = sessionTicketId;
    data['code'] = code;
    return data;
  }
}
