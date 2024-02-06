// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Ui%20Helper/text_helper.dart';
import 'package:visaboard_agent/Agent/Drawer%20Menus/Order%20Visa%20File/Form_Controller/spouse_details_controller.dart';
import 'package:visaboard_agent/Agent/Drawer%20Menus/Order%20Visa%20File/Ovf%20Widgets/edit_screen_textfield.dart';
import 'package:visaboard_agent/Agent/Drawer%20Menus/Order%20Visa%20File/Ovf%20Widgets/edits_screens_header.dart';

import '../../../App Helper/Api Repository/api_urls.dart';
import '../../../App Helper/Get Access Token/get_access_token.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Models/Drawer%20Menus%20Model/order_visafile_edit_model.dart';
import '../../../App Helper/Ui Helper/snackbar_msg_show.dart';
import '../../../App Helper/Ui Helper/ui_helper.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';


class SpouseDetailsPage extends StatefulWidget {
  var pagecontroller;
  OVFEditData editDetails;
  var user_id, user_sop_id;
  var tabStatus,tabName;
  SpouseDetailsPage({Key? key,this.pagecontroller,required this.editDetails,this.user_id,this.user_sop_id,this.tabStatus,this.tabName}) : super(key: key);

  @override
  State<SpouseDetailsPage> createState() => _SpouseDetailsPageState();
}

class _SpouseDetailsPageState extends State<SpouseDetailsPage> {
  

  GetAccessToken getAccessToken = GetAccessToken();
  
