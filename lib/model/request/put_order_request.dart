class PutOrderRequest {
  bool? isArchive;
  String? status;

  PutOrderRequest({this.isArchive, this.status});

  PutOrderRequest.fromJson(Map<String, dynamic> json) {
    isArchive = json['is_archive'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_archive'] = this.isArchive;
    data['status'] = this.status;
    return data;
  }
}
