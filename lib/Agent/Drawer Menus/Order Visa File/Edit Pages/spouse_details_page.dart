//@dart=2.9
// ignore_for_file: use_build_context_synchronously, must_be_immutable

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


class SpouseDetailsPage extends StatefulWidget {
  var pagecontroller;
  OVFEditData editDetails;
  var user_id, user_sop_id;
  var tabStatus,tabName;
  SpouseDetailsPage({Key key,this.pagecontroller,this.editDetails,this.user_id,this.user_sop_id,this.tabStatus,this.tabName}) : super(key: key);

  @override
  State<SpouseDetailsPage> createState() => _SpouseDetailsPageState();
}

class _SpouseDetailsPageState extends State<SpouseDetailsPage> {

  final sdSpouseNm = TextEditingController();
  final sdMaidenFNm = TextEditingController();
  final sdPassportNo = TextEditingController();
  final sdSpouseBDate = TextEditingController();
  final sdSpouseMDate = TextEditingController();
  final sdMarriagePlace = TextEditingController();
  final sdEngageDate = TextEditingController();
  final sdMarriageCRNo = TextEditingController();
  final sdDivorceDRNo = TextEditingController();
  final sdHighQualificationSpouse = TextEditingController();
  final sdDesignation = TextEditingController();
  final sdOrganizationNm = TextEditingController();
  final sdStartDate = TextEditingController();
  final sdEndDate = TextEditingController();
  final sdAnnualIncomeSpouse = TextEditingController();

  int noOfChild = 1;
  String sdChildBox = "";
  List<TextEditingController> sdChildNm = [TextEditingController()];
  List<TextEditingController> sdChildBirthDate = [TextEditingController()];
  List<TextEditingController> sdChildBirthPlace = [TextEditingController()];
  List<TextEditingController> sdChildPassportNo = [TextEditingController()];
  List<TextEditingController> sdChildSchoolNm = [TextEditingController()];
  List<TextEditingController> sdChildStudy = [TextEditingController()];

