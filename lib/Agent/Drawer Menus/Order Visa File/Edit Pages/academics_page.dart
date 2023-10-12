// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks, must_be_immutable, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../../../App Helper/Api Repository/api_urls.dart';
import '../../../App Helper/Get Access Token/get_access_token.dart';
import '../../../App Helper/Ui Helper/snackbar_msg_show.dart';
import '../../../App Helper/Ui Helper/ui_helper.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Models/Drawer%20Menus%20Model/order_visafile_edit_model.dart';

class AcademicsPage extends StatefulWidget {
  var pagecontroller;
  OVFEditData editDetails;
  var user_id, user_sop_id;
  var tabStatus, tabName;
  AcademicsPage({Key? key,this.pagecontroller,required this.editDetails,this.user_id,this.user_sop_id,this.tabStatus,this.tabName}) : super(key: key);

  @override
  State<AcademicsPage> createState() => _AcademicsPageState();
}

class _AcademicsPageState extends State<AcademicsPage> {

  final acInstitutedName = TextEditingController();
  final acCourseName = TextEditingController();
  final acFromDate = TextEditingController();
  final acToDate = TextEditingController();
  final acPercentage = TextEditingController();
  final acLanguage = TextEditingController();

  List<TextEditingController> institutedName = [TextEditingController()];
  List<TextEditingController> courseName = [TextEditingController()];
  List<TextEditingController> fromDate = [TextEditingController()];
  List<TextEditingController> toDate = [TextEditingController()];
  List<TextEditingController> percentage = [TextEditingController()];
  List<TextEditingController> language = [TextEditingController()];

  int numberofitems = 1;
  List<String?> selectedLevelOfStudy = [];

  GetAccessToken getAccessToken = GetAccessToken();
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        getEducationtype(getAccessToken.access_token);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)
            ),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("${widget.tabName}",
                      style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 18,letterSpacing: 1),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: 2,
                      color: widget.tabStatus == 1 ? Colors.green : Colors.red,
                    )
                  ],
                )
            )
          ],
        ),
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black45.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)]
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("You have submitted request for Visa File SOP, Canada, on Date: December 7th, 2022 12:46 PM.",style: TextStyle(fontSize: 13,fontFamily: Constants.OPEN_SANS,color: Colors.green),),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(alignment: Alignment.topLeft,child: Text("Education History",style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold),)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    institutedName.add(TextEditingController());
                    courseName.add(TextEditingController());
                    fromDate.add(TextEditingController());
                    toDate.add(TextEditingController());
                    percentage.add(TextEditingController());
                    language.add(TextEditingController());
                    selectedLevelOfStudy.add('');
                    numberofitems++;
                    setState(() {});
                  },
                  child: Container(
                    color: PrimaryColorOne,
                    padding: const EdgeInsets.all(6),
                    child: Text("Add More +",style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: numberofitems,
            itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  elevation: 8,
                  child: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.width / 8,
                            child: TextField(
                              controller: institutedName[index],
                              decoration: InputDecoration(
                                  hintText: 'Name of Institution ',
                                  hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.width / 8,
                            child: TextField(
                              controller: courseName[index],
                              decoration: InputDecoration(
                                  hintText: 'Name of Course',
                                  hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  height: MediaQuery.of(context).size.width / 8,
                                  child: TextField(
                                    controller: fromDate[index],
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                        labelText: "Start Date"
                                    ),
                                    onTap: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2101)
                                      );
                                      if(pickedDate != null ){
                                        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                        setState(() {
                                          fromDate[index].text = formattedDate;
                                        });
                                      }else{
                                        Fluttertoast.showToast(msg: "Date is not selected",backgroundColor: Colors.deepPurple,textColor: Colors.white);
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  height: MediaQuery.of(context).size.width / 8,
                                  child: TextField(
                                    controller: toDate[index],
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                        labelText: "End Date"
                                    ),
                                    onTap: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime.now(),
                                      );
                                      if(pickedDate != null ){
                                        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                        setState(() {
                                          toDate[index].text = formattedDate;
                                        });
                                      }else{
                                        Fluttertoast.showToast(msg: "Date is not selected",backgroundColor: Colors.deepPurple,textColor: Colors.white);
                                      }
                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.width / 8,
                            child: TextField(
                              controller: percentage[index],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: 'Percentage/CGPA/GPA',
                                  hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.width / 8,
                            child: TextField(
                              controller: language[index],
                              decoration: InputDecoration(
                                  hintText: 'Primary Language of Instruction',
                                  hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width / 6.5,
                              child: DropdownButtonFormField(
                                dropdownColor: Colors.white,
                                decoration: const InputDecoration(
                                  //border: InputBorder.none,
                                    hintText: 'Level Of Study',
                                    hintStyle: TextStyle(fontSize: 10)
                                ),
                                value: selectedLevelOfStudy[index],
                                style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,color: Colors.black),
                                isExpanded: true,
                                onChanged: (value) {
                                  setState(() {
                                    selectedLevelOfStudy[index] = value as String?;
                                  });
                                },
                                onSaved: (value) {
                                  setState(() {
                                    selectedLevelOfStudy[index] = value as String?;
                                  });
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return "can't empty";
                                  } else {
                                    return null;
                                  }
                                },
                                items: educationTypes?.map((item) {
                                  return DropdownMenuItem(
                                    value: item['id'].toString(),
                                    child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)),
                                  );
                                })?.toList() ?? [],
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 20, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    widget.pagecontroller.previousPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: PrimaryColorOne,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Text(
                      "Back",
                      style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: Constants.OPEN_SANS),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () async{
                    updateAcademics();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: PrimaryColorOne,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Text(
                      widget.tabStatus == 1 ? "Submit" : "Next",
                      style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: Constants.OPEN_SANS),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  List? educationTypes;
  Future<String?> getEducationtype(var accesstoken) async {
    print("States Calling");
    await http.post(
        Uri.parse(ApiConstants.getOVFEdit),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $accesstoken',
        },
        body: {
          'user_id': widget.user_id,
          'user_sop_id': widget.user_sop_id
        }
    ).then((response) {
      var data = json.decode(response.body);
      setState(() {
        educationTypes = data['data']['education_types'];
      });
      print("Education List -> $educationTypes");
    });
  }

  Future<void> updateAcademics() async {
    try {
      Dio dio = Dio(BaseOptions(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${getAccessToken.access_token}',
            'Accept': 'application/json',
          }
      ));

      FormData formData = FormData.fromMap({
        'step': 2,
        'user_id': widget.user_id,
        'user_sop_id': widget.user_sop_id,
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
      print("Form Data->${formData.fields}");
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
          SnackBarMessageShow.successsMSG('$message', context);
          widget.pagecontroller.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
        } else {
          SnackBarMessageShow.errorMSG('$message', context);
          Navigator.pop(context);
        }
      } else {
        SnackBarMessageShow.errorMSG('Something went wrong', context);
        Navigator.pop(context);
      }
    } catch (error) {
      SnackBarMessageShow.errorMSG('Something went wrong', context);
      Navigator.pop(context);
    }
  }
}
