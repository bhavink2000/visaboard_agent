class ServiceRequestedModel {
  int? status;
  ServiceRData? serviceRData;

  ServiceRequestedModel({this.status, this.serviceRData});

  ServiceRequestedModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    serviceRData = json['data'] != null ? new ServiceRData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.serviceRData != null) {
      data['data'] = this.serviceRData!.toJson();
    }
    return data;
  }
}

class ServiceRData {
  List<AppliedFor>? appliedFor;

  ServiceRData({this.appliedFor});

  ServiceRData.fromJson(Map<String, dynamic> json) {
    if (json['applied_for'] != null) {
      appliedFor = <AppliedFor>[];
      json['applied_for'].forEach((v) {
        appliedFor!.add(new AppliedFor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appliedFor != null) {
      data['applied_for'] = this.appliedFor!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppliedFor {
  String? createAt;
  String? countryName;
  String? letterTypeName;

  AppliedFor({this.createAt, this.countryName, this.letterTypeName});

  AppliedFor.fromJson(Map<String, dynamic> json) {
    createAt = json['create_at'];
    countryName = json['country_name'];
    letterTypeName = json['letter_type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['create_at'] = this.createAt;
    data['country_name'] = this.countryName;
    data['letter_type_name'] = this.letterTypeName;
    return data;
  }
}