  String _spOccupation;

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
    return SingleChildScrollView(
      child: Column(
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
            child: Align(alignment: Alignment.topLeft,child: Text("Spouse Detail",style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold),)),
          ),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.width / 8,
                    child: TextField(
                      controller: sdSpouseNm,
                      decoration: InputDecoration(
                          hintText: 'Full Name of Spouse',
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
                      controller: sdMaidenFNm,
                      decoration: InputDecoration(
                          hintText: 'Maiden Family Name (in case of female)',
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
                      controller: sdPassportNo,
                      decoration: InputDecoration(
                          hintText: 'Passport Number',
                          hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 8,
                    child: TextField(
                      controller: sdSpouseBDate,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          labelText: "DOB of Spouse"
                      ),
                      onTap: () async {
                        DateTime pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                        );
                        if(pickedDate != null ){
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            sdSpouseBDate.text = formattedDate;
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
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 8,
                    child: TextField(
                      controller: sdSpouseMDate,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          labelText: "Marriage Date"
                      ),
                      onTap: () async {
                        DateTime pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                        );
                        if(pickedDate != null ){
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            sdSpouseMDate.text = formattedDate;
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
                controller: sdMarriagePlace,
                decoration: InputDecoration(
                    hintText: 'Place of Marriage',
                    hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                ),
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
                      controller: sdEngageDate,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          labelText: "Engagement Date"
                      ),
                      onTap: () async {
                        DateTime pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101)
                        );
                        if(pickedDate != null ){
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            sdEngageDate.text = formattedDate;
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
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 6.5,
                      child: DropdownButtonFormField(
                        dropdownColor: Colors.white,
                        decoration: const InputDecoration(
                          //border: InputBorder.none,
                            hintText: 'Occupation of Spouse',
                            hintStyle: TextStyle(fontSize: 10)
                        ),
                        value: _spOccupation,
                        style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,color: Colors.black),
                        isExpanded: true,
                        onChanged: (value) {
                          setState(() {
                            _spOccupation = value;
                          });
                        },
                        onSaved: (value) {
                          setState(() {
                            _spOccupation = value;
                          });
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "can't empty";
                          } else {
                            return null;
                          }
                        },
                        items: occupationTypes?.map((item) {
                          return DropdownMenuItem(
                            value: item['id'].toString(),
                            child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)),
                          );
                        })?.toList() ?? [],
                      )
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
                controller: sdMarriageCRNo,
                decoration: InputDecoration(
                    hintText: 'Marriage Certificate Registration Number',
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
                controller: sdDivorceDRNo,
                decoration: InputDecoration(
                    hintText: 'Divorce Decree Registration Number',
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
                controller: sdHighQualificationSpouse,
                decoration: InputDecoration(
                    hintText: 'Highest Qualification of Spouse',
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
                controller: sdDesignation,
                decoration: InputDecoration(
                    hintText: 'Designation / Position',
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
                controller: sdOrganizationNm,
                decoration: InputDecoration(
                    hintText: 'Name & Address of the Organization',
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
                      controller: sdStartDate,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          labelText: "Start Date"
                      ),
                      onTap: () async {
                        DateTime pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101)
                        );
                        if(pickedDate != null ){
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            sdStartDate.text = formattedDate;
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
                      controller: sdEndDate,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          labelText: "End Date"
                      ),
                      onTap: () async {
                        DateTime pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                        );
                        if(pickedDate != null ){
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            sdEndDate.text = formattedDate;
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
                controller: sdAnnualIncomeSpouse,
                decoration: InputDecoration(
                    hintText: 'Annual income of Spouse',
                    hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
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
                        groupValue: sdChildBox,
                        onChanged: (value){
                          setState(() {
                            sdChildBox = value.toString();
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: RadioListTile(
                        title: Text("No",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                        value: "No",
                        groupValue: sdChildBox,
                        onChanged: (value){
                          setState(() {
                            sdChildBox = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Visibility(
            visible: sdChildBox == 'No' ? false : true,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                      sdChildNm.add(TextEditingController());
                      sdChildBirthPlace.add(TextEditingController());
                      sdChildBirthDate.add(TextEditingController());
                      sdChildPassportNo.add(TextEditingController());
                      sdChildSchoolNm.add(TextEditingController());
                      sdChildStudy.add(TextEditingController());
                      noOfChild++;
                      setState(() {});
                    },
                    child: Container(
                      color: PrimaryColorOne,
                      padding: EdgeInsets.all(6),
                      child: Text("Add More +",style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  child: ListView.builder(
                    itemCount: noOfChild,
                    itemBuilder: (context, index){
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.width / 8,
                              child: TextField(
                                controller: sdChildNm[index],
                                decoration: InputDecoration(
                                    hintText: 'Full Name of Child',
                                    hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.width / 6,
                              child: TextField(
                                controller: sdChildBirthDate[index],
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                    labelText: "Date of Birth of Child"
                                ),
                                onTap: () async {
                                  DateTime pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101)
                                  );
                                  if(pickedDate != null ){
                                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                    setState(() {
                                      sdChildBirthDate[index].text = formattedDate;
                                    });
                                  }else{
                                    Fluttertoast.showToast(msg: "Date is not selected",backgroundColor: Colors.deepPurple,textColor: Colors.white);
                                  }
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.width / 8,
                              child: TextField(
                                controller: sdChildBirthPlace[index],
                                decoration: InputDecoration(
                                    hintText: 'Place of Birth of Child',
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
                                controller: sdChildPassportNo[index],
                                decoration: InputDecoration(
                                    hintText: 'Passport Number',
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
                                controller: sdChildSchoolNm[index],
                                decoration: InputDecoration(
                                    hintText: 'School Name',
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
                                controller: sdChildStudy[index],
                                decoration: InputDecoration(
                                    hintText: 'Standard in which studying',
                                    hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
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
                    onTap: (){
                       updateSpouse();
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
      ),
    );
  }

  List occupationTypes;
  Future<String> getOccupationType(var accesstoken) async {
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
  Future<void> updateSpouse() async {
    var childStatus = sdChildBox == 'Yes' ? 1 : 0;
    try {
      Dio dio = Dio(BaseOptions(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${getAccessToken.access_token}',
            'Accept': 'application/json',
          }
      ));

      FormData formData = FormData.fromMap({
        'step': 5,
        'user_id': widget.user_id,
        'user_sop_id': widget.user_sop_id,
        'user[spouse_full_name]': sdSpouseNm.text,
        'user[spouse_family_name]': sdMaidenFNm.text,
        'user[spouse_passport_no]': sdPassportNo.text,
        'user[spouse_dob]': sdSpouseBDate.text,
        'user[date_of_marriage]': sdSpouseMDate.text,
        'user[place_of_marriage]': sdMarriagePlace.text,
        'user[date_of_betrothal]': sdEngageDate.text,
        'user[marriage_reg_no]': sdMarriageCRNo.text,
        'user[divorce_reg_no]': sdDivorceDRNo.text,
        'user[spouse_education]': sdHighQualificationSpouse.text,
        'user_spouse_experience[0][occupation]': _spOccupation.toString(),
        'user_spouse_experience[0][designation]': sdDesignation.text,
        'user_spouse_experience[0][organization_address]': sdOrganizationNm.text,
        'user_spouse_experience[0][from_date]': sdStartDate.text,
        'user_spouse_experience[0][to_date]': sdEndDate.text,
        'user_spouse_experience[0][annual_income]': sdAnnualIncomeSpouse.text,
        'user[have_child_status]': childStatus.toString(),
      });
      print("Form Data ->${formData.fields}");
      if(childStatus == 1){
        for(int i = 0; i < sdChildNm.length; i++) {
          formData.fields.addAll([
            MapEntry('user_child_detail[$i][full_name]', sdChildNm[i].text),
            MapEntry('user_experience[$i][dob]', sdChildBirthDate[i].text),
            MapEntry('user_experience[$i][birth_place]', sdChildBirthPlace[i].text),
            MapEntry('user_experience[$i][passport_no]', sdChildPassportNo[i].text),
            MapEntry('user_experience[$i][institute_name]', sdChildSchoolNm[i].text),
            MapEntry('user_experience[$i][study_standard]', sdChildStudy[i].text),
          ]);
        }
      }
      final response = await dio.post(
          ApiConstants.getOVFUpdate,
          data: formData,
          onSendProgress: (int sent, int total) {
            print('$sent $total');
          }
      ).onError((error, stackTrace){
        print("error > $error");
      });
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
      //Navigator.pop(context);
    }
  }
}
