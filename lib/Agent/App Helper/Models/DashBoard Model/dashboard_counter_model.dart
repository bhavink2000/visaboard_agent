class DashBoardCounterModel {
  int? status;
  Data? data;

  DashBoardCounterModel({this.status, this.data});

  DashBoardCounterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? referCode;
  List<String>? contactNo;
  List<Cards>? cards;

  Data({this.referCode, this.contactNo, this.cards});

  Data.fromJson(Map<String, dynamic> json) {
    referCode = json['refer_code'];
    contactNo = json['contact_no'].cast<String>();
    if (json['cards'] != null) {
      cards = <Cards>[];
      json['cards'].forEach((v) {
        cards!.add(new Cards.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refer_code'] = this.referCode;
    data['contact_no'] = this.contactNo;
    if (this.cards != null) {
      data['cards'] = this.cards!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cards {
  int? serviceCount;
  int? activeServiceCount;
  int? serviceId;
  String? serviceName;

  Cards(
      {this.serviceCount,
        this.activeServiceCount,
        this.serviceId,
        this.serviceName});

  Cards.fromJson(Map<String, dynamic> json) {
    serviceCount = json['service_count'];
    activeServiceCount = json['active_service_count'];
    serviceId = json['service_id'];
    serviceName = json['service_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_count'] = this.serviceCount;
    data['active_service_count'] = this.activeServiceCount;
    data['service_id'] = this.serviceId;
    data['service_name'] = this.serviceName;
    return data;
  }
}