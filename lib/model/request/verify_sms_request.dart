class VerifySmsRequest {
  VerifySmsRequest({
    this.sessionTicketId,
    this.code,
  });

  String? sessionTicketId;
  String? code;

  VerifySmsRequest.fromJson(Map<String, dynamic> json) {
    sessionTicketId = json['sessionTicketId'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['sessionTicketId'] = sessionTicketId;
    data['code'] = code;
    return data;
  }
}
