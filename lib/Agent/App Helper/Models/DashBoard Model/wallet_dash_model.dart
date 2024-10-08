class WalletDashModel {
  int? status;
  String? totalWalletAmount;
  WalletDData? walletDData;

  WalletDashModel({this.status, this.totalWalletAmount, this.walletDData});

  WalletDashModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalWalletAmount = json['total_wallet_amount'];
    walletDData = json['data'] != null ? new WalletDData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['total_wallet_amount'] = this.totalWalletAmount;
    if (this.walletDData != null) {
      data['data'] = this.walletDData!.toJson();
    }
    return data;
  }
}

class WalletDData {
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

  WalletDData(
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

  WalletDData.fromJson(Map<String, dynamic> json) {
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
  dynamic firstName;
  dynamic serviceName;
  dynamic letterTypeName;
  int? userId;
  String? creditAmount;
  String? debitAmount;
  int? debitTransactionType;
  String? creditDate;
  String? refundDate;
  String? paymentDate;
  String? createdAt;
  int? status;
  int? walletPaymentStatus;
  dynamic lastName;
  dynamic middleName;
  dynamic orderPrice;
  String? cdata;
  String? paymentOn;
  String? cancelOn;
  String? refundOn;

  Data(
      {this.id,
        this.firstName,
        this.serviceName,
        this.letterTypeName,
        this.userId,
        this.creditAmount,
        this.debitAmount,
        this.debitTransactionType,
        this.creditDate,
        this.refundDate,
        this.paymentDate,
        this.createdAt,
        this.status,
        this.walletPaymentStatus,
        this.lastName,
        this.middleName,
        this.orderPrice,
        this.cdata,
        this.paymentOn,
        this.cancelOn,
        this.refundOn});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    serviceName = json['service_name'];
    letterTypeName = json['letter_type_name'];
    userId = json['user_id'];
    creditAmount = json['credit_amount'];
    debitAmount = json['debit_amount'];
    debitTransactionType = json['debit_transaction_type'];
    creditDate = json['credit_date'];
    refundDate = json['refund_date'];
    paymentDate = json['payment_date'];
    createdAt = json['created_at'];
    status = json['status'];
    walletPaymentStatus = json['wallet_payment_status'];
    lastName = json['last_name'];
    middleName = json['middle_name'];
    orderPrice = json['order_price'];
    cdata = json['cdata'];
    paymentOn = json['payment_on'];
    cancelOn = json['cancel_on'];
    refundOn = json['refund_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['service_name'] = this.serviceName;
    data['letter_type_name'] = this.letterTypeName;
    data['user_id'] = this.userId;
    data['credit_amount'] = this.creditAmount;
    data['debit_amount'] = this.debitAmount;
    data['debit_transaction_type'] = this.debitTransactionType;
    data['credit_date'] = this.creditDate;
    data['refund_date'] = this.refundDate;
    data['payment_date'] = this.paymentDate;
    data['created_at'] = this.createdAt;
    data['status'] = this.status;
    data['wallet_payment_status'] = this.walletPaymentStatus;
    data['last_name'] = this.lastName;
    data['middle_name'] = this.middleName;
    data['order_price'] = this.orderPrice;
    data['cdata'] = this.cdata;
    data['payment_on'] = this.paymentOn;
    data['cancel_on'] = this.cancelOn;
    data['refund_on'] = this.refundOn;
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