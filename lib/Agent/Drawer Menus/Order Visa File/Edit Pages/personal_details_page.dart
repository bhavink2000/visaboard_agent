// ignore_for_file: use_build_context_synchronously, must_be_immutable, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Models/Drawer%20Menus%20Model/order_visafile_edit_model.dart';
import '../../../App Helper/Api Repository/api_urls.dart';
import '../../../App Helper/Get Access Token/get_access_token.dart';
import '../../../App Helper/Ui Helper/snackbar_msg_show.dart';
import '../../../App Helper/Ui Helper/ui_helper.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';


class PersonalDetailsPage extends StatefulWidget {
  var pagecontroller;
  OVFEditData? editDetails;
  var user_id, user_sop_id;
  var tabStatus, tabName;
  PersonalDetailsPage({Key? key,this.pagecontroller,required this.editDetails,this.user_id,this.user_sop_id,this.tabStatus,this.tabName}) : super(key: key);

  @override
  State<PersonalDetailsPage> createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  GetAccessToken getAccessToken = GetAccessToken();

  final piFName = TextEditingController();
  final piMName = TextEditingController();
  final piLName = TextEditingController();

  String otherName = "";
  bool othername = false;
  final piOtherName = TextEditingController();

  String changeName = "";
  bool changename = false;
  File? cNameFile;

  final piBirthDate = TextEditingController();
  final piPassportNo = TextEditingController();
  final piPassportExpiryDate = TextEditingController();
  final piFirstLanguage = TextEditingController();

  String? _piCountryOfCitizenShip;
  var contry;
  List<String> piCountryCitizenShip = ['India', 'Other Country'];

  String piGender = "";
  String piMaritalStatus = "";
  String piMedicalCondition = "";
  final piSpecifyMedical = TextEditingController();

  final piEmail = TextEditingController();
  final piMobile = TextEditingController();
  final piParentEmail = TextEditingController();
  final piParentMobile = TextEditingController();

  final piPAAddress = TextEditingController();
  var _piPACountry;
  String? _piPAState;
  String? _piPACity;
  final piPAPostCode = TextEditingController();

  bool piCABox = false;

