// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../../../App Helper/Api Repository/api_urls.dart';
import '../../../App Helper/Get Access Token/get_access_token.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Models/Drawer%20Menus%20Model/order_visafile_edit_model.dart';
import '../../../App Helper/Ui Helper/snackbar_msg_show.dart';
import '../../../App Helper/Ui Helper/ui_helper.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';


class LanguageTestPage extends StatefulWidget {
  var pagecontroller;
  OVFEditData editDetails;
  var user_id, user_sop_id;
  var tabStatus,tabName;
  LanguageTestPage({Key? key,this.pagecontroller,required this.editDetails,this.user_id,this.user_sop_id,this.tabStatus,this.tabName}) : super(key: key);

  @override
  State<LanguageTestPage> createState() => _LanguageTestPageState();
}

class _LanguageTestPageState extends State<LanguageTestPage> {

  //String _englishTYpe;
  //final certificateNo = TextEditingController();
  //final reading = TextEditingController();
  //final writing = TextEditingController();
  //final speaking = TextEditingController();
  //final listening = TextEditingController();
  //final overall = TextEditingController();
  //final testDate = TextEditingController();
  //String yesNo = '';

  List<TextEditingController> cNo = [TextEditingController()];
  List<TextEditingController> read = [TextEditingController()];
  List<TextEditingController> write = [TextEditingController()];
  List<TextEditingController> speak = [TextEditingController()];
  List<TextEditingController> listen = [TextEditingController()];
  List<TextEditingController> overA = [TextEditingController()];
  List<TextEditingController> tDate = [TextEditingController()];
  List<String> yes_no = [];

  int numberofitems = 1;
  List<String?> eType = [];

  GetAccessToken getAccessToken = GetAccessToken();
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        getTestType(getAccessToken.access_token);
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
              child: Align(alignment: Alignment.topLeft,child: Text("Test Scores",style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold),)),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  cNo.add(TextEditingController());
                  read.add(TextEditingController());
                  write.add(TextEditingController());
                  speak.add(TextEditingController());
                  listen.add(TextEditingController());
                  overA.add(TextEditingController());
                  tDate.add(TextEditingController());
                  eType.add('');
                  yes_no.add('');
                  numberofitems++;
                  setState(() {});
                },
                child: Container(
                  color: PrimaryColorOne,
                  padding: EdgeInsets.all(6),
                  child: Text("Add More +",style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                ),
              ),
            ),
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
                          height: MediaQuery.of(context).size.width / 8,
                          child: TextField(
                            controller: cNo[index],
                            decoration: InputDecoration(
                                hintText: 'Test Certificate Number ',
                                hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width / 8,
                                child: TextField(
                                  controller: read[index],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintText: 'Reading  ',
                                      hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width / 8,
                                child: TextField(
                                  controller: write[index],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintText: 'Writing  ',
                                      hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width / 8,
                                child: TextField(
                                  controller: speak[index],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintText: 'Speaking   ',
                                      hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width / 8,
                                child: TextField(
                                  controller: listen[index],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintText: 'Listening ',
                                      hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width / 8,
                                child: TextField(
                                  controller: overA[index],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintText: 'Over all  ',
                                      hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 2.8,
                                height: MediaQuery.of(context).size.width / 7,
                                child: TextField(
                                  controller: tDate[index],
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                      labelText: "Test Date"
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
                                        tDate[index].text = formattedDate;
                                      });
                                    }else{
                                      Fluttertoast.showToast(msg: "Date is not selected",backgroundColor: Colors.deepPurple,textColor: Colors.white);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
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
                                  hintText: 'English Test Type',
                                  hintStyle: TextStyle(fontSize: 10)
                              ),
                              value: eType[index],
                              style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,color: Colors.black),
                              isExpanded: true,
                              onChanged: (value) {
                                setState(() {
                                  eType[index] = value as String?;
                                });
                              },
                              onSaved: (value) {
                                setState(() {
                                  eType[index] = value as String?;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return "can't empty";
                                } else {
                                  return null;
                                }
                              },
                              items: testTypes!.map((item) {
                                return DropdownMenuItem(
                                  value: item['id'].toString(),
                                  child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)),
                                );
                              }).toList() ?? [],
                            )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text("Have you taken any English Language Proficiency Test?",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10),)
                            ),
                            Row(
                              children: [
                                Expanded(child: _buildRadioListTile("Yes", index)),
                                Expanded(child: _buildRadioListTile("No", index)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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
                  onTap: ()async{
                    updateLanguage();
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

  List? testTypes;
  Future<String?> getTestType(var accesstoken) async {
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
        testTypes = data['data']['test_types'];
      });
      print("Education List -> $testTypes");
    });
  }

  Widget _buildRadioListTile(String title, int index) {
    return RadioListTile(
      title: Text(
        title,
        style: TextStyle(
          fontFamily: Constants.OPEN_SANS,
          letterSpacing: 0.5,
          fontSize: 10,
        ),
      ),
      value: title,
      groupValue: yes_no[index],
      onChanged: (value) {
        setState(() {
          yes_no[index] = value!;
        });
      },
    );
  }

  Future<void> updateLanguage() async {

    try {
      Dio dio = Dio(BaseOptions(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${getAccessToken.access_token}',
            'Accept': 'application/json',
          }
      ));

      FormData formData = FormData.fromMap({
        'step': 3,
        'user_id': widget.user_id,
        'user_sop_id': widget.user_sop_id,
      });
      for(int i = 0; i < cNo.length; i++) {
        var yesNo = yes_no[i].toString() == 'Yes' ? 1 : 0;
        formData.fields.addAll([
          MapEntry('user_test_score[$i][taken_english_test_status]', yesNo.toString()),
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
