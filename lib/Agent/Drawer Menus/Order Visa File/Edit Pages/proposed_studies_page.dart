// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Ui%20Helper/text_helper.dart';
import '../../../App Helper/Api Repository/api_urls.dart';
import '../../../App Helper/Get Access Token/get_access_token.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Models/Drawer%20Menus%20Model/order_visafile_edit_model.dart';
import '../../../App Helper/Ui Helper/snackbar_msg_show.dart';
import '../../../App Helper/Ui Helper/ui_helper.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';


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

  List<TextEditingController> eName = [TextEditingController()];
  List<TextEditingController> cName = [TextEditingController()];
  List<TextEditingController> campus = [TextEditingController()];
  List<TextEditingController> cINtake = [TextEditingController()];
  List<TextEditingController> eDate = [TextEditingController()];
  List<TextEditingController> eFees = [TextEditingController()];
  List<String?> offerLetter = [];

  int numberofitems = 1;
  GetAccessToken getAccessToken = GetAccessToken();
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 5),
              child: Align(alignment: Alignment.topLeft,child: Text("Proposed Education in Foreign country",style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold),)),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: InkWell(
                onTap: (){
                  eName.add(TextEditingController());
                  cName.add(TextEditingController());
                  campus.add(TextEditingController());
                  cINtake.add(TextEditingController());
                  eDate.add(TextEditingController());
                  eFees.add(TextEditingController());
                  offerLetter.add(null);
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
            physics: BouncingScrollPhysics(),
            itemCount: numberofitems,
            itemBuilder: (context, index){

              print("----------------");
              print('index ->$index');
              print('offerLetter ->${offerLetter.length}');
              //print('offerLetter ->${offerLetter[index]}');
              print('offerLetter ->${offerLetter}');

              print("----------------");
              return Padding(
                padding: EdgeInsets.all(10),
                child: Card(
                  elevation: 8,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 8,
                          child: TextField(
                            controller: eName[index],
                            decoration: editFormsInputDecoration('${ProposedStudiedTextHelper.firstText}'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 8,
                          child: TextField(
                            controller: cName[index],
                            decoration: editFormsInputDecoration('${ProposedStudiedTextHelper.twoText}'),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 8,
                          child: TextField(
                            controller: campus[index],
                            decoration: editFormsInputDecoration('${ProposedStudiedTextHelper.threeText}'),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 8,
                          child: TextField(
                            controller: cINtake[index],
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
                        visible: offerLetter.isEmpty ? false : offerLetter[index] == 'Yes' ? true : false,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width / 8,
                                child: TextField(
                                  controller: eDate[index],
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
                                        eDate[index].text = formattedDate;
                                      });
                                    }else{
                                      Fluttertoast.showToast(msg: "Date is not selected",backgroundColor: Colors.deepPurple,textColor: Colors.white);
                                    }
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width / 8,
                                child: TextField(
                                  controller: eFees[index],
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
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
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
      groupValue: offerLetter.length > index ? offerLetter[index] : null,
      onChanged: (String? value) {
        setState(() {
          if (offerLetter.length <= index) {
            offerLetter.addAll(List.filled(index - offerLetter.length + 1, null));
          }
          offerLetter[index] = value;
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
      for(int i = 0; i < eName.length; i++) {
        var offer = offerLetter[i] == 'Yes' ? 1 : 0;
        formData.fields.addAll([
          MapEntry('user_foreign_institute_detail[$i][institute_name]', eName[i].text),
          MapEntry('user_foreign_institute_detail[$i][education_course]', cName[i].text),
          MapEntry('user_foreign_institute_detail[$i][campus]', campus[i].text),
          MapEntry('user_foreign_institute_detail[$i][course_intend]', cINtake[i].text),
          MapEntry('user_foreign_institute_detail[$i][hold_offer_letter_status]', offer.toString()),
          MapEntry('user_foreign_institute_detail[$i][education_from_date]', eDate[i].text),
          MapEntry('user_foreign_institute_detail[$i][total_tuition_fees]', eFees[i].text),
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