  final sdController = Get.put(SpouseController());
  
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    final sdController = Get.put(SpouseController(pageController: widget.pagecontroller,context: context));
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        sdController.getOccupationType(getAccessToken.access_token, widget.user_id, widget.user_sop_id);
        //getOccupationType(getAccessToken.access_token);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (value){
        sdController.clearFunction();
      },
      child: Obx(() => Column(
        children: [
          EditScreenHeader(
            tabName: widget.tabName,
            tabIndex: 5,
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
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                      child: Align(alignment: Alignment.topLeft,child: Text("Spouse Detail",style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold),)),
                    ),
                    EditSTextField(controller: sdController.sdSpouseNm, labelName: '${SpouseDetailsTextHelper.firstText}'),
                    EditSTextField(controller: sdController.sdMaidenFNm, labelName: '${SpouseDetailsTextHelper.twoText}'),
                    EditSTextField(controller: sdController.sdPassportNo, labelName: '${SpouseDetailsTextHelper.threeText}'),
                    Row(
                      children: [
                        Flexible(
                            child: EditSTextField(
                              controller: sdController.sdSpouseBDate,
                              labelName: '${SpouseDetailsTextHelper.fourText}',
                              readOnly: true,
                              onTap: ()async{
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now(),
                                );
                                if(pickedDate != null ){
                                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                  sdController.sdSpouseBDate.text = formattedDate;
                                }else{
                                  Fluttertoast.showToast(msg: "Date is not selected",backgroundColor: Colors.deepPurple,textColor: Colors.white);
                                }
                              },
                            )
                        ),
                        Flexible(
                            child: EditSTextField(
                              controller: sdController.sdSpouseMDate,
                              labelName: '${SpouseDetailsTextHelper.fiveText}',
                              readOnly: true,
                              onTap: ()async{
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now(),
                                );
                                if(pickedDate != null ){
                                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                  sdController.sdSpouseMDate.text = formattedDate;
                                }else{
                                  Fluttertoast.showToast(msg: "Date is not selected",backgroundColor: Colors.deepPurple,textColor: Colors.white);
                                }
                              },
                            )
                        )
                      ],
                    ),
                    EditSTextField(controller: sdController.sdMarriagePlace, labelName: '${SpouseDetailsTextHelper.sixText}'),
                    Row(
                      children: [
                        Flexible(
                            child: EditSTextField(
                              controller: sdController.sdEngageDate,
                              labelName: '${SpouseDetailsTextHelper.sevenText}',
                              readOnly: true,
                              onTap: ()async{
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime.now()
                                );
                                if(pickedDate != null ){
                                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                  sdController.sdEngageDate.text = formattedDate;
                                }else{
                                  Fluttertoast.showToast(msg: "Date is not selected",backgroundColor: Colors.deepPurple,textColor: Colors.white);
                                }
                              },
                            )
                        ),
                        Flexible(
                          child: Obx(() => Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                //height: MediaQuery.of(context).size.width / 7.5,
                                child: DropdownButtonFormField(
                                  dropdownColor: Colors.white,
                                  decoration: editFormsInputDecoration('${SpouseDetailsTextHelper.eightText}'),
                                  value: sdController.spOccupation.value.isNotEmpty
                                      ? sdController.spOccupation.value
                                      : (sdController.occupationTypes?.isNotEmpty == true
                                      ? sdController.occupationTypes![0]['id'].toString()
                                      : null),
                                  style: TextStyle(fontSize: 18, fontFamily: Constants.OPEN_SANS, color: Colors.black),
                                  isExpanded: true,
                                  onChanged: (value) {
                                    sdController.spOccupation.value = value.toString();
                                  },
                                  validator: (value) {
                                    if (value == null || value.toString().isEmpty) {
                                      return "Can't be empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                  items: sdController.occupationTypes?.map((item) {
                                    return DropdownMenuItem(
                                      value: item['id'].toString(),
                                      child: Text(item['name'], style: TextStyle(fontFamily: Constants.OPEN_SANS, fontSize: 10)),
                                    );
                                  }).toList() ?? [],
                                )

                            ),
                          )),
                        )
                      ],
                    ),
                    EditSTextField(controller: sdController.sdMarriageCRNo, labelName: '${SpouseDetailsTextHelper.nineText}'),
                    EditSTextField(controller: sdController.sdDivorceDRNo, labelName: '${SpouseDetailsTextHelper.tenText}'),
                    EditSTextField(controller: sdController.sdHighQualificationSpouse, labelName: '${SpouseDetailsTextHelper.elevenText}'),
                    EditSTextField(controller: sdController.sdDesignation, labelName: '${SpouseDetailsTextHelper.twelveText}'),
                    EditSTextField(controller: sdController.sdOrganizationNm, labelName: '${SpouseDetailsTextHelper.thirteenText}'),
                    Row(
                      children: [
                        Flexible(
                            child: EditSTextField(
                              controller: sdController.sdStartDate,
                              labelName: '${SpouseDetailsTextHelper.fourteenText}',
                              readOnly: true,
                              onTap: ()async{
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime.now()
                                );
                                if(pickedDate != null ){
                                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                  sdController.sdStartDate.text = formattedDate;
                                }else{
                                  Fluttertoast.showToast(msg: "Date is not selected",backgroundColor: Colors.deepPurple,textColor: Colors.white);
                                }
                              },
                            )
                        ),
                        Flexible(
                            child: EditSTextField(
                              controller: sdController.sdEndDate,
                              labelName: '${SpouseDetailsTextHelper.fifteenText}',
                              readOnly: true,
                              onTap: ()async{
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now(),
                                );
                                if(pickedDate != null ){
                                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                  sdController.sdEndDate.text = formattedDate;
                                }else{
                                  Fluttertoast.showToast(msg: "Date is not selected",backgroundColor: Colors.deepPurple,textColor: Colors.white);
                                }
                              },
                            )
                        )
                      ],
                    ),
                    EditSTextField(controller: sdController.sdAnnualIncomeSpouse, labelName: '${SpouseDetailsTextHelper.sixteenText}'),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text("Do you have any child ?",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),)
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: RadioListTile(
                                  title: Text("Yes",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                                  value: "Yes",
                                  groupValue: sdController.sdChildBox.value,
                                  onChanged: (value){
                                    sdController.sdChildBox.value = value.toString();
                                  },
                                ),
                              ),
                              Flexible(
                                child: RadioListTile(
                                  title: Text("No",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                                  value: "No",
                                  groupValue: sdController.sdChildBox.value,
                                  onChanged: (value){
                                    sdController.sdChildBox.value = value.toString();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: sdController.sdChildBox.value == 'Yes' ? true : false,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: (){
                                sdController.sdChildNm.add(TextEditingController());
                                sdController.sdChildBirthPlace.add(TextEditingController());
                                sdController.sdChildBirthDate.add(TextEditingController());
                                sdController.sdChildPassportNo.add(TextEditingController());
                                sdController.sdChildSchoolNm.add(TextEditingController());
                                sdController.sdChildStudy.add(TextEditingController());
                                sdController.noOfChild++;
                              },
                              child: Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: PrimaryColorOne),
                                child: Text("Add More +",style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 2,
                            child: ListView.builder(
                              shrinkWrap: false,
                              itemCount: sdController.noOfChild.value,
                              itemBuilder: (context, index){
                                return Column(
                                  children: [
                                    EditSTextField(controller: sdController.sdChildNm[index], labelName: '${SpouseDetailsTextHelper.seventeenText}'),
                                    EditSTextField(
                                      controller: sdController.sdChildBirthDate[index],
                                      labelName: '${SpouseDetailsTextHelper.eighteenText}',
                                      readOnly: true,
                                      onTap: ()async{
                                        DateTime? pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime.now()
                                        );
                                        if(pickedDate != null ){
                                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                          sdController.sdChildBirthDate[index].text = formattedDate;
                                        }else{
                                          Fluttertoast.showToast(msg: "Date is not selected",backgroundColor: Colors.deepPurple,textColor: Colors.white);
                                        }
                                      },
                                    ),
                                    EditSTextField(controller: sdController.sdChildBirthPlace[index], labelName: '${SpouseDetailsTextHelper.nineteenText}'),
                                    EditSTextField(controller: sdController.sdChildPassportNo[index], labelName: '${SpouseDetailsTextHelper.twentyText}'),
                                    EditSTextField(controller: sdController.sdChildSchoolNm[index], labelName: '${SpouseDetailsTextHelper.twentyOneText}'),
                                    EditSTextField(controller: sdController.sdChildStudy[index], labelName: '${SpouseDetailsTextHelper.twentyTwoText}'),
                                    Divider(color: Colors.grey,thickness: 1,endIndent: 20,indent: 20,)
                                  ],
                                );
                              },
                            ),
                          )
                        ],
                      ),
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
                        sdController.clearFunction();
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
                      onTap: (){
                        sdController.updateSpouse(getAccessToken.access_token, widget.user_id, widget.user_sop_id);
                        //updateSpouse();
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
}
