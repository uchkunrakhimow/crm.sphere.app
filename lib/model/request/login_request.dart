class LoginRequest {
  String? sessionTicketId;
  String? phone;
  String? email;

  LoginRequest({
    this.sessionTicketId,
    this.email,
    this.phone,
  });

  LoginRequest.fromJson(Map<String, dynamic> json) {
    sessionTicketId = json['sessionTicketId'];
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sessionTicketId'] = sessionTicketId;
    if (phone != null) data['phone'] = phone;
    if (email != null) data['email'] = email;
    return data;
  }
}
