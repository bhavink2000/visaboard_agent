class OrderVisaFileEditM {
  int? status;
  OVFEditData? data;
  List<Tabs>? tabs;

  OrderVisaFileEditM({this.status, this.data, this.tabs});

  OrderVisaFileEditM.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? OVFEditData.fromJson(json['data']) : null;
    if (json['tabs'] != null) {
      tabs = <Tabs>[];
      json['tabs'].forEach((v) {
        tabs!.add(Tabs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (tabs != null) {
      data['tabs'] = tabs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OVFEditData {
  int? id;
  int? userSopId;
  String? message;
  User? user;
  List<dynamic>? userForeignInstituteDetails;
  List<dynamic>? userChildDetails;
  List<dynamic>? userSofs;
  List<dynamic>? userRefusedVisas;
  List<dynamic>? userTravelledHistories;
  List<dynamic>? userFamilyDetails;
  List<Countries>? countries;
  List<Type>? educationTypes;
  List<Type>? testTypes;
  List<dynamic>? currentStates;
  List<dynamic>? currentCities;
  List<dynamic>? communicationStates;
  List<dynamic>? communicationCities;
  List<dynamic>? userExperiences;
  List<dynamic>? userEducations;
  List<dynamic>? userTestScores;
  List<dynamic>? userSpouseExperiences;
  List<dynamic>? userSpousePreviousEducations;
  UserSops? userSops;
  String? encUserId;
  String? encUserSopId;

  OVFEditData(
      {this.id,
        this.userSopId,
        this.message,
        this.user,
        this.userForeignInstituteDetails,
        this.userChildDetails,
        this.userSofs,
        this.userRefusedVisas,
        this.userTravelledHistories,
        this.userFamilyDetails,
        this.countries,
        this.educationTypes,
        this.testTypes,
        this.currentStates,
        this.currentCities,
        this.communicationStates,
        this.communicationCities,
        this.userExperiences,
        this.userEducations,
        this.userTestScores,
        this.userSpouseExperiences,
        this.userSpousePreviousEducations,
        this.userSops,
        this.encUserId,
        this.encUserSopId});

  factory OVFEditData.fromJson(Map<String, dynamic> json) => OVFEditData(
    id: json["id"],
    userSopId: json["user_sop_id"],
    message: json["message"],
    user: User.fromJson(json["user"]),
    userForeignInstituteDetails: List<dynamic>.from(json["user_foreign_institute_details"].map((x) => x)),
    userChildDetails: List<dynamic>.from(json["user_child_details"].map((x) => x)),
    userSofs: List<dynamic>.from(json["user_sofs"].map((x) => x)),
    userRefusedVisas: List<dynamic>.from(json["user_refused_visas"].map((x) => x)),
    userTravelledHistories: List<dynamic>.from(json["user_travelled_histories"].map((x) => x)),
    userFamilyDetails: List<dynamic>.from(json["user_family_details"].map((x) => x)),
    countries: List<Countries>.from(json["countries"].map((x) => Countries.fromJson(x))),
    educationTypes: List<Type>.from(json["education_types"].map((x) => Type.fromJson(x))),
    testTypes: List<Type>.from(json["test_types"].map((x) => Type.fromJson(x))),
    currentStates: List<dynamic>.from(json["current_states"].map((x) => x)),
    currentCities: List<dynamic>.from(json["current_cities"].map((x) => x)),
    communicationStates: List<dynamic>.from(json["communication_states"].map((x) => x)),
    communicationCities: List<dynamic>.from(json["communication_cities"].map((x) => x)),
    userExperiences: List<dynamic>.from(json["user_experiences"].map((x) => x)),
    userEducations: List<dynamic>.from(json["user_educations"].map((x) => x)),
    userTestScores: List<dynamic>.from(json["user_test_scores"].map((x) => x)),
    userSpouseExperiences: List<dynamic>.from(json["user_spouse_experiences"].map((x) => x)),
    userSpousePreviousEducations: List<dynamic>.from(json["user_spouse_previous_educations"].map((x) => x)),
    userSops: UserSops.fromJson(json["user_sops"]),
    encUserId: json["enc_user_id"],
    encUserSopId: json["enc_user_sop_id"],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['user_sop_id'] = userSopId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (userForeignInstituteDetails != null) {
      data['user_foreign_institute_details'] =
          userForeignInstituteDetails!.map((v) => v.toJson()).toList();
    }
    if (userChildDetails != null) {
      data['user_child_details'] =
          userChildDetails!.map((v) => v.toJson()).toList();
    }
    if (userSofs != null) {
      data['user_sofs'] = userSofs!.map((v) => v.toJson()).toList();
    }
    if (userRefusedVisas != null) {
      data['user_refused_visas'] =
          userRefusedVisas!.map((v) => v.toJson()).toList();
    }
    if (userTravelledHistories != null) {
      data['user_travelled_histories'] =
          userTravelledHistories!.map((v) => v.toJson()).toList();
    }
    if (userFamilyDetails != null) {
      data['user_family_details'] =
          userFamilyDetails!.map((v) => v.toJson()).toList();
    }
    if (countries != null) {
      data['countries'] = countries!.map((v) => v.toJson()).toList();
    }
    if (educationTypes != null) {
      data['education_types'] =
          educationTypes!.map((v) => v.toJson()).toList();
    }
    if (testTypes != null) {
      data['test_types'] = testTypes!.map((v) => v.toJson()).toList();
    }
    if (currentStates != null) {
      data['current_states'] =
          currentStates!.map((v) => v.toJson()).toList();
    }
    if (currentCities != null) {
      data['current_cities'] =
          currentCities!.map((v) => v.toJson()).toList();
    }
    if (communicationStates != null) {
      data['communication_states'] =
          communicationStates!.map((v) => v.toJson()).toList();
    }
    if (communicationCities != null) {
      data['communication_cities'] =
          communicationCities!.map((v) => v.toJson()).toList();
    }
    if (userExperiences != null) {
      data['user_experiences'] =
          userExperiences!.map((v) => v.toJson()).toList();
    }
    if (userEducations != null) {
      data['user_educations'] =
          userEducations!.map((v) => v.toJson()).toList();
    }
    if (userTestScores != null) {
      data['user_test_scores'] =
          userTestScores!.map((v) => v.toJson()).toList();
    }
    if (userSpouseExperiences != null) {
      data['user_spouse_experiences'] =
          userSpouseExperiences!.map((v) => v.toJson()).toList();
    }
    if (userSpousePreviousEducations != null) {
      data['user_spouse_previous_educations'] =
          userSpousePreviousEducations!.map((v) => v.toJson()).toList();
    }
    if (userSops != null) {
      data['user_sops'] = userSops!.toJson();
    }
    data['enc_user_id'] = encUserId;
    data['enc_user_sop_id'] = encUserSopId;
    return data;
  }
}

class User {
  int? id;
  int? agentId;
  int? adminId;
  String? firstName;
  String? lastName;
  int? otherNameStatus;
  dynamic otherName;
  int? changedNameStatus;
  dynamic changedName;
  dynamic dob;
  dynamic passportNo;
  dynamic passportExpDate;
  dynamic firstLanguage;
  int? citizenCountryId;
  int? gender;
  String? emailId;
  String? mobileNo;
  dynamic phoneNo;
  dynamic parentEmailId;
  dynamic currentAddress;
  int? currentCountryId;
  int? currentStateId;
  int? currentCityId;
  dynamic currentZipCode;
  int? sameAsCurrentAddress;
  dynamic communicationAddress;
  int? communicationCountryId;
  int? communicationStateId;
  int? communicationCityId;
  dynamic communicationZipCode;
  dynamic sponsorFullName;
  dynamic sponsorRelation;
  int? sponsorAnnualIncome;
  dynamic sponsorAvailableBal;
  dynamic sponsorOccupation;
  dynamic sponsorOrganizationName;
  int? sponsorAffidavitStatus;
  int? maritalStatus;
  dynamic spouseFullName;
  dynamic dateOfMarriage;
  dynamic placeOfMarriage;
  dynamic dateOfBetrothal;
  dynamic spouseFamilyName;
  dynamic spouseDob;
  dynamic spouseEducation;
  dynamic marriageRegNo;
  dynamic divorceRegNo;
  int? haveChildStatus;
  dynamic jewelleryValuation;
  dynamic homeValuation;
  dynamic cAReport;
  dynamic jobPhoneNo;
  dynamic jobEmailId;
  int? agentReadStatus;
  int? adminReadStatus;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? studyLoanStatus;
  dynamic loanBankName;
  String? loanAmount;
  dynamic loanGuarantor;
  int? countryVisaAppliedStatus;
  int? visaAppliedCountryId;
  int? visaAppliedApplication;
  int? deniedCountryEntryStatus;
  dynamic deniedCountryEntryNote;
  int? appliedVisaCancelledStatus;
  dynamic appliedVisaCancelledNote;
  int? policeVerifyCertificateStatus;
  int? pendingCriminalStatus;
  int? convictedCriminalStatus;
  dynamic criminalRecordText;
  int? medicalConditionStatus;
  dynamic medicalConditionNote;
  int? travelledHistoryStatus;
  int? countryVisaRefusedStatus;
  dynamic spouseLivingAddress;
  dynamic spouseVisaGrantNo;
  dynamic spouseVisaValidityDate;
  dynamic spouseInstitute;
  dynamic spouseCourse;
  int? spouseChangedCourseStatus;
  dynamic spouseDepartForeignStudy;
  int? spouseWorkStatus;
  dynamic spouseWorkPlace;
  dynamic spouseWorkPlaceAddress;
  dynamic spouseDesignation;
  dynamic spouseFromDate;
  dynamic spouseToDate;
  String? spouseIncome;
  dynamic spousePassportNo;
  int? spouseOccupation;
  dynamic spouseOrganizationAddress;
  int? haveOtherDependentsStatus;
  dynamic spouseStartDate;
  dynamic spouseEndDate;
  String? spouseAnnualIncome;
  dynamic stayDuration;
  dynamic inviterRelated;
  int? inviterResidentStatus;
  dynamic inviterFamilySizeUnit;
  dynamic inviterOccupation;
  int? invitationLetterStatus;
  int? immigrationHistoryFlag;
  dynamic propertyValuation;
  dynamic propertyAddress;
  dynamic maxGrossAmount;
  dynamic apostilleCountryId;
  dynamic translationCountryId;
  String? telegraphicTransferAmount;
  int? telegraphicTransferCurrencyId;
  String? middleName;
  dynamic soprfDesignation;
  dynamic soprfNoCandidate;
  dynamic soprfSalary;
  dynamic soprfPlaceInterview;
  dynamic soprfInterviewTime;
  dynamic soprfDutiesResponsibilities;
  dynamic soprfNote;

  User(
      {this.id,
        this.agentId,
        this.adminId,
        this.firstName,
        this.lastName,
        this.otherNameStatus,
        this.otherName,
        this.changedNameStatus,
        this.changedName,
        this.dob,
        this.passportNo,
        this.passportExpDate,
        this.firstLanguage,
        this.citizenCountryId,
        this.gender,
        this.emailId,
        this.mobileNo,
        this.phoneNo,
        this.parentEmailId,
        this.currentAddress,
        this.currentCountryId,
        this.currentStateId,
        this.currentCityId,
        this.currentZipCode,
        this.sameAsCurrentAddress,
        this.communicationAddress,
        this.communicationCountryId,
        this.communicationStateId,
        this.communicationCityId,
        this.communicationZipCode,
        this.sponsorFullName,
        this.sponsorRelation,
        this.sponsorAnnualIncome,
        this.sponsorAvailableBal,
        this.sponsorOccupation,
        this.sponsorOrganizationName,
        this.sponsorAffidavitStatus,
        this.maritalStatus,
        this.spouseFullName,
        this.dateOfMarriage,
        this.placeOfMarriage,
        this.dateOfBetrothal,
        this.spouseFamilyName,
        this.spouseDob,
        this.spouseEducation,
        this.marriageRegNo,
        this.divorceRegNo,
        this.haveChildStatus,
        this.jewelleryValuation,
        this.homeValuation,
        this.cAReport,
        this.jobPhoneNo,
        this.jobEmailId,
        this.agentReadStatus,
        this.adminReadStatus,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.studyLoanStatus,
        this.loanBankName,
        this.loanAmount,
        this.loanGuarantor,
        this.countryVisaAppliedStatus,
        this.visaAppliedCountryId,
        this.visaAppliedApplication,
        this.deniedCountryEntryStatus,
        this.deniedCountryEntryNote,
        this.appliedVisaCancelledStatus,
        this.appliedVisaCancelledNote,
        this.policeVerifyCertificateStatus,
        this.pendingCriminalStatus,
        this.convictedCriminalStatus,
        this.criminalRecordText,
        this.medicalConditionStatus,
        this.medicalConditionNote,
        this.travelledHistoryStatus,
        this.countryVisaRefusedStatus,
        this.spouseLivingAddress,
        this.spouseVisaGrantNo,
        this.spouseVisaValidityDate,
        this.spouseInstitute,
        this.spouseCourse,
        this.spouseChangedCourseStatus,
        this.spouseDepartForeignStudy,
        this.spouseWorkStatus,
        this.spouseWorkPlace,
        this.spouseWorkPlaceAddress,
        this.spouseDesignation,
        this.spouseFromDate,
        this.spouseToDate,
        this.spouseIncome,
        this.spousePassportNo,
        this.spouseOccupation,
        this.spouseOrganizationAddress,
        this.haveOtherDependentsStatus,
        this.spouseStartDate,
        this.spouseEndDate,
        this.spouseAnnualIncome,
        this.stayDuration,
        this.inviterRelated,
        this.inviterResidentStatus,
        this.inviterFamilySizeUnit,
        this.inviterOccupation,
        this.invitationLetterStatus,
        this.immigrationHistoryFlag,
        this.propertyValuation,
        this.propertyAddress,
        this.maxGrossAmount,
        this.apostilleCountryId,
        this.translationCountryId,
        this.telegraphicTransferAmount,
        this.telegraphicTransferCurrencyId,
        this.middleName,
        this.soprfDesignation,
        this.soprfNoCandidate,
        this.soprfSalary,
        this.soprfPlaceInterview,
        this.soprfInterviewTime,
        this.soprfDutiesResponsibilities,
        this.soprfNote});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    agentId = json['agent_id'];
    adminId = json['admin_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    otherNameStatus = json['other_name_status'];
    otherName = json['other_name'];
    changedNameStatus = json['changed_name_status'];
    changedName = json['changed_name'];
    dob = json['dob'];
    passportNo = json['passport_no'];
    passportExpDate = json['passport_exp_date'];
    firstLanguage = json['first_language'];
    citizenCountryId = json['citizen_country_id'];
    gender = json['gender'];
    emailId = json['email_id'];
    mobileNo = json['mobile_no'];
    phoneNo = json['phone_no'];
    parentEmailId = json['parent_email_id'];
    currentAddress = json['current_address'];
    currentCountryId = json['current_country_id'];
    currentStateId = json['current_state_id'];
    currentCityId = json['current_city_id'];
    currentZipCode = json['current_zip_code'];
    sameAsCurrentAddress = json['same_as_current_address'];
    communicationAddress = json['communication_address'];
    communicationCountryId = json['communication_country_id'];
    communicationStateId = json['communication_state_id'];
    communicationCityId = json['communication_city_id'];
    communicationZipCode = json['communication_zip_code'];
    sponsorFullName = json['sponsor_full_name'];
    sponsorRelation = json['sponsor_relation'];
    sponsorAnnualIncome = json['sponsor_annual_income'];
    sponsorAvailableBal = json['sponsor_available_bal'];
    sponsorOccupation = json['sponsor_occupation'];
    sponsorOrganizationName = json['sponsor_organization_name'];
    sponsorAffidavitStatus = json['sponsor_affidavit_status'];
    maritalStatus = json['marital_status'];
    spouseFullName = json['spouse_full_name'];
    dateOfMarriage = json['date_of_marriage'];
    placeOfMarriage = json['place_of_marriage'];
    dateOfBetrothal = json['date_of_betrothal'];
    spouseFamilyName = json['spouse_family_name'];
    spouseDob = json['spouse_dob'];
    spouseEducation = json['spouse_education'];
    marriageRegNo = json['marriage_reg_no'];
    divorceRegNo = json['divorce_reg_no'];
    haveChildStatus = json['have_child_status'];
    jewelleryValuation = json['jewellery_valuation'];
    homeValuation = json['home_valuation'];
    cAReport = json['c_a_report'];
    jobPhoneNo = json['job_phone_no'];
    jobEmailId = json['job_email_id'];
    agentReadStatus = json['agent_read_status'];
    adminReadStatus = json['admin_read_status'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    studyLoanStatus = json['study_loan_status'];
    loanBankName = json['loan_bank_name'];
    loanAmount = json['loan_amount'];
    loanGuarantor = json['loan_guarantor'];
    countryVisaAppliedStatus = json['country_visa_applied_status'];
    visaAppliedCountryId = json['visa_applied_country_id'];
    visaAppliedApplication = json['visa_applied_application'];
    deniedCountryEntryStatus = json['denied_country_entry_status'];
    deniedCountryEntryNote = json['denied_country_entry_note'];
    appliedVisaCancelledStatus = json['applied_visa_cancelled_status'];
    appliedVisaCancelledNote = json['applied_visa_cancelled_note'];
    policeVerifyCertificateStatus = json['police_verify_certificate_status'];
    pendingCriminalStatus = json['pending_criminal_status'];
    convictedCriminalStatus = json['convicted_criminal_status'];
    criminalRecordText = json['criminal_record_text'];
    medicalConditionStatus = json['medical_condition_status'];
    medicalConditionNote = json['medical_condition_note'];
    travelledHistoryStatus = json['travelled_history_status'];
    countryVisaRefusedStatus = json['country_visa_refused_status'];
    spouseLivingAddress = json['spouse_living_address'];
    spouseVisaGrantNo = json['spouse_visa_grant_no'];
    spouseVisaValidityDate = json['spouse_visa_validity_date'];
    spouseInstitute = json['spouse_institute'];
    spouseCourse = json['spouse_course'];
    spouseChangedCourseStatus = json['spouse_changed_course_status'];
    spouseDepartForeignStudy = json['spouse_depart_foreign_study'];
    spouseWorkStatus = json['spouse_work_status'];
    spouseWorkPlace = json['spouse_work_place'];
    spouseWorkPlaceAddress = json['spouse_work_place_address'];
    spouseDesignation = json['spouse_designation'];
    spouseFromDate = json['spouse_from_date'];
    spouseToDate = json['spouse_to_date'];
    spouseIncome = json['spouse_income'];
    spousePassportNo = json['spouse_passport_no'];
    spouseOccupation = json['spouse_occupation'];
    spouseOrganizationAddress = json['spouse_organization_address'];
    haveOtherDependentsStatus = json['have_other_dependents_status'];
    spouseStartDate = json['spouse_start_date'];
    spouseEndDate = json['spouse_end_date'];
    spouseAnnualIncome = json['spouse_annual_income'];
    stayDuration = json['stay_duration'];
    inviterRelated = json['inviter_related'];
    inviterResidentStatus = json['inviter_resident_status'];
    inviterFamilySizeUnit = json['inviter_family_size_unit'];
    inviterOccupation = json['inviter_occupation'];
    invitationLetterStatus = json['invitation_letter_status'];
    immigrationHistoryFlag = json['immigration_history_flag'];
    propertyValuation = json['property_valuation'];
    propertyAddress = json['property_address'];
    maxGrossAmount = json['max_gross_amount'];
    apostilleCountryId = json['apostille_country_id'];
    translationCountryId = json['translation_country_id'];
    telegraphicTransferAmount = json['telegraphic_transfer_amount'];
    telegraphicTransferCurrencyId = json['telegraphic_transfer_currency_id'];
    middleName = json['middle_name'];
    soprfDesignation = json['soprf_designation'];
    soprfNoCandidate = json['soprf_no_candidate'];
    soprfSalary = json['soprf_salary'];
    soprfPlaceInterview = json['soprf_place_interview'];
    soprfInterviewTime = json['soprf_interview_time'];
    soprfDutiesResponsibilities = json['soprf_duties_responsibilities'];
    soprfNote = json['soprf_note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['agent_id'] = agentId;
    data['admin_id'] = adminId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['other_name_status'] = otherNameStatus;
    data['other_name'] = otherName;
    data['changed_name_status'] = changedNameStatus;
    data['changed_name'] = changedName;
    data['dob'] = dob;
    data['passport_no'] = passportNo;
    data['passport_exp_date'] = passportExpDate;
    data['first_language'] = firstLanguage;
    data['citizen_country_id'] = citizenCountryId;
    data['gender'] = gender;
    data['email_id'] = emailId;
    data['mobile_no'] = mobileNo;
    data['phone_no'] = phoneNo;
    data['parent_email_id'] = parentEmailId;
    data['current_address'] = currentAddress;
    data['current_country_id'] = currentCountryId;
    data['current_state_id'] = currentStateId;
    data['current_city_id'] = currentCityId;
    data['current_zip_code'] = currentZipCode;
    data['same_as_current_address'] = sameAsCurrentAddress;
    data['communication_address'] = communicationAddress;
    data['communication_country_id'] = communicationCountryId;
    data['communication_state_id'] = communicationStateId;
    data['communication_city_id'] = communicationCityId;
    data['communication_zip_code'] = communicationZipCode;
    data['sponsor_full_name'] = sponsorFullName;
    data['sponsor_relation'] = sponsorRelation;
    data['sponsor_annual_income'] = sponsorAnnualIncome;
    data['sponsor_available_bal'] = sponsorAvailableBal;
    data['sponsor_occupation'] = sponsorOccupation;
    data['sponsor_organization_name'] = sponsorOrganizationName;
    data['sponsor_affidavit_status'] = sponsorAffidavitStatus;
    data['marital_status'] = maritalStatus;
    data['spouse_full_name'] = spouseFullName;
    data['date_of_marriage'] = dateOfMarriage;
    data['place_of_marriage'] = placeOfMarriage;
    data['date_of_betrothal'] = dateOfBetrothal;
    data['spouse_family_name'] = spouseFamilyName;
    data['spouse_dob'] = spouseDob;
    data['spouse_education'] = spouseEducation;
    data['marriage_reg_no'] = marriageRegNo;
    data['divorce_reg_no'] = divorceRegNo;
    data['have_child_status'] = haveChildStatus;
    data['jewellery_valuation'] = jewelleryValuation;
    data['home_valuation'] = homeValuation;
    data['c_a_report'] = cAReport;
    data['job_phone_no'] = jobPhoneNo;
    data['job_email_id'] = jobEmailId;
    data['agent_read_status'] = agentReadStatus;
    data['admin_read_status'] = adminReadStatus;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['study_loan_status'] = studyLoanStatus;
    data['loan_bank_name'] = loanBankName;
    data['loan_amount'] = loanAmount;
    data['loan_guarantor'] = loanGuarantor;
    data['country_visa_applied_status'] = countryVisaAppliedStatus;
    data['visa_applied_country_id'] = visaAppliedCountryId;
    data['visa_applied_application'] = visaAppliedApplication;
    data['denied_country_entry_status'] = deniedCountryEntryStatus;
    data['denied_country_entry_note'] = deniedCountryEntryNote;
    data['applied_visa_cancelled_status'] = appliedVisaCancelledStatus;
    data['applied_visa_cancelled_note'] = appliedVisaCancelledNote;
    data['police_verify_certificate_status'] =
        policeVerifyCertificateStatus;
    data['pending_criminal_status'] = pendingCriminalStatus;
    data['convicted_criminal_status'] = convictedCriminalStatus;
    data['criminal_record_text'] = criminalRecordText;
    data['medical_condition_status'] = medicalConditionStatus;
    data['medical_condition_note'] = medicalConditionNote;
    data['travelled_history_status'] = travelledHistoryStatus;
    data['country_visa_refused_status'] = countryVisaRefusedStatus;
    data['spouse_living_address'] = spouseLivingAddress;
    data['spouse_visa_grant_no'] = spouseVisaGrantNo;
    data['spouse_visa_validity_date'] = spouseVisaValidityDate;
    data['spouse_institute'] = spouseInstitute;
    data['spouse_course'] = spouseCourse;
    data['spouse_changed_course_status'] = spouseChangedCourseStatus;
    data['spouse_depart_foreign_study'] = spouseDepartForeignStudy;
    data['spouse_work_status'] = spouseWorkStatus;
    data['spouse_work_place'] = spouseWorkPlace;
    data['spouse_work_place_address'] = spouseWorkPlaceAddress;
    data['spouse_designation'] = spouseDesignation;
    data['spouse_from_date'] = spouseFromDate;
    data['spouse_to_date'] = spouseToDate;
    data['spouse_income'] = spouseIncome;
    data['spouse_passport_no'] = spousePassportNo;
    data['spouse_occupation'] = spouseOccupation;
    data['spouse_organization_address'] = spouseOrganizationAddress;
    data['have_other_dependents_status'] = haveOtherDependentsStatus;
    data['spouse_start_date'] = spouseStartDate;
    data['spouse_end_date'] = spouseEndDate;
    data['spouse_annual_income'] = spouseAnnualIncome;
    data['stay_duration'] = stayDuration;
    data['inviter_related'] = inviterRelated;
    data['inviter_resident_status'] = inviterResidentStatus;
    data['inviter_family_size_unit'] = inviterFamilySizeUnit;
    data['inviter_occupation'] = inviterOccupation;
    data['invitation_letter_status'] = invitationLetterStatus;
    data['immigration_history_flag'] = immigrationHistoryFlag;
    data['property_valuation'] = propertyValuation;
    data['property_address'] = propertyAddress;
    data['max_gross_amount'] = maxGrossAmount;
    data['apostille_country_id'] = apostilleCountryId;
    data['translation_country_id'] = translationCountryId;
    data['telegraphic_transfer_amount'] = telegraphicTransferAmount;
    data['telegraphic_transfer_currency_id'] =
        telegraphicTransferCurrencyId;
    data['middle_name'] = middleName;
    data['soprf_designation'] = soprfDesignation;
    data['soprf_no_candidate'] = soprfNoCandidate;
    data['soprf_salary'] = soprfSalary;
    data['soprf_place_interview'] = soprfPlaceInterview;
    data['soprf_interview_time'] = soprfInterviewTime;
    data['soprf_duties_responsibilities'] = soprfDutiesResponsibilities;
    data['soprf_note'] = soprfNote;
    return data;
  }
}

class Countries {
  int? id;
  String? name;
  int? dialCode;

  Countries({this.id, this.name, this.dialCode});

  Countries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dialCode = json['dial_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['dial_code'] = dialCode;
    return data;
  }
}

class Type {
  int? id;
  String? name;

  Type({this.id, this.name});

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class UserSops {
  int? id;
  String? razorpayPaymentId;
  dynamic stripePaymentId;
  int? userId;
  int? agentId;
  int? adminId;
  int? serviceTypeId;
  int? letterTypeId;
  int? countryId;
  dynamic description;
  int? orderQty;
  String? netPrice;
  String? orderPrice;
  dynamic cgst;
  dynamic sgst;
  String? igst;
  String? gstOrderPrice;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? holdOfferLetterStatus;
  int? refundStatus;
  String? refundPrice;
  dynamic refundDate;
  int? cancelStatus;
  String? cancelPrice;
  dynamic cancelDate;
  int? adminUnreadCount;
  int? agentUnreadCount;
  String? paymentDate;
  int? walletPaymentStatus;
  String? walletOrderPrice;
  String? paytmOrderPrice;
  int? paytmTransactionStatus;
  dynamic completeAt;
  String? invoicePdf;
  dynamic paymentOnByMethod;
  String? invoiceId;
  String? invoiceNumber;
  String? invoiceYear;

  UserSops(
      {this.id,
        this.razorpayPaymentId,
        this.stripePaymentId,
        this.userId,
        this.agentId,
        this.adminId,
        this.serviceTypeId,
        this.letterTypeId,
        this.countryId,
        this.description,
        this.orderQty,
        this.netPrice,
        this.orderPrice,
        this.cgst,
        this.sgst,
        this.igst,
        this.gstOrderPrice,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.holdOfferLetterStatus,
        this.refundStatus,
        this.refundPrice,
        this.refundDate,
        this.cancelStatus,
        this.cancelPrice,
        this.cancelDate,
        this.adminUnreadCount,
        this.agentUnreadCount,
        this.paymentDate,
        this.walletPaymentStatus,
        this.walletOrderPrice,
        this.paytmOrderPrice,
        this.paytmTransactionStatus,
        this.completeAt,
        this.invoicePdf,
        this.paymentOnByMethod,
        this.invoiceId,
        this.invoiceNumber,
        this.invoiceYear});

  UserSops.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    razorpayPaymentId = json['razorpay_payment_id'];
    stripePaymentId = json['stripe_payment_id'];
    userId = json['user_id'];
    agentId = json['agent_id'];
    adminId = json['admin_id'];
    serviceTypeId = json['service_type_id'];
    letterTypeId = json['letter_type_id'];
    countryId = json['country_id'];
    description = json['description'];
    orderQty = json['order_qty'];
    netPrice = json['net_price'];
    orderPrice = json['order_price'];
    cgst = json['cgst'];
    sgst = json['sgst'];
    igst = json['igst'];
    gstOrderPrice = json['gst_order_price'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    holdOfferLetterStatus = json['hold_offer_letter_status'];
    refundStatus = json['refund_status'];
    refundPrice = json['refund_price'];
    refundDate = json['refund_date'];
    cancelStatus = json['cancel_status'];
    cancelPrice = json['cancel_price'];
    cancelDate = json['cancel_date'];
    adminUnreadCount = json['admin_unread_count'];
    agentUnreadCount = json['agent_unread_count'];
    paymentDate = json['payment_date'];
    walletPaymentStatus = json['wallet_payment_status'];
    walletOrderPrice = json['wallet_order_price'];
    paytmOrderPrice = json['paytm_order_price'];
    paytmTransactionStatus = json['paytm_transaction_status'];
    completeAt = json['complete_at'];
    invoicePdf = json['invoice_pdf'];
    paymentOnByMethod = json['payment_on_by_method'];
    invoiceId = json['invoice_id'];
    invoiceNumber = json['invoice_number'];
    invoiceYear = json['invoice_year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['razorpay_payment_id'] = razorpayPaymentId;
    data['stripe_payment_id'] = stripePaymentId;
    data['user_id'] = userId;
    data['agent_id'] = agentId;
    data['admin_id'] = adminId;
    data['service_type_id'] = serviceTypeId;
    data['letter_type_id'] = letterTypeId;
    data['country_id'] = countryId;
    data['description'] = description;
    data['order_qty'] = orderQty;
    data['net_price'] = netPrice;
    data['order_price'] = orderPrice;
    data['cgst'] = cgst;
    data['sgst'] = sgst;
    data['igst'] = igst;
    data['gst_order_price'] = gstOrderPrice;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['hold_offer_letter_status'] = holdOfferLetterStatus;
    data['refund_status'] = refundStatus;
    data['refund_price'] = refundPrice;
    data['refund_date'] = refundDate;
    data['cancel_status'] = cancelStatus;
    data['cancel_price'] = cancelPrice;
    data['cancel_date'] = cancelDate;
    data['admin_unread_count'] = adminUnreadCount;
    data['agent_unread_count'] = agentUnreadCount;
    data['payment_date'] = paymentDate;
    data['wallet_payment_status'] = walletPaymentStatus;
    data['wallet_order_price'] = walletOrderPrice;
    data['paytm_order_price'] = paytmOrderPrice;
    data['paytm_transaction_status'] = paytmTransactionStatus;
    data['complete_at'] = completeAt;
    data['invoice_pdf'] = invoicePdf;
    data['payment_on_by_method'] = paymentOnByMethod;
    data['invoice_id'] = invoiceId;
    data['invoice_number'] = invoiceNumber;
    data['invoice_year'] = invoiceYear;
    return data;
  }
}

class Tabs {
  String? tab;
  int? status;

  Tabs({this.tab, this.status});

  Tabs.fromJson(Map<String, dynamic> json) {
    tab = json['tab'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['tab'] = tab;
    data['status'] = status;
    return data;
  }
}