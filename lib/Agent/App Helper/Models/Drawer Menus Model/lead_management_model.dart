// To parse this JSON data, do
//
//     final leadManagementModel = leadManagementModelFromJson(jsonString);

import 'dart:convert';

LeadManagementModel leadManagementModelFromJson(String str) => LeadManagementModel.fromJson(json.decode(str));

String leadManagementModelToJson(LeadManagementModel data) => json.encode(data.toJson());

class LeadManagementModel {
  int? status;
  LMData? lmData;
  List<String>? statusList;

  LeadManagementModel({
    this.status,
    this.lmData,
    this.statusList,
  });

  factory LeadManagementModel.fromJson(Map<String, dynamic> json) => LeadManagementModel(
    status: json["status"],
    lmData: json["data"] == null ? null : LMData.fromJson(json["data"]),
    statusList: json["statusList"] == null ? [] : List<String>.from(json["statusList"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": lmData?.toJson(),
    "statusList": statusList == null ? [] : List<dynamic>.from(statusList!.map((x) => x)),
  };
}

class LMData {
  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  LMData({
    this.currentPage,
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
    this.total,
  });

  factory LMData.fromJson(Map<String, dynamic> json) => LMData(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Datum {
  int? id;
  String? nameOfApplicant;
  String? contactNumber;
  String? emailId;
  dynamic dateOfBirth;
  dynamic city;
  dynamic country;
  String? status;
  int? dropdown;
  dynamic category;
  String? createAt;

  Datum({
    this.id,
    this.nameOfApplicant,
    this.contactNumber,
    this.emailId,
    this.dateOfBirth,
    this.city,
    this.country,
    this.status,
    this.dropdown,
    this.category,
    this.createAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    nameOfApplicant: json["name_of_applicant"],
    contactNumber: json["contact_number"],
    emailId: json["email_id"],
    dateOfBirth: json["date_of_birth"],
    city: json["city"],
    country: json["country"],
    status: json["status"],
    dropdown: json["dropdown"],
    category: json["category"],
    createAt: json["create_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name_of_applicant": nameOfApplicant,
    "contact_number": contactNumber,
    "email_id": emailId,
    "date_of_birth": dateOfBirth,
    "city": city,
    "country": country,
    "status": status,
    "dropdown": dropdown,
    "category": category,
    "create_at": createAt,
  };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
