import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../App Helper/Api Repository/api_urls.dart';
import '../../../App Helper/Ui Helper/snackbar_msg_show.dart';

class SpouseController extends GetxController{

  var pageController;
  BuildContext? context;
  SpouseController({this.pageController,this.context});

  final sdSpouseNm = TextEditingController();
  final sdMaidenFNm = TextEditingController();
  final sdPassportNo = TextEditingController();
  final sdSpouseBDate = TextEditingController();
  final sdSpouseMDate = TextEditingController();
  final sdMarriagePlace = TextEditingController();
  final sdEngageDate = TextEditingController();
  final sdMarriageCRNo = TextEditingController();
  final sdDivorceDRNo = TextEditingController();
  final sdHighQualificationSpouse = TextEditingController();
  final sdDesignation = TextEditingController();
  final sdOrganizationNm = TextEditingController();
  final sdStartDate = TextEditingController();
  final sdEndDate = TextEditingController();
  final sdAnnualIncomeSpouse = TextEditingController();

  RxInt noOfChild = 1.obs;
  RxString sdChildBox = "".obs;
  List<TextEditingController> sdChildNm = [TextEditingController()];
  List<TextEditingController> sdChildBirthDate = [TextEditingController()];
  List<TextEditingController> sdChildBirthPlace = [TextEditingController()];
  List<TextEditingController> sdChildPassportNo = [TextEditingController()];
  List<TextEditingController> sdChildSchoolNm = [TextEditingController()];
  List<TextEditingController> sdChildStudy = [TextEditingController()];

  RxString spOccupation = ''.obs;

  List? occupationTypes;
  Future<String?> getOccupationType(var accessToken, var user_id, var user_sop_id) async {
    await http.post(
        Uri.parse(ApiConstants.getOVFEdit),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: {
          'user_id': user_id,
          'user_sop_id': user_sop_id
        }
    ).then((response) {
      var data = json.decode(response.body);
        occupationTypes = data['data']['occupation'];
      print("occupationTypes List -> $occupationTypes");
    });
  }

  Future<void> updateSpouse(var accessToken, var user_id, var user_sop_id) async {
    var childStatus = sdChildBox == 'Yes' ? 1 : 0;
    try {
      Dio dio = Dio(BaseOptions(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${accessToken}',
            'Accept': 'application/json',
          }
      ));

      FormData formData = FormData.fromMap({
        'step': 5,
        'user_id': user_id,
        'user_sop_id': user_sop_id,
        'user[spouse_full_name]': sdSpouseNm.text,
        'user[spouse_family_name]': sdMaidenFNm.text,
        'user[spouse_passport_no]': sdPassportNo.text,
        'user[spouse_dob]': sdSpouseBDate.text,
        'user[date_of_marriage]': sdSpouseMDate.text,
        'user[place_of_marriage]': sdMarriagePlace.text,
        'user[date_of_betrothal]': sdEngageDate.text,
        'user[marriage_reg_no]': sdMarriageCRNo.text,
        'user[divorce_reg_no]': sdDivorceDRNo.text,
        'user[spouse_education]': sdHighQualificationSpouse.text,
        'user_spouse_experience[0][occupation]': spOccupation.toString(),
        'user_spouse_experience[0][designation]': sdDesignation.text,
        'user_spouse_experience[0][organization_address]': sdOrganizationNm.text,
        'user_spouse_experience[0][from_date]': sdStartDate.text,
        'user_spouse_experience[0][to_date]': sdEndDate.text,
        'user_spouse_experience[0][annual_income]': sdAnnualIncomeSpouse.text,
        'user[have_child_status]': childStatus.toString(),
      });
      print("Form Data ->${formData.fields}");
      if(childStatus == 1){
        for(int i = 0; i < sdChildNm.length; i++) {
          formData.fields.addAll([
            MapEntry('user_child_detail[$i][full_name]', sdChildNm[i].text),
            MapEntry('user_experience[$i][dob]', sdChildBirthDate[i].text),
            MapEntry('user_experience[$i][birth_place]', sdChildBirthPlace[i].text),
            MapEntry('user_experience[$i][passport_no]', sdChildPassportNo[i].text),
            MapEntry('user_experience[$i][institute_name]', sdChildSchoolNm[i].text),
            MapEntry('user_experience[$i][study_standard]', sdChildStudy[i].text),
          ]);
        }
      }
      final response = await dio.post(
          ApiConstants.getOVFUpdate,
          data: formData,
          onSendProgress: (int sent, int total) {
            print('$sent $total');
          }
      ).onError((error, stackTrace){
        print("error > $error");
        return Future.error(error!);
      });
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
      //Navigator.pop(context);
    }
  }

  clearFunction(){
    noOfChild = 1.obs;
    sdChildBox = ''.obs;
    sdChildNm.clear();
    sdChildNm.clear();
    sdChildBirthDate.clear();
    sdChildBirthPlace.clear();
    sdChildPassportNo.clear();
    sdChildSchoolNm.clear();
    sdChildStudy.clear();
    sdChildNm = [TextEditingController()];
    sdChildBirthDate = [TextEditingController()];
    sdChildBirthPlace = [TextEditingController()];
    sdChildPassportNo = [TextEditingController()];
    sdChildSchoolNm = [TextEditingController()];
    sdChildStudy = [TextEditingController()];
  }
}