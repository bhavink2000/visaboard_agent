// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:visaboard_agent/Agent/App%20Helper/Ui%20Helper/text_helper.dart';
import '../../../App Helper/Api Repository/api_urls.dart';
import '../../../App Helper/Get Access Token/get_access_token.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Models/Drawer%20Menus%20Model/order_visafile_edit_model.dart';
import '../../../App Helper/Ui Helper/snackbar_msg_show.dart';
import '../../../App Helper/Ui Helper/ui_helper.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';


class WorkExperincePage extends StatefulWidget {
  var pagecontroller;
  OVFEditData editDetails;
  var user_id, user_sop_id;
  var tabStatus,tabName;
  WorkExperincePage({Key? key,this.pagecontroller,required this.editDetails,this.user_id,this.user_sop_id,this.tabStatus,this.tabName}) : super(key: key);

  @override
  State<WorkExperincePage> createState() => _WorkExperincePageState();
}

class _WorkExperincePageState extends State<WorkExperincePage> {

  List<TextEditingController> position = [TextEditingController()];
  List<TextEditingController> oName = [TextEditingController()];
  List<TextEditingController> earning = [TextEditingController()];
  List<TextEditingController> sDate = [TextEditingController()];
  List<TextEditingController> eDate = [TextEditingController()];

  final  cNoJob = TextEditingController();
  final emailJob = TextEditingController();

  int numberofitems = 1;

  List<String?> occupationtype = [];
  GetAccessToken getAccessToken = GetAccessToken();
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        getOccupationType(getAccessToken.access_token);
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
              child: Text("${widget.editDetails.message}",style: TextStyle(fontSize: 13,fontFamily: Constants.OPEN_SANS,color: Colors.green),),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
          child: Align(alignment: Alignment.topLeft,child: Text("Other Detail",style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold),)),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          child: SizedBox(
            height: MediaQuery.of(context).size.width / 8,
            child: TextField(
              controller: cNoJob,
              decoration: editFormsInputDecoration('${WorkExperienceTextHelper.firstText}'),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 25),
          child: SizedBox(
            height: MediaQuery.of(context).size.width / 8,
            child: TextField(
              controller: emailJob,
              decoration: editFormsInputDecoration('${WorkExperienceTextHelper.twoText}'),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
              child: Align(alignment: Alignment.topLeft,child: Text("Work Experience",style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold),)),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: InkWell(
                onTap: (){
                  occupationtype.add(null);
                  position.add(TextEditingController());
                  oName.add(TextEditingController());
                  earning.add(TextEditingController());
                  sDate.add(TextEditingController());
                  eDate.add(TextEditingController());
                  numberofitems++;
                  setState(() {});
                },
                child: Container(
                  color: PrimaryColorOne,
                  padding: EdgeInsets.all(6),
                  child: Text("Add More +",style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                ),
              ),
            )
          ],
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
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width / 7.5,
                            child: DropdownButtonFormField<String>(
                              dropdownColor: Colors.white,
                              decoration: editFormsInputDecoration('${WorkExperienceTextHelper.threeText}'),
                              value: occupationtype.length > index ? occupationtype[index] : null,
                              style: TextStyle(fontSize: 18, fontFamily: Constants.OPEN_SANS, color: Colors.black),
                              isExpanded: true,
                              onChanged: (value) {
                                setState(() {
                                  if(occupationtype.length <= index){
                                    occupationtype.addAll(List.filled(index - occupationtype.length + 1, null));
                                  }
                                  occupationtype[index] = value;
                                });
                              },
                              onSaved: (value) {
                                setState(() {
                                  if(occupationtype.length <= index){
                                    occupationtype.addAll(List.filled(index - occupationtype.length + 1, null));
                                  }
                                  occupationtype[index] = value;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return "Can't be empty";
                                } else {
                                  return null;
                                }
                              },
                              items: occupationTypes?.map((item) {
                                return DropdownMenuItem<String>(
                                  value: item['id'].toString(),
                                  child: Text(item['name'], style: TextStyle(fontFamily: Constants.OPEN_SANS, fontSize: 10)),
                                );
                              }).toList() ?? [],
                            )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 8,
                          child: TextField(
                            controller: position[index],
                            decoration: editFormsInputDecoration('${WorkExperienceTextHelper.fourText}'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 8,
                          child: TextField(
                            controller: oName[index],
                            decoration: editFormsInputDecoration('${WorkExperienceTextHelper.fiveText}'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 8,
                          child: TextField(
                            controller: earning[index],
                            decoration: editFormsInputDecoration('${WorkExperienceTextHelper.sixText}'),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.width / 8,
                                child: TextField(
                                  controller: sDate[index],
                                  decoration: editFormsInputDecoration('${WorkExperienceTextHelper.sevenText}'),
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
                                        sDate[index].text = formattedDate;
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
                              padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.width / 8,
                                child: TextField(
                                  controller: eDate[index],
                                  decoration: editFormsInputDecoration('${WorkExperienceTextHelper.eightText}'),
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
                                        eDate[index].text = formattedDate;
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
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: (){
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
                  onTap: () async {
                    updateWorkExperience();
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
        ),
      ],
    );
  }

  List? occupationTypes;
  Future<String?> getOccupationType(var accesstoken) async {
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
        occupationTypes = data['data']['occupation'];
      });
      print("Education List -> $occupationTypes");
    });
  }

  Future<void> updateWorkExperience() async {
    try {
      Dio dio = Dio(BaseOptions(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${getAccessToken.access_token}',
            'Accept': 'application/json',
          }
      ));

      FormData formData = FormData.fromMap({
        'step': 4,
        'user_id': widget.user_id,
        'user_sop_id': widget.user_sop_id,
        'user[job_phone_no]': cNoJob.text,
        'user[job_email_id]': emailJob.text,
      });
      for(int i = 0; i < position.length; i++) {
        formData.fields.addAll([
          MapEntry('user_experience[$i][occupation_type_id]', occupationtype[i].toString()),
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
