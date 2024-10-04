enum MessageType { operator, courier }

class OrderResponse {
  String? message;
  List<OrderModel>? ordersList;

  OrderResponse({this.message, this.ordersList});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      ordersList = <OrderModel>[];
      json['data'].forEach((v) {
        ordersList!.add(OrderModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = this.message;
    if (this.ordersList != null) {
      data['data'] = this.ordersList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderModel {
  String? id;
  OperatorId? operatorId;
  OperatorId? courierId;
  OperatorId? logisticianId;
  String? fullName;
  String? phoneNumber;
  String? phoneNumber2;
  StatusId? statusId;
  String? status;
  List<ProductsIds>? productsIds;
  String? paymentType;
  ShiftId? shiftId;
  String? region;
  String? address;
  SourceId? sourceId;
  bool? isArchive;
  List<MessageModel>? messages;
  String? createdAt;
  String? updatedAt;

  OrderModel(
      {this.id,
      this.operatorId,
      this.courierId,
      this.logisticianId,
      this.fullName,
      this.phoneNumber,
      this.phoneNumber2,
      this.statusId,
      this.status,
      this.productsIds,
      this.paymentType,
      this.shiftId,
      this.region,
      this.address,
      this.sourceId,
      this.isArchive,
      this.messages,
      this.createdAt,
      this.updatedAt});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    operatorId = json['operatorId'] != null
        ? OperatorId.fromJson(json['operatorId'])
        : null;
    courierId = json['courierId'] != null
        ? OperatorId.fromJson(json['courierId'])
        : null;
    logisticianId = json['logisticianId'] != null
        ? OperatorId.fromJson(json['logisticianId'])
        : null;
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    phoneNumber2 = json['phoneNumber2'];
    statusId = json['statusId'] != null
        ? new StatusId.fromJson(json['statusId'])
        : null;
    status = json['status'];
    if (json['productsIds'] != null) {
      productsIds = <ProductsIds>[];
      json['productsIds'].forEach((v) {
        productsIds!.add(ProductsIds.fromJson(v));
      });
    }
    paymentType = json['paymentType'];
    shiftId =
        json['shiftId'] != null ? ShiftId.fromJson(json['shiftId']) : null;
    region = json['region'];
    address = json['address'];
    sourceId =
        json['sourceId'] != null ? SourceId.fromJson(json['sourceId']) : null;
    isArchive = json['is_archive'];
    if (json['messages'] != null) {
      messages = <MessageModel>[];
      json['messages'].forEach((v) {
        messages!.add(MessageModel.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.id;
    if (this.operatorId != null) {
      data['operatorId'] = this.operatorId!.toJson();
    }
    if (this.courierId != null) {
      data['courierId'] = this.courierId!.toJson();
    }
    if (this.logisticianId != null) {
      data['logisticianId'] = this.logisticianId!.toJson();
    }
    data['fullName'] = this.fullName;
    data['phoneNumber'] = this.phoneNumber;
    data['phoneNumber2'] = this.phoneNumber2;
    if (this.statusId != null) {
      data['statusId'] = this.statusId!.toJson();
    }
    data['status'] = this.status;
    if (this.productsIds != null) {
      data['productsIds'] = this.productsIds!.map((v) => v.toJson()).toList();
    }
    data['paymentType'] = this.paymentType;
    if (this.shiftId != null) {
      data['shiftId'] = this.shiftId!.toJson();
    }
    data['region'] = this.region;
    data['address'] = this.address;
    if (this.sourceId != null) {
      data['sourceId'] = this.sourceId!.toJson();
    }
    data['is_archive'] = this.isArchive;
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class OperatorId {
  String? id;
  String? name;
  String? username;

  OperatorId({this.id, this.name, this.username});

  OperatorId.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    return data;
  }
}

class StatusId {
  String? sId;
  String? title;
  String? color;

  StatusId({this.sId, this.title, this.color});

  StatusId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['color'] = this.color;
    return data;
  }
}

class ProductsIds {
  String? id;
  String? title;
  String? price;
  String? comment;

  ProductsIds({this.id, this.title, this.price, this.comment});

  ProductsIds.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    price = json['price'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['comment'] = this.comment;
    return data;
  }
}

class ShiftId {
  String? id;
  String? name;
  String? time;

  ShiftId({this.id, this.name, this.time});

  ShiftId.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['time'] = this.time;
    return data;
  }
}

class SourceId {
  String? id;
  String? title;
  String? comment;

  SourceId({this.id, this.title, this.comment});

  SourceId.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.id;
    data['title'] = this.title;
    data['comment'] = this.comment;
    return data;
  }
}

class MessageModel {
  String? id;
  String? orderId;
  String? commenterRole;
  String? commentText;
  String? createdAt;

  MessageModel({this.commenterRole, this.commentText, this.id, this.createdAt});

  MessageModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    orderId = json['orderId'];
    commenterRole = json['commenterRole'];
    commentText = json['commentText'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.id;
    data['orderId'] = this.orderId;
    data['commenterRole'] = this.commenterRole;
    data['commentText'] = this.commentText;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
