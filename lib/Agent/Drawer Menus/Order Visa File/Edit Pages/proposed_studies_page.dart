// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Ui%20Helper/text_helper.dart';
import 'package:visaboard_agent/Agent/Drawer%20Menus/Order%20Visa%20File/Form_Controller/proposed_studies_controller.dart';
import '../../../App Helper/Api Repository/api_urls.dart';
import '../../../App Helper/Get Access Token/get_access_token.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Models/Drawer%20Menus%20Model/order_visafile_edit_model.dart';
import '../../../App Helper/Ui Helper/snackbar_msg_show.dart';
import '../../../App Helper/Ui Helper/ui_helper.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../Ovf Widgets/edits_screens_header.dart';


class ProposedStudiesPage extends StatefulWidget {
  var pagecontroller;
  OVFEditData editDetails;
  var user_id, user_sop_id;
  var tabStatus,tabName;
  ProposedStudiesPage({Key? key,this.pagecontroller,required this.editDetails,this.user_id,this.user_sop_id,this.tabStatus,this.tabName}) : super(key: key);

  @override
  State<ProposedStudiesPage> createState() => _ProposedStudiesPageState();
}

class _ProposedStudiesPageState extends State<ProposedStudiesPage> {


  GetAccessToken getAccessToken = GetAccessToken();
  final psController = Get.put(ProposedController());
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    final psController = Get.put(ProposedController(pageController: widget.pagecontroller,context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EditScreenHeader(
          tabName: widget.tabName,
          tabIndex: 6,
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
                              "Proposed Education in Foreign country",
                              style: TextStyle(fontSize: 18, fontFamily: Constants.OPEN_SANS, fontWeight: FontWeight.bold),
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              psController.eName.add(TextEditingController());
                              psController.cName.add(TextEditingController());
                              psController.campus.add(TextEditingController());
                              psController.cInTake.add(TextEditingController());
                              psController.eDate.add(TextEditingController());
                              psController.eFees.add(TextEditingController());
                              psController.offerLetter.add(null);
                              psController.numberOfField++;
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
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: psController.numberOfField.value,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                        child: Card(
                          elevation: 8,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                                child: TextFormField(
                                  controller: psController.eName[index],
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  decoration: editFormsInputDecoration('${ProposedStudiedTextHelper.firstText}'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'this field is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: SizedBox(
                                  //height: MediaQuery.of(context).size.width / 8,
                                  child: TextField(
                                    controller: psController.cName[index],
                                    decoration: editFormsInputDecoration('${ProposedStudiedTextHelper.twoText}'),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: SizedBox(
                                  //height: MediaQuery.of(context).size.width / 8,
                                  child: TextField(
                                    controller: psController.campus[index],
                                    decoration: editFormsInputDecoration('${ProposedStudiedTextHelper.threeText}'),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: SizedBox(
                                  //height: MediaQuery.of(context).size.width / 8,
                                  child: TextField(
                                    controller: psController.cInTake[index],
                                    decoration: editFormsInputDecoration('${ProposedStudiedTextHelper.fourText}'),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                child: Column(
                                  children: [
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Do you Hold any Conditional &/or Unconditional Offer Letter?",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),)
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

                              Visibility(
                                visible: psController.offerLetter.isEmpty ? false : psController.offerLetter[index] == 'Yes' ? true : false,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        //height: MediaQuery.of(context).size.width / 8,
                                        child: TextField(
                                          controller: psController.eDate[index],
                                          readOnly: true,
                                          decoration: editFormsInputDecoration('${ProposedStudiedTextHelper.fiveText}'),
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
                                                psController.eDate[index].text = formattedDate;
                                              });
                                            }else{
                                              Fluttertoast.showToast(msg: "Date is not selected",backgroundColor: Colors.deepPurple,textColor: Colors.white);
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                                      child: SizedBox(
                                        //height: MediaQuery.of(context).size.width / 8,
                                        child: TextField(
                                          controller: psController.eFees[index],
                                          decoration: editFormsInputDecoration('${ProposedStudiedTextHelper.sixText}'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
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
                      widget.pagecontroller.previousPage(duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: PrimaryColorOne,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                      updateProposedStudies();
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: PrimaryColorOne,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
    );
  }

  Widget _buildRadioListTile(String title, int index) {
    return RadioListTile<String?>(
      title: Text(
        title,
        style: TextStyle(
          fontFamily: Constants.OPEN_SANS,
          letterSpacing: 0.5,
          fontSize: 10,
        ),
      ),
      value: title,
      groupValue: psController.offerLetter.length > index ? psController.offerLetter[index] : null,
      onChanged: (String? value) {
        setState(() {
          if (psController.offerLetter.length <= index) {
            psController.offerLetter.addAll(List.filled(index - psController.offerLetter.length + 1, null));
          }
          psController.offerLetter[index] = value;
        });
      },
    );
  }

  Future<void> updateProposedStudies() async {
    try {
      Dio dio = Dio(BaseOptions(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${getAccessToken.access_token}',
            'Accept': 'application/json',
          }
      ));

      FormData formData = FormData.fromMap({
        'step': 6,
        'user_id': widget.user_id,
        'user_sop_id': widget.user_sop_id,
      });
      for(int i = 0; i < psController.eName.length; i++) {
        var offer = psController.offerLetter[i] == 'Yes' ? 1 : 0;
        formData.fields.addAll([
          MapEntry('user_foreign_institute_detail[$i][institute_name]', psController.eName[i].text),
          MapEntry('user_foreign_institute_detail[$i][education_course]', psController.cName[i].text),
          MapEntry('user_foreign_institute_detail[$i][campus]', psController.campus[i].text),
          MapEntry('user_foreign_institute_detail[$i][course_intend]', psController.cInTake[i].text),
          MapEntry('user_foreign_institute_detail[$i][hold_offer_letter_status]', offer.toString()),
          MapEntry('user_foreign_institute_detail[$i][education_from_date]', psController.eDate[i].text),
          MapEntry('user_foreign_institute_detail[$i][total_tuition_fees]', psController.eFees[i].text),
        ]);
      }
      final response = await dio.post(
          ApiConstants.getOVFUpdate,
          data: formData,
          onSendProgress: (int sent, int total) {
            print('$sent $total');
          }
      );

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
          SnackBarMessageShow.warningMSG('$message', context);
          Navigator.pop(context);
        }
      } else {
        SnackBarMessageShow.warningMSG('Something went wrong', context);
        Navigator.pop(context);
      }
    } catch (error) {
      log('error->${error.toString()}');
      SnackBarMessageShow.warningMSG('Something went wrong', context);
      Navigator.pop(context);
    }
  }
}
