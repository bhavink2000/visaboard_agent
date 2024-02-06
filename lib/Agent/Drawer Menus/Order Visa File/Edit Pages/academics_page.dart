// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks, must_be_immutable, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:ffi';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:visaboard_agent/Agent/Drawer%20Menus/Order%20Visa%20File/Form_Controller/academics_controller.dart';
import 'package:visaboard_agent/Agent/Drawer%20Menus/Order%20Visa%20File/Ovf%20Widgets/edit_screen_textfield.dart';
import 'package:visaboard_agent/Agent/Drawer%20Menus/Order%20Visa%20File/Ovf%20Widgets/edits_screens_header.dart';
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
  AcademicsPage(
      {Key? key,
      this.pagecontroller,
      required this.editDetails,
      this.user_id,
      this.user_sop_id,
      this.tabStatus,
      this.tabName})
      : super(key: key);

  @override
  State<AcademicsPage> createState() => _AcademicsPageState();
}

class _AcademicsPageState extends State<AcademicsPage> {
  final acaController = Get.put(AcademicsController());

  GetAccessToken getAccessToken = GetAccessToken();
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    final acaController = Get.put(AcademicsController(
        pageController: widget.pagecontroller, context: context));
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        acaController.getEducationType(
            getAccessToken.access_token, widget.user_id, widget.user_sop_id);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (value){
        acaController.clearFunction();
      },
        child: Obx(() => Column(
      children: [
        EditScreenHeader(
          tabName: widget.tabName,
          tabIndex: 2,
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
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Education History",
                              style: TextStyle(fontSize: 18, fontFamily: Constants.OPEN_SANS, fontWeight: FontWeight.bold),
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              acaController.institutedName.add(TextEditingController());
                              acaController.courseName.add(TextEditingController());
                              acaController.fromDate.add(TextEditingController());
                              acaController.toDate.add(TextEditingController());
                              acaController.percentage.add(TextEditingController());
                              acaController.language.add(TextEditingController());
                              acaController.selectedLevelOfStudy.add(null);
                              acaController.numberOfField++;
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
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    itemCount: acaController.numberOfField.value,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 8,
                        child: Column(
                          children: [
                            EditSTextField(
                                controller: acaController.institutedName[index],
                                labelName: 'Name of institution'
                            ),
                            EditSTextField(
                                controller: acaController.courseName[index],
                                labelName: 'Name of course'
                            ),
                            Row(
                              children: [
                                Flexible(
                                    child: EditSTextField(
                                      controller: acaController.fromDate[index],
                                      readOnly: true,
                                      labelName: 'Start date',
                                      onTap: () async {
                                        DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1947),
                                          lastDate: DateTime.now(),
                                        );
                                        if (pickedDate != null) {
                                          String formatDate = DateFormat('yyyy-MM-DD').format(pickedDate);acaController.fromDate[index].text = formatDate;
                                        } else {
                                          Fluttertoast.showToast(msg: "Date is not selected", backgroundColor: Colors.deepPurple, textColor: Colors.white);
                                        }
                                      },
                                    )),
                                Flexible(
                                    child: EditSTextField(
                                      controller: acaController.toDate[index],
                                      readOnly: true,
                                      labelName: 'To date',
                                      onTap: () async {
                                        DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1947),
                                          lastDate: DateTime.now(),
                                        );
                                        if (pickedDate != null) {
                                          String formatDate = DateFormat('yyyy-MM-DD').format(pickedDate);acaController.toDate[index].text = formatDate;
                                        } else {
                                          Fluttertoast.showToast(msg: "Date is not selected", backgroundColor: Colors.deepPurple, textColor: Colors.white);
                                        }
                                      },
                                    ))
                              ],
                            ),
                            EditSTextField(
                                controller: acaController.percentage[index],
                                labelName: 'Percentage/CGPA/GPA'),
                            EditSTextField(
                                controller: acaController.language[index],
                                labelName: 'Primary language of instruction'),
                            Obx(() => Padding(
                              padding:
                              const EdgeInsets.fromLTRB(10, 5, 10, 10),
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  //height: MediaQuery.of(context).size.width / 7.5,
                                  child: DropdownButtonFormField<String>(
                                    dropdownColor: Colors.white,
                                    decoration: editFormsInputDecoration('Level of study'),
                                    value: acaController.selectedLevelOfStudy.length > index
                                        ? acaController.selectedLevelOfStudy[index]
                                        : null,
                                    style: TextStyle(fontSize: 18, fontFamily: Constants.OPEN_SANS, color: Colors.black),
                                    isExpanded: true,
                                    icon: acaController.getEd.value == true ? Container(width: 20,height: 20,margin: EdgeInsets.fromLTRB(0, 0, 8, 0),child: CircularProgressIndicator()) : Icon(Icons.arrow_drop_down_sharp),
                                    onChanged: (value) {
                                      if (acaController.selectedLevelOfStudy.length <= index) {
                                        acaController.selectedLevelOfStudy.addAll(List.filled(index - acaController.selectedLevelOfStudy.length + 1, null));
                                      }
                                      acaController.selectedLevelOfStudy[index] = value;
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return "can't be empty";
                                      } else {
                                        return null;
                                      }
                                    },
                                    items: acaController.educationTypes?.map((item) {
                                      return DropdownMenuItem<String>(
                                        value: item['id'].toString(),
                                        child: Text(item['name'], style: TextStyle(fontFamily: Constants.OPEN_SANS, fontSize: 10)),
                                      );
                                    }).toList() ?? [],
                                  )),
                            )),
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      acaController.clearFunction();
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
                        style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: Constants.OPEN_SANS),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () async {
                      acaController.updateAcademics(getAccessToken.access_token, widget.user_id, widget.user_sop_id);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: PrimaryColorOne,
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Text(
                        widget.tabStatus == 1 ? "Submit" : "Next",
                        style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: Constants.OPEN_SANS),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    )));
  }
}
