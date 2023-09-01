class WalletTransactionModel {
  int? status;
  String? walletBalance;
  WalletTData? walletTData;

  WalletTransactionModel({this.status, this.walletBalance, this.walletTData});

  WalletTransactionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    walletBalance = json['wallet_balance'];
    walletTData = json['data'] != null ? WalletTData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['wallet_balance'] = this.walletBalance;
    if (this.walletTData != null) {
      data['data'] = this.walletTData!.toJson();
    }
    return data;
  }
}

class WalletTData {
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

  WalletTData(
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

  WalletTData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
  String? debitAmount;
  String? creditAmount;
  String? creditDate;
  String? debitDate;
  int? creditTransactionType;
  int? debitTransactionType;
  int? withdrawStatus;
  String? status;
  String? createAt;

  Data(
      {this.id,
        this.debitAmount,
        this.creditAmount,
        this.creditDate,
        this.debitDate,
        this.creditTransactionType,
        this.debitTransactionType,
        this.withdrawStatus,
        this.status,
        this.createAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    debitAmount = json['debit_amount'];
    creditAmount = json['credit_amount'];
    creditDate = json['credit_date'];
    debitDate = json['debit_date'];
    creditTransactionType = json['credit_transaction_type'];
    debitTransactionType = json['debit_transaction_type'];
    withdrawStatus = json['withdraw_status'];
    status = json['status'];
    createAt = json['create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['debit_amount'] = this.debitAmount;
    data['credit_amount'] = this.creditAmount;
    data['credit_date'] = this.creditDate;
    data['debit_date'] = this.debitDate;
    data['credit_transaction_type'] = this.creditTransactionType;
    data['debit_transaction_type'] = this.debitTransactionType;
    data['withdraw_status'] = this.withdrawStatus;
    data['status'] = this.status;
    data['create_at'] = this.createAt;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}