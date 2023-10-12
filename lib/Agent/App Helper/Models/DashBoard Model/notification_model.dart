class NotificationModel {
  int? status;
  String? unreadCount;
  NotifiData? notifiData;

  NotificationModel({this.status, this.unreadCount, this.notifiData});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    unreadCount = json['unread_count'];
    notifiData = json['data'] != null ? new NotifiData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['unread_count'] = unreadCount;
    if (notifiData != null) {
      data['data'] = notifiData!.toJson();
    }
    return data;
  }
}

class NotifiData {
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

  NotifiData(
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

  NotifiData.fromJson(Map<String, dynamic> json) {
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
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Data {
  int? id;
  String? firstName;
  String? serviceName;
  String? letterTypeName;
  String? countryName;
  int? userId;
  int? status;
  String? userSopStatus;
  int? agentUnreadCount;
  String? orderPrice;
  String? lastName;
  String? middleName;
  String? price;
  String? razorpayPaymentId;
  String? mobileNo;
  int? serviceTypeId;
  int? cancelStatus;
  String? walletOrderPrice;
  String? invoicePdf;
  String? paytmOrderPrice;
  String? createAt;
  String? encUserId;
  String? encId;
  Action? action;

  Data(
      {this.id,
        this.firstName,
        this.serviceName,
        this.letterTypeName,
        this.countryName,
        this.userId,
        this.status,
        this.userSopStatus,
        this.agentUnreadCount,
        this.orderPrice,
        this.lastName,
        this.middleName,
        this.price,
        this.razorpayPaymentId,
        this.mobileNo,
        this.serviceTypeId,
        this.cancelStatus,
        this.walletOrderPrice,
        this.invoicePdf,
        this.paytmOrderPrice,
        this.createAt,
        this.encUserId,
        this.encId,
        this.action});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    serviceName = json['service_name'];
    letterTypeName = json['letter_type_name'];
    countryName = json['country_name'];
    userId = json['user_id'];
    status = json['status'];
    userSopStatus = json['user_sop_status'];
    agentUnreadCount = json['agent_unread_count'];
    orderPrice = json['order_price'];
    lastName = json['last_name'];
    middleName = json['middle_name'];
    price = json['price'];
    razorpayPaymentId = json['razorpay_payment_id'];
    mobileNo = json['mobile_no'];
    serviceTypeId = json['service_type_id'];
    cancelStatus = json['cancel_status'];
    walletOrderPrice = json['wallet_order_price'];
    invoicePdf = json['invoice_pdf'];
    paytmOrderPrice = json['paytm_order_price'];
    createAt = json['create_at'];
    encUserId = json['enc_user_id'];
    encId = json['enc_id'];
    action =
    json['action'] != null ? new Action.fromJson(json['action']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['first_name'] = firstName;
    data['service_name'] = serviceName;
    data['letter_type_name'] = letterTypeName;
    data['country_name'] = countryName;
    data['user_id'] = userId;
    data['status'] = status;
    data['user_sop_status'] = userSopStatus;
    data['agent_unread_count'] = agentUnreadCount;
    data['order_price'] = orderPrice;
    data['last_name'] = lastName;
    data['middle_name'] = middleName;
    data['price'] = price;
    data['razorpay_payment_id'] = razorpayPaymentId;
    data['mobile_no'] = mobileNo;
    data['service_type_id'] = serviceTypeId;
    data['cancel_status'] = cancelStatus;
    data['wallet_order_price'] = walletOrderPrice;
    data['invoice_pdf'] = invoicePdf;
    data['paytm_order_price'] = paytmOrderPrice;
    data['create_at'] = createAt;
    data['enc_user_id'] = encUserId;
    data['enc_id'] = encId;
    if (action != null) {
      data['action'] = action!.toJson();
    }
    return data;
  }
}

class Action {
  int? editStatus;
  int? uploadDocsStatus;
  int? chatStatus;
  int? paynowStatus;

  Action(
      {this.editStatus,
        this.uploadDocsStatus,
        this.chatStatus,
        this.paynowStatus});

  Action.fromJson(Map<String, dynamic> json) {
    editStatus = json['edit_status'];
    uploadDocsStatus = json['upload_docs_status'];
    chatStatus = json['chat_status'];
    paynowStatus = json['paynow_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['edit_status'] = editStatus;
    data['upload_docs_status'] = uploadDocsStatus;
    data['chat_status'] = chatStatus;
    data['paynow_status'] = paynowStatus;
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
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}