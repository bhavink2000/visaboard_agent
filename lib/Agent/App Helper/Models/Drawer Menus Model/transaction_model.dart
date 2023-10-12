class TransactionModel {
  int? status;
  TransactionData? transactionData;

  TransactionModel({this.status, this.transactionData});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    transactionData = json['data'] != null ? new TransactionData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.transactionData != null) {
      data['data'] = this.transactionData!.toJson();
    }
    return data;
  }
}

class TransactionData {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  TransactionData(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  TransactionData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Data {
  int? id;
  String? firstName;
  String? serviceName;
  String? letterTypeName;
  int? userId;
  String? orderPrice;
  int? status;
  String? paymentDate;
  String? lastName;
  String? middleName;
  String? price;
  int? cancelStatus;
  String? cancelDate;
  String? createAt;
  dynamic action;
  String? encId;

  Data(
      {this.id,
        this.firstName,
        this.serviceName,
        this.letterTypeName,
        this.userId,
        this.orderPrice,
        this.status,
        this.paymentDate,
        this.lastName,
        this.middleName,
        this.price,
        this.cancelStatus,
        this.cancelDate,
        this.createAt,
        this.action,
        this.encId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    serviceName = json['service_name'];
    letterTypeName = json['letter_type_name'];
    userId = json['user_id'];
    orderPrice = json['order_price'];
    status = json['status'];
    paymentDate = json['payment_date'];
    lastName = json['last_name'];
    middleName = json['middle_name'];
    price = json['price'];
    cancelStatus = json['cancel_status'];
    cancelDate = json['cancel_date'];
    createAt = json['create_at'];
    action = json['action'];
    encId = json['enc_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['service_name'] = this.serviceName;
    data['letter_type_name'] = this.letterTypeName;
    data['user_id'] = this.userId;
    data['order_price'] = this.orderPrice;
    data['status'] = this.status;
    data['payment_date'] = this.paymentDate;
    data['last_name'] = this.lastName;
    data['middle_name'] = this.middleName;
    data['price'] = this.price;
    data['cancel_status'] = this.cancelStatus;
    data['cancel_date'] = this.cancelDate;
    data['create_at'] = this.createAt;
    data['action'] = this.action;
    data['enc_id'] = this.encId;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}