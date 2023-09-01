class ProfileModel {
  int? status;
  String? message;
  ProfileData? data;

  ProfileModel({this.status, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new ProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
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

  ProfileData(
      {this.id,
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
        this.updateAt});

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    referralCode = json['referral_code'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    emailId = json['email_id'];
    altEmailId = json['alt_email_id'];
    mobileNo = json['mobile_no'];
    altMobileNo = json['alt_mobile_no'];
    image = json['image'];
    bankName = json['bank_name'];
    accountName = json['account_name'];
    accountNo = json['account_no'];
    ifscNo = json['ifsc_no'];
    bankAddress = json['bank_address'];
    serviceTypeId = json['service_type_id'];
    letterTypeId = json['letter_type_id'];
    totalSubscriptionStudent = json['total_subscription_student'];
    totalRemainStudent = json['total_remain_student'];
    totalWalletAmount = json['total_wallet_amount'];
    opdStatus = json['opd_status'];
    status = json['status'];
    bothSendEmailStatus = json['both_send_email_status'];
    firstTimeLoginStatus = json['first_time_login_status'];
    companyName = json['company_name'];
    companyAddress = json['company_address'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    postCode = json['post_code'];
    address = json['address'];
    gstNo = json['gst_no'];
    orCodeImage = json['or_code_image'];
    applyForStandee = json['apply_for_standee'];
    applyForSticker = json['apply_for_sticker'];
    applyForVisitingCard = json['apply_for_visiting_card'];
    linkedinLink = json['linkedin_link'];
    facebookLink = json['facebook_link'];
    instagramLink = json['instagram_link'];
    twitterLink = json['twitter_link'];
    youtubeLink = json['youtube_link'];
    websiteLink = json['website_link'];
    businessRegistrationProof = json['business_registration_proof'];
    createAt = json['create_at'];
    updateAt = json['update_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['referral_code'] = this.referralCode;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['email_id'] = this.emailId;
    data['alt_email_id'] = this.altEmailId;
    data['mobile_no'] = this.mobileNo;
    data['alt_mobile_no'] = this.altMobileNo;
    data['image'] = this.image;
    data['bank_name'] = this.bankName;
    data['account_name'] = this.accountName;
    data['account_no'] = this.accountNo;
    data['ifsc_no'] = this.ifscNo;
    data['bank_address'] = this.bankAddress;
    data['service_type_id'] = this.serviceTypeId;
    data['letter_type_id'] = this.letterTypeId;
    data['total_subscription_student'] = this.totalSubscriptionStudent;
    data['total_remain_student'] = this.totalRemainStudent;
    data['total_wallet_amount'] = this.totalWalletAmount;
    data['opd_status'] = this.opdStatus;
    data['status'] = this.status;
    data['both_send_email_status'] = this.bothSendEmailStatus;
    data['first_time_login_status'] = this.firstTimeLoginStatus;
    data['company_name'] = this.companyName;
    data['company_address'] = this.companyAddress;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['post_code'] = this.postCode;
    data['address'] = this.address;
    data['gst_no'] = this.gstNo;
    data['or_code_image'] = this.orCodeImage;
    data['apply_for_standee'] = this.applyForStandee;
    data['apply_for_sticker'] = this.applyForSticker;
    data['apply_for_visiting_card'] = this.applyForVisitingCard;
    data['linkedin_link'] = this.linkedinLink;
    data['facebook_link'] = this.facebookLink;
    data['instagram_link'] = this.instagramLink;
    data['twitter_link'] = this.twitterLink;
    data['youtube_link'] = this.youtubeLink;
    data['website_link'] = this.websiteLink;
    data['business_registration_proof'] = this.businessRegistrationProof;
    data['create_at'] = this.createAt;
    data['update_at'] = this.updateAt;
    return data;
  }
}