import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import '../../../App Helper/Api Repository/api_urls.dart';
import '../../../App Helper/Ui Helper/snackbar_msg_show.dart';

class LanguageController extends GetxController{

  var pageController;
  BuildContext? context;
  LanguageController({this.pageController,this.context});

  List<TextEditingController> cNo = [TextEditingController()];
  List<TextEditingController> read = [TextEditingController()];
  List<TextEditingController> write = [TextEditingController()];
  List<TextEditingController> speak = [TextEditingController()];
  List<TextEditingController> listen = [TextEditingController()];
  List<TextEditingController> overA = [TextEditingController()];
  List<TextEditingController> tDate = [TextEditingController()];
  List<String?> yesNo = [];

  RxInt numberOfField = 1.obs;


  void clearFunction(){
    cNo.clear();
    read.clear();
    write.clear();
    speak.clear();
    listen.clear();
    overA.clear();
    tDate.clear();
    eType.clear();
    yesNo.clear();
    numberOfField = 1.obs;
    cNo = [TextEditingController()];
    read = [TextEditingController()];
    write = [TextEditingController()];
    speak = [TextEditingController()];
    listen = [TextEditingController()];
    overA = [TextEditingController()];
    tDate = [TextEditingController()];
  }

  List<String?> eType = [];
  List? testTypes;
  RxBool getTest = false.obs;
  Future<String?> getTestType(var accessToken, var user_id, var user_sop_id) async {
    getTest(true);
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
        testTypes = data['data']['test_types'];
        getTest(false);
      print("Education List -> $testTypes");
    });
  }

  Future<void> updateLanguage(var accessToken, var user_id, var user_sop_id) async {
    try {
      Dio dio = Dio(BaseOptions(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${accessToken}',
            'Accept': 'application/json',
          }
      ));

      FormData formData = FormData.fromMap({
        'step': 3,
        'user_id': user_id,
        'user_sop_id': user_sop_id,
      });
      for(int i = 0; i < cNo.length; i++) {
        var yesno = yesNo[i].toString() == 'Yes' ? 1 : 0;
        formData.fields.addAll([
          MapEntry('user_test_score[$i][taken_english_test_status]', yesno.toString()),
          MapEntry('user_test_score[$i][test_type_id]', eType[i].toString()),
          MapEntry('user_test_score[$i][exam_at]', tDate[i].text),
          MapEntry('user_test_score[$i][cerificate_no]', cNo[i].text),
          MapEntry('user_test_score[$i][listening_score]', listen[i].text),
          MapEntry('user_test_score[$i][reading_score]', read[i].text),
          MapEntry('user_test_score[$i][writing_score]', write[i].text),
          MapEntry('user_test_score[$i][speaking_score]', speak[i].text),
          MapEntry('user_test_score[$i][over_all_score]', overA[i].text),
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