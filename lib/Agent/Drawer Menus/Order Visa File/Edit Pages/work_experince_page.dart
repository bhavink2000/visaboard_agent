// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:visaboard_agent/Agent/App%20Helper/Ui%20Helper/text_helper.dart';
import 'package:visaboard_agent/Agent/Drawer%20Menus/Order%20Visa%20File/Form_Controller/work_experince_controller.dart';
import 'package:visaboard_agent/Agent/Drawer%20Menus/Order%20Visa%20File/Ovf%20Widgets/edit_screen_textfield.dart';
import 'package:visaboard_agent/Agent/Drawer%20Menus/Order%20Visa%20File/Ovf%20Widgets/edits_screens_header.dart';
import '../../../App Helper/Api Repository/api_urls.dart';
import '../../../App Helper/Get Access Token/get_access_token.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Models/Drawer%20Menus%20Model/order_visafile_edit_model.dart';
import '../../../App Helper/Ui Helper/snackbar_msg_show.dart';
import '../../../App Helper/Ui Helper/ui_helper.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';


class WorkExperiencePage extends StatefulWidget {
  var pagecontroller;
  OVFEditData editDetails;
  var user_id, user_sop_id;
  var tabStatus,tabName;
  WorkExperiencePage({Key? key,this.pagecontroller,required this.editDetails,this.user_id,this.user_sop_id,this.tabStatus,this.tabName}) : super(key: key);

  @override
  State<WorkExperiencePage> createState() => _WorkExperiencePageState();
}

class _WorkExperiencePageState extends State<WorkExperiencePage> {

  final weController = Get.put(WorkExperienceController());

  GetAccessToken getAccessToken = GetAccessToken();
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    final weController = Get.put(WorkExperienceController(pageController: widget.pagecontroller,context: context));
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        weController.getOccupationType(getAccessToken.access_token, widget.user_id, widget.user_sop_id);
        //getOccupationType(getAccessToken.access_token);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (value){
        weController.clearFunction();
      },
      child: Obx(() => Column(
        children: [
          EditScreenHeader(
            tabName: widget.tabName,
            tabIndex: 4,
            tabStatus: widget.tabStatus,
            tabMessage: widget.editDetails.message,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
            child: Align(alignment: Alignment.topLeft,child: Text("Other Detail",style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold),)),
          ),
          EditSTextField(
            controller: weController.cNoJob,
            labelName: '${WorkExperienceTextHelper.firstText}',
          ),
          EditSTextField(
              controller: weController.emailJob,
              labelName: '${WorkExperienceTextHelper.twoText}'
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
                                "Work Experience",
                                style: TextStyle(fontSize: 18, fontFamily: Constants.OPEN_SANS, fontWeight: FontWeight.bold),
                              )
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                weController.occupationType.add(null);
                                weController.position.add(TextEditingController());
                                weController.oName.add(TextEditingController());
                                weController.earning.add(TextEditingController());
                                weController.sDate.add(TextEditingController());
                                weController.eDate.add(TextEditingController());
                                weController.numberOfField++;
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
                      itemCount: weController.numberOfField.value,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Card(
                            elevation: 8,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      //height: MediaQuery.of(context).size.width / 7.5,
                                      child: DropdownButtonFormField<String>(
                                        dropdownColor: Colors.white,
                                        decoration: editFormsInputDecoration('${WorkExperienceTextHelper.threeText}'),
                                        value: weController.occupationType.length > index ? weController.occupationType[index] : null,
                                        style: TextStyle(fontSize: 18, fontFamily: Constants.OPEN_SANS, color: Colors.black),
                                        isExpanded: true,
                                        onChanged: (value) {
                                          if(weController.occupationType.length <= index){
                                            weController.occupationType.addAll(List.filled(index - weController.occupationType.length + 1, null));
                                          }
                                          weController.occupationType[index] = value;
                                        },
                                        validator: (value) {
                                          if (value == null) {
                                            return "Can't be empty";
                                          } else {
                                            return null;
                                          }
                                        },
                                        items: weController.occupationTypes?.map((item) {
                                          return DropdownMenuItem<String>(
                                            value: item['id'].toString(),
                                            child: Text(item['name'], style: TextStyle(fontFamily: Constants.OPEN_SANS, fontSize: 10)),
                                          );
                                        }).toList() ?? [],
                                      )
                                  ),
                                ),
                                EditSTextField(
                                    controller: weController.position[index],
                                    labelName: '${WorkExperienceTextHelper.fourText}'
                                ),
                                EditSTextField(
                                    controller: weController.oName[index],
                                    labelName: '${WorkExperienceTextHelper.fiveText}'
                                ),
                                EditSTextField(
                                    controller: weController.earning[index],
                                    labelName: '${WorkExperienceTextHelper.sixText}'
                                ),

                                Row(
                                  children: [
                                    Flexible(
                                        child: EditSTextField(
                                          controller: weController.sDate[index],
                                          labelName: '${WorkExperienceTextHelper.sevenText}',
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
                                              weController.sDate[index].text = formatDate;
                                            }
                                            else{
                                              Fluttertoast.showToast(msg: 'date is not selected',backgroundColor: Colors.deepPurple,textColor: Colors.white);
                                            }
                                          },
                                        )
                                    ),
                                    Flexible(
                                        child: EditSTextField(
                                          controller: weController.eDate[index],
                                          labelName: '${WorkExperienceTextHelper.eightText}',
                                          readOnly: true,
                                          onTap: () async {
                                            DateTime? pickedDate = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime.now(),
                                            );
                                            if(pickedDate != null ){
                                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                              weController.eDate[index].text = formattedDate;
                                            }else{
                                              Fluttertoast.showToast(msg: "Date is not selected",backgroundColor: Colors.deepPurple,textColor: Colors.white);
                                            }
                                          },
                                        )
                                    )
                                  ],
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
                        weController.clearFunction();
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
                        weController.updateWorkExperience(getAccessToken.access_token, widget.user_id, widget.user_sop_id);
                        //updateWorkExperience();
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
