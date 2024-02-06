// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import '../../../App Helper/Api Repository/api_urls.dart';
import '../../../App Helper/Ui Helper/snackbar_msg_show.dart';

class AcademicsController extends GetxController{

  var pageController;
  BuildContext? context;
  AcademicsController({this.pageController,this.context});


  List<TextEditingController> institutedName = [TextEditingController()];
  List<TextEditingController> courseName = [TextEditingController()];
  List<TextEditingController> fromDate = [TextEditingController()];
  List<TextEditingController> toDate = [TextEditingController()];
  List<TextEditingController> percentage = [TextEditingController()];
  List<TextEditingController> language = [TextEditingController()];

  void clearFunction(){
    institutedName.clear();
    courseName.clear();
    fromDate.clear();
    toDate.clear();
    percentage.clear();
    language.clear();
    selectedLevelOfStudy.clear();
    educationTypes!.clear();
    numberOfField = 1.obs;
    institutedName = [TextEditingController()];
    courseName = [TextEditingController()];
    fromDate = [TextEditingController()];
    toDate = [TextEditingController()];
    percentage = [TextEditingController()];
    language = [TextEditingController()];
  }

  RxInt numberOfField = 1.obs;
  List<String?> selectedLevelOfStudy = [];

  List? educationTypes;
  RxBool getEd = false.obs;
  Future<String?> getEducationType(var accessToken,var userId, var userSopId) async {
    getEd(true);
    await http.post(
        Uri.parse(ApiConstants.getOVFEdit),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: {
          'user_id': userId,
          'user_sop_id': userSopId
        }
    ).then((response) {
      var data = json.decode(response.body);
        educationTypes = data['data']['education_types'];
        getEd(false);
      log("Education List -> $educationTypes");
    });
  }

  Future<void> updateAcademics(var accessToken,var userId, var userSopId) async {
    try {
      Dio dio = Dio(BaseOptions(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${accessToken}',
            'Accept': 'application/json',
          }
      ));

      FormData formData = FormData.fromMap({
        'step': 2,
        'user_id': userId,
        'user_sop_id': userSopId,
      });
      for(int i = 0; i < institutedName.length; i++) {
        formData.fields.addAll([
          MapEntry('user_education[$i][education_type_id]', selectedLevelOfStudy[i].toString()),
          MapEntry('user_education[$i][other_education_type_name]', 'educationName'),
          MapEntry('user_education[$i][institute_name]', institutedName[i].text),
          MapEntry('user_education[$i][course_name]', courseName[i].text),
          MapEntry('user_education[$i][from_date]', fromDate[i].text),
          MapEntry('user_education[$i][to_date]', toDate[i].text),
          MapEntry('user_education[$i][grade]', percentage[i].text),
          MapEntry('user_education[$i][language]', language[i].text),
        ]);
      }
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

        if (status == 200) {
          SnackBarMessageShow.successsMSG('$message', context!);
          pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
        } else {
          SnackBarMessageShow.warningMSG('$message', context!);
          Navigator.pop(context!);
        }
      } else {
        SnackBarMessageShow.warningMSG('Something went wrong', context!);
        Navigator.pop(context!);
      }
    } catch (error) {
      SnackBarMessageShow.warningMSG('Something went wrong', context!);
      Navigator.pop(context!);
    }
  }
}