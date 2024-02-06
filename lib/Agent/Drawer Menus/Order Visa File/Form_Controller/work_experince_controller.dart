import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../App Helper/Api Repository/api_urls.dart';
import '../../../App Helper/Ui Helper/snackbar_msg_show.dart';

class WorkExperienceController extends GetxController{

  var pageController;
  BuildContext? context;
  WorkExperienceController({this.pageController,this.context});

  List<TextEditingController> position = [TextEditingController()];
  List<TextEditingController> oName = [TextEditingController()];
  List<TextEditingController> earning = [TextEditingController()];
  List<TextEditingController> sDate = [TextEditingController()];
  List<TextEditingController> eDate = [TextEditingController()];

  final  cNoJob = TextEditingController();
  final emailJob = TextEditingController();

  RxInt numberOfField = 1.obs;

  List<String?> occupationType = [];

  void clearFunction(){
    position.clear();
    oName.clear();
    earning.clear();
    sDate.clear();
    eDate.clear();
    numberOfField = 1.obs;
    occupationType.clear();
    position = [TextEditingController()];
    oName = [TextEditingController()];
    earning = [TextEditingController()];
    sDate = [TextEditingController()];
    eDate = [TextEditingController()];
  }

  List? occupationTypes;
  Future<String?> getOccupationType(var accessToken, var user_id, var user_sop_id) async {
    print("States Calling");
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
      print("Education List -> $occupationTypes");
    });
  }

  Future<void> updateWorkExperience(var accessToken, var user_id, var user_sop_id) async {
    try {
      Dio dio = Dio(BaseOptions(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${accessToken}',
            'Accept': 'application/json',
          }
      ));

      FormData formData = FormData.fromMap({
        'step': 4,
        'user_id': user_id,
        'user_sop_id': user_sop_id,
        'user[job_phone_no]': cNoJob.text,
        'user[job_email_id]': emailJob.text,
      });
      for(int i = 0; i < position.length; i++) {
        formData.fields.addAll([
          MapEntry('user_experience[$i][occupation_type_id]', occupationType[i].toString()),
          MapEntry('user_experience[$i][designation]', position[i].text),
          MapEntry('user_experience[$i][organization_name]', oName[i].text),
          MapEntry('user_experience[$i][from_date]', sDate[i].text),
          MapEntry('user_experience[$i][to_date]', eDate[i].text),
          MapEntry('user_experience[$i][earning_amount]', earning[i].text),
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