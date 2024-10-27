class PaymentTypeModel {
  String? method;
  double? amount;

  PaymentTypeModel({this.method, this.amount});

  PaymentTypeModel.fromJson(Map<String, dynamic> json) {
    method = json['method'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['method'] = this.method;
    data['amount'] = this.amount;
    return data;
  }
}