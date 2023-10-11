// To parse this JSON data, do
//
//     final leadFollowUpModel = leadFollowUpModelFromJson(jsonString);

import 'dart:convert';

LeadFollowUpModel leadFollowUpModelFromJson(String str) => LeadFollowUpModel.fromJson(json.decode(str));

String leadFollowUpModelToJson(LeadFollowUpModel data) => json.encode(data.toJson());

class LeadFollowUpModel {
  int? status;
  Data? data;

  LeadFollowUpModel({
    this.status,
    this.data,
  });

  factory LeadFollowUpModel.fromJson(Map<String, dynamic> json) => LeadFollowUpModel(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  int? currentPage;
  List<LeadFData>? data;
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

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<LeadFData>.from(json["data"]!.map((x) => LeadFData.fromJson(x))),
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

class LeadFData {
  int? id;
  int? agentId;
  int? adminId;
  String? followupContactNumber;
  String? followupName;
  String? followupEmail;
  String? followupReason;
  String? note;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? addedBy;
  String? encId;
  String? createAt;
  String? updateAt;

  LeadFData({
    this.id,
    this.agentId,
    this.adminId,
    this.followupContactNumber,
    this.followupName,
    this.followupEmail,
    this.followupReason,
    this.note,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.addedBy,
    this.encId,
    this.createAt,
    this.updateAt,
  });

  factory LeadFData.fromJson(Map<String, dynamic> json) => LeadFData(
    id: json["id"],
    agentId: json["agent_id"],
    adminId: json["admin_id"],
    followupContactNumber: json["followup_contact_number"],
    followupName: json["followup_name"],
    followupEmail: json["followup_email"],
    followupReason: json["followup_reason"],
    note: json["note"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    addedBy: json["added_by"],
    encId: json["enc_id"],
    createAt: json["create_at"],
    updateAt: json["update_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "agent_id": agentId,
    "admin_id": adminId,
    "followup_contact_number": followupContactNumber,
    "followup_name": followupName,
    "followup_email": followupEmail,
    "followup_reason": followupReason,
    "note": note,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "added_by": addedBy,
    "enc_id": encId,
    "create_at": createAt,
    "update_at": updateAt,
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
