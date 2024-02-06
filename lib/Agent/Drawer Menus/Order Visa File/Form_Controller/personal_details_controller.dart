// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../App Helper/Api Repository/api_urls.dart';
import '../../../App Helper/Ui Helper/snackbar_msg_show.dart';

class PersonalDController extends GetxController{

  var pageController;
  BuildContext? context;
  PersonalDController({this.pageController,this.context});


  final personalDetailsFormKey = GlobalKey<FormState>();

  final piFName = TextEditingController();
  final piMName = TextEditingController();
  final piLName = TextEditingController();

  RxString otherName = "".obs;
  RxBool otherNm = false.obs;
  final piOtherName = TextEditingController();

  RxString changeName = "".obs;
  RxBool changeNm = false.obs;
  File? changeNmFile;

  final piBirthDate = TextEditingController();
  final piPassportNo = TextEditingController();
  final piPassportExpiryDate = TextEditingController();
  final piFirstLanguage = TextEditingController();

  RxString piCountryOfCitizenShip = ''.obs;
  var selectedCountry;
  List<String> piCountryCitizenShip = ['India', 'Other Country'];

  RxString piGender = "".obs;
  RxString piMaritalStatus = "".obs;
  RxString piMedicalCondition = "".obs;
  final piSpecifyMedical = TextEditingController();

  final piEmail = TextEditingController();
  final piMobile = TextEditingController();
  final piParentEmail = TextEditingController();
  final piParentMobile = TextEditingController();


  final piPaAddress = TextEditingController();
  var piPaCountry;
  RxString piPaState = ''.obs;
  RxString piPaCity = ''.obs;
  final piPaPostCode = TextEditingController();

  RxBool piCdCheckBox = false.obs;

  final piCaAddress = TextEditingController();
  var piCaCountry;
  RxString piCaState = ''.obs;
  RxString piCaCity = ''.obs;
  final piCAPostCode = TextEditingController();



  List<Map<String, dynamic>>? cStatesList;
  List<Map<String, dynamic>>? pStatesList;
  Future<void> getCurrentStates(String? accessToken, var userId, var userSopId) async {
    final response = await http.post(
      Uri.parse(ApiConstants.getOVFEdit),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: {
        'user_id':userId,
        'user_sop_id': userSopId,
      },
    );
    log('state response->${response.statusCode}');
    log('state response->${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
        pStatesList = (data['data']['current_states'] as List<dynamic>?)?.cast<Map<String, dynamic>>();
        cStatesList = pStatesList ?? [];
      log("States p List -> $pStatesList");
      log("States c List -> $cStatesList");
    } else {

    }
  }

  List? cCitiesList;
  List? pCitiesList;
  Future<String?> getCurrentCities(var accessToken, var userId, var userSopId) async {
    print("Cities Calling");
    await http.post(
      Uri.parse(ApiConstants.getOVFEdit),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: {
        'user_id': userId,
        'user_sop_id': userSopId
      },
    ).then((response) {
      var data = json.decode(response.body);
        pCitiesList = data['data']['current_cities'];
        cCitiesList = pCitiesList;
      print("Cities List -> $cCitiesList");
    }).catchError((error) {
      // Handle errors here
      print("Error: $error");
    });
  }

  Future<void> updatePersonalInfo(var accessToken, var userId, var userSopId) async {

    log('userId ------>$userId');
    log('user Sop Id ------->$userSopId');

    var otherNm = otherName.value == 'Yes' ? 1 : 0;
    var changeNm = changeName.value == 'Yes' ? 1 : 0;
    var gMF = piGender.value == 'M' ? 1 : 2;
    var paCountry = piPaCountry == 'India' ? 101 : 247;
    var caCountry = piCaCountry == 'India' ? 101 : 247;
    var caBox = piCdCheckBox.value == false ? 0 : 1;
    var mStatus = piMaritalStatus.value == 'Never Married'
        ? 1
        : piMaritalStatus.value =='Married'
        ? 2
        : piMaritalStatus.value =='Divorced'
        ? 3
        : piMaritalStatus.value =='Separated'
        ? 4
        : 5;
    var medicalS = piMedicalCondition.value == 'Yes' ? 1 : 0;
    try {
      Dio dio = Dio(BaseOptions(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${accessToken}',
            'Accept': 'application/json',
          }
      ));

      FormData formData = FormData.fromMap({
        'step': 1,
        'user_id': userId,
        'user_sop_id': userSopId,
        'user[first_name]': piFName.text,
        'user[middle_name]': piMName.text,
        'user[last_name]': piLName.text,
        'user[other_name_status]': otherNm.toString(),
        'user[other_name]': piOtherName.text,
        'user[changed_name_status]': changeNm.toString(),

        'user[changed_name]': changeNmFile == null ? '' : await MultipartFile.fromFile(changeNmFile!.path),

        'user[dob]': piBirthDate.text,
        'user[passport_no]': piPassportNo.text,
        'user[passport_exp_date]': piPassportExpiryDate.text,
        'user[first_language]': piFirstLanguage.text,
        'user[citizen_country_id]': piCountryOfCitizenShip.toString(),
        'user[gender]': gMF.toString(),
        'user[marital_status]': mStatus.toString(),
        'user[medical_condition_status]': medicalS.toString(),
        'user[medical_condition_note]': piSpecifyMedical.text,
        'user[email_id]': piEmail.text,
        'user[mobile_no]': piMobile.text,
        'user[parent_email_id]': piParentEmail.text,
        'user[phone_no]': piParentMobile.text,

        'user[current_address]': piPaAddress.text,
        'user[current_country_id]': paCountry,
        'user[current_state_id]': piPaState.toString(),
        'user[current_city_id]': piPaCity.toString(),
        'user[current_zip_code]': piPaPostCode.text,

        'user[same_as_current_address]': piCdCheckBox.toString(),

        'user[communication_address]': caBox == 1 ?  piPaAddress.text : piCaAddress.text,
        'user[communication_country_id]': caBox == 1 ? paCountry : caCountry,
        'user[communication_state_id]': caBox == 1 ? piPaState : piCaState.toString(),
        'user[communication_city_id]': caBox == 1 ? piCaCity : piCaCity.toString(),
        'user[communication_zip_code]': caBox == 1 ? piPaPostCode.text : piCAPostCode.text,
      });
      final response = await dio.post(
          ApiConstants.getOVFUpdate,
          data: formData,
          onSendProgress: (int sent, int total) {
            print('$sent $total');
          }
      );
      print("response code ->${response.statusCode}");
      print("response Message ->${response.statusMessage}");
      if (response.statusCode == 200) {
        var jsonResponse = response.data;
        var status = jsonResponse['status'];
        var message = jsonResponse['message'];

        print("Status -> $status");
        print("Message -> $message");

        if (status == 200) {
          SnackBarMessageShow.successsMSG('$message', context!);
          pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
        } else {
          SnackBarMessageShow.errorMSG('$message', context!);
          Navigator.pop(context!);
        }
      } else {
        SnackBarMessageShow.errorMSG('Something went wrong', context!);
        Navigator.pop(context!);
      }
    } catch (error) {
      SnackBarMessageShow.errorMSG('Something went wrong', context!);
      Navigator.pop(context!);
    }
  }
}