  final piCAAddress = TextEditingController();
  var _piCACountry;
  String? _piCAState;
  String? _piCACity;
  final piCAPostCode = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    if (widget.editDetails!.user != null) {
      piFName.text = widget.editDetails!.user!.firstName ?? '';
      piMName.text = widget.editDetails!.user!.middleName ?? '';
      piLName.text = widget.editDetails!.user!.lastName ?? '';
      piEmail.text = widget.editDetails!.user!.emailId ?? '';
      piMobile.text = widget.editDetails!.user!.mobileNo ?? '';
      piBirthDate.text = widget.editDetails!.user!.dob ?? '';
      piPassportNo.text = widget.editDetails!.user!.passportNo ?? '';
      piPassportExpiryDate.text = widget.editDetails!.user!.passportExpDate ?? '';
      piFirstLanguage.text = widget.editDetails!.user!.firstLanguage ?? '';
      piPAAddress.text = widget.editDetails!.user!.communicationAddress ?? '';
      piPAPostCode.text = widget.editDetails!.user!.communicationZipCode ?? '';
      piCAAddress.text = widget.editDetails!.user!.currentAddress ?? '';
      piCAPostCode.text = widget.editDetails!.user!.currentZipCode ?? '';
    } else {
      // Handle the case where widget.editDetails!.user is null.
      // You can set default values or handle it as needed.
    }
  }

  @override
  Widget build(BuildContext context) {
    print("S/N -> ${widget.tabStatus} / ${widget.tabName}");
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
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text("[ 1 / 10 ]",
                            style: TextStyle(fontFamily: Constants.OPEN_SANS,color: widget.tabStatus == 1 ? Colors.green : Colors.red,),
                          ),
                          SizedBox(width: 5),
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 2,
                            color: widget.tabStatus == 1 ? Colors.green : Colors.red,
                          ),
                        ],
                      ),
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
                child: Text("${widget.editDetails!.message}",style: TextStyle(fontSize: 13,fontFamily: Constants.OPEN_SANS,color: Colors.green),),
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                child: Align(alignment: Alignment.topLeft,child: Text("Personal Information",style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold),)),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                child: Align(alignment: Alignment.topLeft,child: Text("(As indicated on your passport)",style: TextStyle(fontSize: 10))),
              ),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width / 8,
                        child: TextField(
                          controller: piFName,
                          decoration: InputDecoration(
                              hintText: 'Given Name/s (exactly as on your passport) *',
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
                          controller: piMName,
                          decoration: InputDecoration(
                              hintText: 'Middle Name *',
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
                          controller: piLName,
                          decoration: InputDecoration(
                              hintText: 'Family Name (exactly as on your passport)*',
                              hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text("Have you ever known by any other name? (alias / maiden)",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10),)
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: RadioListTile(
                                  title: Text("Yes",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 0.5,fontSize: 10),),
                                  value: "Yes",
                                  groupValue: otherName,
                                  onChanged: (value){
                                    setState(() {
                                      otherName = value.toString();
                                      othername = otherName == 'Yes' ? true : false;
                                    });
                                  },
                                ),
                              ),
                              Flexible(
                                child: RadioListTile(
                                  title: Text("No",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 0.5,fontSize: 10),),
                                  value: "No",
                                  groupValue: otherName,
                                  onChanged: (value){
                                    setState(() {
                                      otherName = value.toString();
                                      othername = otherName == 'No' ? false : true;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: othername,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width / 8,
                                child: TextField(
                                  controller: piOtherName,
                                  decoration: InputDecoration(
                                      hintText: 'Other Name',
                                      hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text("Have you ever changed your name? (proof required)",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10),)
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: RadioListTile(
                                  title: Text("Yes",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 0.5,fontSize: 10),),
                                  value: "Yes",
                                  groupValue: changeName,
                                  onChanged: (value){
                                    setState(() {
                                      changeName = value.toString();
                                      changename = changeName == 'Yes' ? true : false;
                                    });
                                  },
                                ),
                              ),
                              Flexible(
                                child: RadioListTile(
                                  title: Text("No",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 0.5,fontSize: 10),),
                                  value: "No",
                                  groupValue: changeName,
                                  onChanged: (value){
                                    setState(() {
                                      changeName = value.toString();
                                      changename = changeName == 'No' ? false : true;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: changename,
                            child: Card(
                              elevation: 10,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: PrimaryColorOne
                                        ),
                                        onPressed: ()async {
                                          try{
                                            FilePickerResult? pickedfile = await FilePicker.platform.pickFiles(type: FileType.any);
                                            if(pickedfile != null){
                                              setState((){
                                                cNameFile = File(pickedfile.files.single.path!);
                                              });
                                            }
                                          }
                                          on PlatformException catch (e) {
                                            print(" File not Picked ");
                                          }
                                        },
                                        child: cNameFile == null
                                            ? const Text("Choose File",style: TextStyle(color: Colors.white))
                                            : const Text("File Picked",style: TextStyle(color: Colors.white))
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: cNameFile == null ? const Text("No File Chosen",style: TextStyle(fontSize: 12),) : Expanded(child: Text(cNameFile!.path.split('/').last,style: const TextStyle(fontSize: 9),))
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width / 8,
                        child: TextField(
                          controller: piPassportNo,
                          decoration: InputDecoration(
                              hintText: 'Passport Number * ',
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
                          controller: piFirstLanguage,
                          decoration: InputDecoration(
                              hintText: 'First language *',
                              hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: MediaQuery.of(context).size.width / 8,
                              child: DropdownButtonFormField(
                                dropdownColor: Colors.white,
                                decoration: const InputDecoration(
                                  //border: InputBorder.none,
                                    hintText: 'Country of citizenship',
                                    hintStyle: TextStyle(fontSize: 10)
                                ),
                                value: _piCountryOfCitizenShip,
                                style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,color: Colors.black),
                                isExpanded: true,
                                onChanged: (value) {
                                  setState(() {
                                    _piCountryOfCitizenShip = value;
                                    contry = _piCountryOfCitizenShip == 'India' ? 101 : 247;
                                  });
                                },
                                onSaved: (value) {
                                  setState(() {
                                    _piCountryOfCitizenShip = value;
                                    contry = _piCountryOfCitizenShip == 'India' ? 101 : 247;
                                  });
                                },
                                validator: (String? value) {
                                  if (value == null) {
                                    return "can't empty";
                                  } else {
                                    return null;
                                  }
                                },
                                items: piCountryCitizenShip.map((String val) {
                                  return DropdownMenuItem(
                                    value: val,
                                    child: Text(val,style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,color: Colors.black),),
                                  );
                                }).toList(),
                              )
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 2.6,
                                height: MediaQuery.of(context).size.width / 8,
                                child: TextField(
                                  controller: piPassportExpiryDate,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                      labelText: "Passport Expiry Date"
                                  ),
                                  readOnly: true,
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
                                        piPassportExpiryDate.text = formattedDate;
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
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                      child: Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 2.8,
                                height: MediaQuery.of(context).size.width / 8,
                                child: TextField(
                                  controller: piBirthDate,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                      labelText: "Date of birth *"
                                  ),
                                  readOnly: true,
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
                                        piBirthDate.text = formattedDate;
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
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("Gender *",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),)
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: RadioListTile(
                                        title: Text("M",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                                        value: "M",
                                        groupValue: piGender,
                                        onChanged: (value){
                                          setState(() {
                                            piGender = value.toString();
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: RadioListTile(
                                        title: Text("F",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                                        value: "F",
                                        groupValue: piGender,
                                        onChanged: (value){
                                          setState(() {
                                            piGender = value.toString();
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text("Marital status",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1),)
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3.2,
                                height: MediaQuery.of(context).size.height / 20,
                                child: RadioListTile(
                                  contentPadding: const EdgeInsets.all(1),
                                  title: Text("Married",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10),),
                                  value: "Married",
                                  groupValue: piMaritalStatus,
                                  onChanged: (value){
                                    setState(() {
                                      piMaritalStatus = value.toString();
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3.2,
                                height: MediaQuery.of(context).size.height / 20,
                                child: RadioListTile(
                                  contentPadding: const EdgeInsets.all(1),
                                  title: Text("Divorced",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10),),
                                  value: "Divorced",
                                  groupValue: piMaritalStatus,
                                  onChanged: (value){
                                    setState(() {
                                      piMaritalStatus = value.toString();
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3.2,
                                height: MediaQuery.of(context).size.height / 20,
                                child: RadioListTile(
                                  contentPadding: const EdgeInsets.all(1),
                                  title: Text("Separated",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10),),
                                  value: "Separated",
                                  groupValue: piMaritalStatus,
                                  onChanged: (value){
                                    setState(() {
                                      piMaritalStatus = value.toString();
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 20,
                        child: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 20,
                              child: RadioListTile(
                                contentPadding: const EdgeInsets.all(1),
                                title: Text("Never Married",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10),),
                                value: "Never Married",
                                groupValue: piMaritalStatus,
                                onChanged: (value){
                                  setState(() {
                                    piMaritalStatus = value.toString();
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 3.1,
                              height: MediaQuery.of(context).size.height / 20,
                              child: RadioListTile(
                                contentPadding: const EdgeInsets.all(1),
                                title: Text("Betrothed",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10),),
                                value: "Betrothed",
                                groupValue: piMaritalStatus,
                                onChanged: (value){
                                  setState(() {
                                    piMaritalStatus = value.toString();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text("Do you suffer from a serious medical condition?",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),)
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: RadioListTile(
                                title: Text("Yes",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                                value: "Yes",
                                groupValue: piMedicalCondition,
                                onChanged: (value){
                                  setState(() {
                                    piMedicalCondition = value.toString();
                                  });
                                },
                              ),
                            ),
                            Flexible(
                              child: RadioListTile(
                                title: Text("No",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                                value: "No",
                                groupValue: piMedicalCondition,
                                onChanged: (value){
                                  setState(() {
                                    piMedicalCondition = value.toString();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                  child: Align(alignment: Alignment.topLeft,child: Text("Address Detail",style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold),)),
                ),
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 8,
                          child: TextField(
                            controller: piEmail,
                            decoration: InputDecoration(
                                hintText: 'Email',
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
                            controller: piMobile,
                            decoration: InputDecoration(
                                hintText: 'Phone number ',
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
                            controller: piParentEmail,
                            decoration: InputDecoration(
                                hintText: 'Parents email address',
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
                            controller: piParentMobile,
                            decoration: InputDecoration(
                                hintText: 'Alternate no. (Either parent)',
                                hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 0, 5),
                        child: Align(alignment: Alignment.topLeft,child: Text("Present address",style: TextStyle(fontSize: 12))),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 8,
                          child: TextField(
                            controller: piPAAddress,
                            decoration: InputDecoration(
                                hintText: 'Address ',
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
                                  hintText: 'Country',
                                  hintStyle: TextStyle(fontSize: 10)
                              ),
                              value: _piPACountry,
                              style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,color: Colors.black),
                              isExpanded: true,
                              onChanged: (value) {
                                setState(() {
                                  _piPACountry = value;
                                  print('P Country ->$_piPACountry');
                                  if(_piPACountry == 'India'){
                                    getCurrentStates(getAccessToken.access_token);
                                    //getCurrentCities(getAccessToken.access_token);
                                  }
                                  else{
                                    pStatesList!.clear();
                                    pCitiesList!.clear();
                                  }
                                });
                              },
                              onSaved: (value) {
                                setState(() {
                                  _piPACountry = value;
                                  print('P Country ->$_piPACountry');
                                  if(_piPACountry == 'India'){
                                    getCurrentStates(getAccessToken.access_token);
                                    //getCurrentCities(getAccessToken.access_token);
                                  }
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return "can't empty";
                                } else {
                                  return null;
                                }
                              },
                              items: piCountryCitizenShip.map((String val) {
                                return DropdownMenuItem(
                                  value: val,
                                  child: Text(val,style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,color: Colors.black),),
                                );
                              }).toList(),
                            )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width / 6.5,
                          child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                              //border: InputBorder.none,
                                hintText: 'State',
                                hintStyle: TextStyle(fontSize: 12)
                            ),
                            value: _piPAState,
                            isExpanded: true,
                            onTap: (){
                              if(_piPACity == null){
                                setState(() {
                                  if(_piPACountry == 101){
                                    getCurrentCities(getAccessToken.access_token);
                                  }
                                });
                              }
                              else{
                                setState(() {
                                  _piPACity = null;
                                  getCurrentStates(getAccessToken.access_token);
                                });
                              }
                            },
                            onChanged: (state) {
                              if(_piPACity == null){
                                setState(() {
                                  _piPAState = state as String?;
                                  getCurrentCities(getAccessToken.access_token);
                                });
                              }
                              else{
                                setState(() {
                                  _piPACity = null;
                                  getCurrentStates(getAccessToken.access_token);
                                });
                              }
                            },
                            items: cStatesList?.map((item) {
                              return DropdownMenuItem(
                                value: item['id'].toString(),
                                child: Text(
                                  item['name'],
                                  style: TextStyle(fontFamily: Constants.OPEN_SANS, fontSize: 10),
                                ),
                              );
                            }).toList() ?? [],
                          )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width / 6.5,
                          child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                                hintText: 'City',
                                hintStyle: TextStyle(fontSize: 12)
                            ),
                            value: _piPACity,
                            isExpanded: true,
                            onChanged: (city) {

                              setState(() {
                                _piPACity = city as String?;
                              });
                            },
                            items: (cCitiesList ?? []).map((item) {
                              return DropdownMenuItem(
                                value: item['id'].toString(),
                                child: Text(
                                  item['name'],
                                  style: TextStyle(fontFamily: Constants.OPEN_SANS, fontSize: 10),
                                ),
                              );
                            }).toList(),
                          )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 8,
                          child: TextField(
                            controller: piPAPostCode,
                            decoration: InputDecoration(
                                hintText: 'Postal/Zip Code ',
                                hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 0, 5),
                        child: Row(
                          children: [
                            const Align(alignment: Alignment.topLeft,child: Text("Communication address",style: TextStyle(fontSize: 12))),
                            Flexible(
                              child: Checkbox(
                                checkColor: Colors.white,
                                value: piCABox,
                                onChanged: (bool? value) {
                                  setState(() {
                                    piCABox = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 8,
                          child: TextField(
                            controller: piCAAddress,
                            decoration: InputDecoration(
                                hintText: 'Address ',
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
                                  hintText: 'Country',
                                  hintStyle: TextStyle(fontSize: 10)
                              ),
                              value: _piCACountry,
                              style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,color: Colors.black),
                              isExpanded: true,
                              onChanged: (value) {
                                setState(() {
                                  _piCACountry = value;
                                  print('C Country ->$_piCACountry');
                                  if(_piCACountry == 'India'){
                                    getCurrentStates(getAccessToken.access_token);
                                    //getCurrentCities(getAccessToken.access_token);
                                  }
                                  else{
                                    cStatesList!.clear();
                                    cCitiesList!.clear();
                                  }
                                });
                              },
                              onSaved: (value) {
                                setState(() {
                                  _piCACountry = value;
                                  print('C Country ->$_piCACountry');
                                  if(_piCACountry == 'India'){
                                    getCurrentStates(getAccessToken.access_token);
                                    //getCurrentCities(getAccessToken.access_token);
                                  }
                                  else{
                                    cStatesList!.clear();
                                    cCitiesList!.clear();
                                  }
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return "can't empty";
                                } else {
                                  return null;
                                }
                              },
                              items: piCountryCitizenShip.map((String val) {
                                return DropdownMenuItem(
                                  value: val,
                                  child: Text(val,style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,color: Colors.black),),
                                );
                              }).toSet().toList(),
                            )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width / 6.5,
                          child: DropdownButtonFormField<String>( // Specify the type for DropdownButtonFormField
                            decoration: const InputDecoration(
                              hintText: 'State',
                              hintStyle: TextStyle(fontSize: 12),
                            ),
                            value: _piCAState,
                            isExpanded: true,
                            onTap: () {
                              if (_piCACity == null) {
                                setState(() {
                                  getCurrentCities(getAccessToken.access_token);
                                });
                              } else {
                                setState(() {
                                  _piCACity = null;
                                  getCurrentStates(getAccessToken.access_token);
                                });
                              }
                            },
                            onChanged: (state) {
                              if (_piCACity == null) {
                                setState(() {
                                  _piCAState = state;
                                  getCurrentCities(getAccessToken.access_token);
                                });
                              } else {
                                setState(() {
                                  _piCACity = null;
                                  getCurrentStates(getAccessToken.access_token);
                                });
                              }
                            },
                            items: cStatesList?.map((item) {
                              return DropdownMenuItem(
                                value: item['id'].toString(),
                                child: Text(
                                  item['name'],
                                  style: TextStyle(fontFamily: Constants.OPEN_SANS, fontSize: 10),
                                ),
                              );
                            }).toList() ?? [],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width / 6.5,
                          child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                              //border: InputBorder.none,
                              hintText: 'City',
                              hintStyle: TextStyle(fontSize: 12),
                            ),
                            value: _piCACity,
                            isExpanded: true,
                            onChanged: (city) {
                              setState(() {
                                _piCACity = city as String?;
                              });
                            },
                            items: (cCitiesList ?? []).map((item) {
                              return DropdownMenuItem(
                                value: item['id'].toString(),
                                child: Text(
                                  item['name'],
                                  style: TextStyle(fontFamily: Constants.OPEN_SANS, fontSize: 10),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 8,
                          child: TextField(
                            controller: piCAPostCode,
                            decoration: InputDecoration(
                                hintText: 'Postal/Zip Code ',
                                hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 20, 20),
            child: Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () async {
                  if (piFName.text.isNotEmpty || piLName.text.isNotEmpty || piBirthDate.text.isNotEmpty || piPassportNo.text.isNotEmpty || cNameFile == null || piFirstLanguage.text.isNotEmpty || piEmail.text.isNotEmpty || piMobile.text.isNotEmpty || piPAAddress.text.isNotEmpty) {
                    updatePersonalInfo();
                  }
                  else {
                    SnackBarMessageShow.errorMSG('Please Fill Field All', context);
                  }
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
          )
        ],
      ),
    );
  }

  List<Map<String, dynamic>>? cStatesList;
  List<Map<String, dynamic>>? pStatesList;

  Future<void> getCurrentStates(String? accessToken) async {
    final response = await http.post(
      Uri.parse(ApiConstants.getOVFEdit),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: {
        'user_id': widget.user_id,
        'user_sop_id': widget.user_sop_id,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        pStatesList = (data['data']['current_states'] as List<dynamic>?)?.cast<Map<String, dynamic>>();
        cStatesList = pStatesList ?? [];
      });
      print("States List -> $cStatesList");
    } else {

    }
  }

  List? cCitiesList;
  List? pCitiesList;
  Future<String?> getCurrentCities(var accesstoken) async {
    print("Cities Calling");
    await http.post(
      Uri.parse(ApiConstants.getOVFEdit),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accesstoken',
      },
      body: {
        'user_id': widget.user_id,
        'user_sop_id': widget.user_sop_id
      },
    ).then((response) {
      var data = json.decode(response.body);
      setState(() {
        pCitiesList = data['data']['current_cities'];
        cCitiesList = pCitiesList;
      });
      print("Cities List -> $cCitiesList");
    }).catchError((error) {
      // Handle errors here
      print("Error: $error");
    });
  }

  Future<void> updatePersonalInfo() async {
    var otherNm = otherName == 'Yes' ? 1 : 0;
    var changeNm = changeName == 'Yes' ? 1 : 0;
    var gMF = piGender == 'M' ? 1 : 2;
    var paCountry = _piPACountry == 'India' ? 101 : 247;
    var caCountry = _piCACountry == 'India' ? 101 : 247;
    var caBox = piCABox == false ? 0 : 1;
    var mStatus = piMaritalStatus == 'Never Married'
        ? 1
        : piMaritalStatus =='Married'
          ? 2
          : piMaritalStatus =='Divorced'
            ? 3
            : piMaritalStatus =='Separated'
              ? 4
              : 5;
    var medicalS = piMedicalCondition == 'Yes' ? 1 : 0;
    try {
      Dio dio = Dio(BaseOptions(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${getAccessToken.access_token}',
            'Accept': 'application/json',
          }
      ));

      FormData formData = FormData.fromMap({
        'step': 1,
        'user_id': widget.user_id,
        'user_sop_id': widget.user_sop_id,
        'user[first_name]': piFName.text,
        'user[middle_name]': piMName.text,
        'user[last_name]': piLName.text,
        'user[other_name_status]': otherNm.toString(),
        'user[other_name]': piOtherName.text,
        'user[changed_name_status]': changeNm.toString(),

        'user[changed_name]': cNameFile == null ? '' : await MultipartFile.fromFile(cNameFile!.path),

        'user[dob]': piBirthDate.text,
        'user[passport_no]': piPassportNo.text,
        'user[passport_exp_date]': piPassportExpiryDate.text,
        'user[first_language]': piFirstLanguage.text,
        'user[citizen_country_id]': _piCountryOfCitizenShip.toString(),
        'user[gender]': gMF.toString(),
        'user[marital_status]': mStatus.toString(),
        'user[medical_condition_status]': medicalS.toString(),
        'user[medical_condition_note]': piSpecifyMedical.text,
        'user[email_id]': piEmail.text,
        'user[mobile_no]': piMobile.text,
        'user[parent_email_id]': piParentEmail.text,
        'user[phone_no]': piParentMobile.text,

        'user[current_address]': piPAAddress.text,
        'user[current_country_id]': paCountry,
        'user[current_state_id]': _piPAState.toString(),
        'user[current_city_id]': _piPACity.toString(),
        'user[current_zip_code]': piPAPostCode.text,

        'user[same_as_current_address]': piCABox.toString(),

        'user[communication_address]': caBox == 1 ?  piPAAddress.text : piCAAddress.text,
        'user[communication_country_id]': caBox == 1 ? paCountry : caCountry,
        'user[communication_state_id]': caBox == 1 ? _piPAState : _piCAState.toString(),
        'user[communication_city_id]': caBox == 1 ? _piCACity : _piCACity.toString(),
        'user[communication_zip_code]': caBox == 1 ? piPAPostCode.text : piCAPostCode.text,
      });
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
