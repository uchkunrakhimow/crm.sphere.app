class OrderResponse {
  String? message;
  List<OrderModel>? ordersList;

  OrderResponse({this.message, this.ordersList});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      ordersList = <OrderModel>[];
      json['data'].forEach((v) {
        ordersList!.add(new OrderModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  String? status;
  List<ProductsIds>? productsIds;
  String? region;
  String? address;
  List<Payments>? paymentType;
  bool? isArchive;
  List<MessageModel>? messages;
  String? createdAt;
  String? updatedAt;
  bool? isExpanded;

  OrderModel({
    this.id,
    this.operatorId,
    this.courierId,
    this.logisticianId,
    this.fullName,
    this.phoneNumber,
    this.phoneNumber2,
    this.status,
    this.productsIds,
    this.region,
    this.address,
    this.paymentType,
    this.isArchive,
    this.messages,
    this.createdAt,
    this.updatedAt,
    this.isExpanded,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    operatorId = json['operatorId'] != null
        ? new OperatorId.fromJson(json['operatorId'])
        : null;
    courierId = json['courierId'] != null
        ? new OperatorId.fromJson(json['courierId'])
        : null;
    logisticianId = json['logisticianId'] != null
        ? new OperatorId.fromJson(json['logisticianId'])
        : null;
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    phoneNumber2 = json['phoneNumber2'];
    status = json['status'];
    if (json['productsIds'] != null) {
      productsIds = <ProductsIds>[];
      json['productsIds'].forEach((v) {
        productsIds!.add(new ProductsIds.fromJson(v));
      });
    }
    region = json['region'];
    address = json['address'];
    if (json['payments'] != null) {
      paymentType = <Payments>[];
      json['payments'].forEach((v) {
        paymentType!.add(new Payments.fromJson(v));
      });
    }
    isArchive = json['is_archive'];
    if (json['messages'] != null) {
      messages = <MessageModel>[];
      json['messages'].forEach((v) {
        messages!.add(new MessageModel.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['status'] = this.status;
    if (this.productsIds != null) {
      data['productsIds'] = this.productsIds!.map((v) => v.toJson()).toList();
    }
    data['region'] = this.region;
    data['address'] = this.address;
    if (this.paymentType != null) {
      data['payments'] = this.paymentType!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['comment'] = this.comment;
    return data;
  }
}

class Payments {
  String? method;
  int? amount;
  String? id;

  Payments({this.method, this.amount, this.id});

  Payments.fromJson(Map<String, dynamic> json) {
    method = json['method'];
    amount = json['amount'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['method'] = this.method;
    data['amount'] = this.amount;
    data['_id'] = this.id;
    return data;
  }
}

class MessageModel {
  String? commenterRole;
  String? commentText;
  String? orderId;
  String? createdAt;

  MessageModel(
      {this.commenterRole, this.commentText, this.orderId, this.createdAt});

  MessageModel.fromJson(Map<String, dynamic> json) {
    commenterRole = json['commenterRole'];
    commentText = json['commentText'];
    orderId = json['orderId'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commenterRole'] = this.commenterRole;
    data['commentText'] = this.commentText;
    data['orderId'] = this.orderId;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
