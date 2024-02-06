// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:ffi';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:visaboard_agent/Agent/Drawer%20Menus/Order%20Visa%20File/Form_Controller/language_controller.dart';
import 'package:visaboard_agent/Agent/Drawer%20Menus/Order%20Visa%20File/Ovf%20Widgets/edit_screen_textfield.dart';
import '../../../App Helper/Api Repository/api_urls.dart';
import '../../../App Helper/Get Access Token/get_access_token.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Models/Drawer%20Menus%20Model/order_visafile_edit_model.dart';
import '../../../App Helper/Ui Helper/snackbar_msg_show.dart';
import '../../../App Helper/Ui Helper/ui_helper.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../Ovf Widgets/edits_screens_header.dart';


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

  final lanController = Get.put(LanguageController());

  GetAccessToken getAccessToken = GetAccessToken();
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    final lanController = Get.put(LanguageController(pageController: widget.pagecontroller,context: context));
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        lanController.getTestType(getAccessToken.access_token, widget.user_id, widget.user_sop_id);
        //getTestType(getAccessToken.access_token);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (value){
        lanController.clearFunction();
      },
      child: Obx(() => Column(
        children: [
          EditScreenHeader(
            tabName: widget.tabName,
            tabIndex: 3,
            tabStatus: widget.tabStatus,
            tabMessage: widget.editDetails.message,
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Test Scores",
                                style: TextStyle(fontSize: 18, fontFamily: Constants.OPEN_SANS, fontWeight: FontWeight.bold),
                              )
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                lanController.cNo.add(TextEditingController());
                                lanController.read.add(TextEditingController());
                                lanController.write.add(TextEditingController());
                                lanController.speak.add(TextEditingController());
                                lanController.listen.add(TextEditingController());
                                lanController.overA.add(TextEditingController());
                                lanController.tDate.add(TextEditingController());
                                lanController.eType.add(null);
                                lanController.yesNo.add(null);
                                lanController.numberOfField++;
                              },
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: PrimaryColorOne),
                                child: Text(
                                  "Add More +",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: Constants.OPEN_SANS,
                                      fontSize: 13),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: lanController.numberOfField.value,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Card(
                            elevation: 8,
                            child: Column(
                              children: [
                                EditSTextField(
                                    controller: lanController.cNo[index],
                                    labelName: 'Test certificate number'
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: EditSTextField(
                                        controller: lanController.read[index],
                                        labelName: 'Reading',
                                      ),
                                    ),
                                    Flexible(
                                        child: EditSTextField(
                                          controller: lanController.write[index],
                                          labelName: 'Writing',
                                        )
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: EditSTextField(
                                        controller: lanController.speak[index],
                                        labelName: 'Speaking',
                                      ),
                                    ),
                                    Flexible(
                                        child: EditSTextField(
                                          controller: lanController.listen[index],
                                          labelName: 'Listening',
                                        )
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                        child: EditSTextField(
                                          controller: lanController.overA[index],
                                          labelName: 'Over all',
                                        )
                                    ),
                                    Flexible(
                                        child: EditSTextField(
                                          controller: lanController.tDate[index],
                                          labelName: 'Test date',
                                          readOnly: true,
                                          onTap: ()async{
                                            DateTime? pickedDate = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime.now(),
                                            );
                                            if(pickedDate != null){
                                              String formatDate = DateFormat('yyyy-MM-DD').format(pickedDate);
                                              lanController.tDate[index].text = formatDate;
                                            }
                                            else{
                                              Fluttertoast.showToast(msg: 'Date is not selected',backgroundColor: Colors.deepPurple,textColor: Colors.white);
                                            }
                                          },
                                        )
                                    ),
                                  ],
                                ),

                                Obx(() => Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      //height: MediaQuery.of(context).size.width / 6.5,
                                      child: DropdownButtonFormField<String>(
                                        dropdownColor: Colors.white,
                                        decoration: editFormsInputDecoration('English test type'),
                                        value: lanController.eType.length > index ? lanController.eType[index] : null,
                                        style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,color: Colors.black),
                                        isExpanded: true,
                                        icon: lanController.getTest.value == true ? Container(width: 20,height: 20,margin: EdgeInsets.fromLTRB(0, 0, 8, 0),child: CircularProgressIndicator()) : Icon(Icons.arrow_drop_down_sharp),
                                        onChanged: (value) {
                                          if(lanController.eType.length <= index){
                                            lanController.eType.addAll(List.filled(index - lanController.eType.length + 1, null));
                                          }
                                          lanController.eType[index] = value;
                                        },
                                        onSaved: (value) {

                                          if(lanController.eType.length <= index){
                                            lanController.eType.addAll(List.filled(index - lanController.eType.length + 1, null));
                                          }
                                          lanController.eType[index] = value;

                                        },
                                        validator: (value) {
                                          if (value == null) {
                                            return "can't empty";
                                          } else {
                                            return null;
                                          }
                                        },
                                        items: lanController.testTypes?.map((item) {
                                          return DropdownMenuItem<String>(
                                            value: item['id'].toString(),
                                            child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)),
                                          );
                                        }).toList() ?? [],
                                      )
                                  ),
                                )),

                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                  ],
                ),
              ),
            ),
          ),
          BottomAppBar(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: (){
                        lanController.clearFunction();
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
                        lanController.updateLanguage(getAccessToken.access_token, widget.user_id, widget.user_sop_id);
                        //updateLanguage();
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
          ),
        ],
      )),
    );
  }

  Widget _buildRadioListTile(String title, int index) {
    return RadioListTile<String?>(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
        ),
      ),
      value: title,
      groupValue: lanController.yesNo.length > index ? lanController.yesNo[index] : null,
      onChanged: (String? value) {
        setState(() {
          if (lanController.yesNo.length <= index) {
            lanController.yesNo.addAll(List.filled(index - lanController.yesNo.length + 1, null));
          }
          lanController.yesNo[index] = value;
        });
      },
    );
  }

}