// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  int? status;
  String? message;
  ProfileData? data;

  ProfileModel({
    this.status,
    this.message,
    this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : ProfileData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class ProfileData {
  int? id;
  int? parentId;
  String? referralCode;
  String? firstName;
  String? middleName;
  String? lastName;
  String? emailId;
  String? altEmailId;
  String? mobileNo;
  String? altMobileNo;
  String? image;
  String? bankName;
  String? accountName;
  String? accountNo;
  String? ifscNo;
  String? bankAddress;
  dynamic serviceTypeId;
  dynamic letterTypeId;
  dynamic totalSubscriptionStudent;
  dynamic totalRemainStudent;
  String? totalWalletAmount;
  int? opdStatus;
  int? status;
  int? bothSendEmailStatus;
  int? firstTimeLoginStatus;
  String? companyName;
  String? companyAddress;
  int? countryId;
  int? stateId;
  int? cityId;
  String? postCode;
  String? address;
  String? gstNo;
  String? orCodeImage;
  int? applyForStandee;
  int? applyForSticker;
  int? applyForVisitingCard;
  dynamic linkedinLink;
  dynamic facebookLink;
  dynamic instagramLink;
  dynamic twitterLink;
  dynamic youtubeLink;
  dynamic websiteLink;
  dynamic businessRegistrationProof;
  String? createAt;
  String? updateAt;
  String? countryName;
  String? stateName;
  dynamic cityName;

  ProfileData({
    this.id,
    this.parentId,
    this.referralCode,
    this.firstName,
    this.middleName,
    this.lastName,
    this.emailId,
    this.altEmailId,
    this.mobileNo,
    this.altMobileNo,
    this.image,
    this.bankName,
    this.accountName,
    this.accountNo,
    this.ifscNo,
    this.bankAddress,
    this.serviceTypeId,
    this.letterTypeId,
    this.totalSubscriptionStudent,
    this.totalRemainStudent,
    this.totalWalletAmount,
    this.opdStatus,
    this.status,
    this.bothSendEmailStatus,
    this.firstTimeLoginStatus,
    this.companyName,
    this.companyAddress,
    this.countryId,
    this.stateId,
    this.cityId,
    this.postCode,
    this.address,
    this.gstNo,
    this.orCodeImage,
    this.applyForStandee,
    this.applyForSticker,
    this.applyForVisitingCard,
    this.linkedinLink,
    this.facebookLink,
    this.instagramLink,
    this.twitterLink,
    this.youtubeLink,
    this.websiteLink,
    this.businessRegistrationProof,
    this.createAt,
    this.updateAt,
    this.countryName,
    this.stateName,
    this.cityName,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
    id: json["id"],
    parentId: json["parent_id"],
    referralCode: json["referral_code"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    lastName: json["last_name"],
    emailId: json["email_id"],
    altEmailId: json["alt_email_id"],
    mobileNo: json["mobile_no"],
    altMobileNo: json["alt_mobile_no"],
    image: json["image"],
    bankName: json["bank_name"],
    accountName: json["account_name"],
    accountNo: json["account_no"],
    ifscNo: json["ifsc_no"],
    bankAddress: json["bank_address"],
    serviceTypeId: json["service_type_id"],
    letterTypeId: json["letter_type_id"],
    totalSubscriptionStudent: json["total_subscription_student"],
    totalRemainStudent: json["total_remain_student"],
    totalWalletAmount: json["total_wallet_amount"],
    opdStatus: json["opd_status"],
    status: json["status"],
    bothSendEmailStatus: json["both_send_email_status"],
    firstTimeLoginStatus: json["first_time_login_status"],
    companyName: json["company_name"],
    companyAddress: json["company_address"],
    countryId: json["country_id"],
    stateId: json["state_id"],
    cityId: json["city_id"],
    postCode: json["post_code"],
    address: json["address"],
    gstNo: json["gst_no"],
    orCodeImage: json["or_code_image"],
    applyForStandee: json["apply_for_standee"],
    applyForSticker: json["apply_for_sticker"],
    applyForVisitingCard: json["apply_for_visiting_card"],
    linkedinLink: json["linkedin_link"],
    facebookLink: json["facebook_link"],
    instagramLink: json["instagram_link"],
    twitterLink: json["twitter_link"],
    youtubeLink: json["youtube_link"],
    websiteLink: json["website_link"],
    businessRegistrationProof: json["business_registration_proof"],
    createAt: json["create_at"],
    updateAt: json["update_at"],
    countryName: json["country_name"],
    stateName: json["state_name"],
    cityName: json["city_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_id": parentId,
    "referral_code": referralCode,
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "email_id": emailId,
    "alt_email_id": altEmailId,
    "mobile_no": mobileNo,
    "alt_mobile_no": altMobileNo,
    "image": image,
    "bank_name": bankName,
    "account_name": accountName,
    "account_no": accountNo,
    "ifsc_no": ifscNo,
    "bank_address": bankAddress,
    "service_type_id": serviceTypeId,
    "letter_type_id": letterTypeId,
    "total_subscription_student": totalSubscriptionStudent,
    "total_remain_student": totalRemainStudent,
    "total_wallet_amount": totalWalletAmount,
    "opd_status": opdStatus,
    "status": status,
    "both_send_email_status": bothSendEmailStatus,
    "first_time_login_status": firstTimeLoginStatus,
    "company_name": companyName,
    "company_address": companyAddress,
    "country_id": countryId,
    "state_id": stateId,
    "city_id": cityId,
    "post_code": postCode,
    "address": address,
    "gst_no": gstNo,
    "or_code_image": orCodeImage,
    "apply_for_standee": applyForStandee,
    "apply_for_sticker": applyForSticker,
    "apply_for_visiting_card": applyForVisitingCard,
    "linkedin_link": linkedinLink,
    "facebook_link": facebookLink,
    "instagram_link": instagramLink,
    "twitter_link": twitterLink,
    "youtube_link": youtubeLink,
    "website_link": websiteLink,
    "business_registration_proof": businessRegistrationProof,
    "create_at": createAt,
    "update_at": updateAt,
    "country_name": countryName,
    "state_name": stateName,
    "city_name": cityName,
  };
}
