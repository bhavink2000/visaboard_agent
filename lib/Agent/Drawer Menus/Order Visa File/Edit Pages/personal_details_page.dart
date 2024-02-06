// ignore_for_file: use_build_context_synchronously, must_be_immutable, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Models/Drawer%20Menus%20Model/order_visafile_edit_model.dart';
import 'package:visaboard_agent/Agent/Drawer%20Menus/Order%20Visa%20File/Form_Controller/personal_details_controller.dart';
import 'package:visaboard_agent/Agent/Drawer%20Menus/Order%20Visa%20File/Ovf%20Widgets/edit_screen_textfield.dart';
import 'package:visaboard_agent/Agent/Drawer%20Menus/Order%20Visa%20File/Ovf%20Widgets/edits_screens_header.dart';
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

  final pdController = Get.put(PersonalDController());

  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);

    final pdController = Get.put(PersonalDController(pageController: widget.pagecontroller,context: context));

    if (widget.editDetails!.user != null) {
      pdController.piFName.text = widget.editDetails!.user!.firstName ?? '';
      pdController.piMName.text = widget.editDetails!.user!.middleName ?? '';
      pdController.piLName.text = widget.editDetails!.user!.lastName ?? '';
      pdController.piEmail.text = widget.editDetails!.user!.emailId ?? '';
      pdController.piMobile.text = widget.editDetails!.user!.mobileNo ?? '';
      pdController.piBirthDate.text = widget.editDetails!.user!.dob ?? '';
      pdController.piPassportNo.text = widget.editDetails!.user!.passportNo ?? '';
      pdController.piPassportExpiryDate.text = widget.editDetails!.user!.passportExpDate ?? '';
      pdController.piFirstLanguage.text = widget.editDetails!.user!.firstLanguage ?? '';
      pdController.piPaAddress.text = widget.editDetails!.user!.communicationAddress ?? '';
      pdController.piPaPostCode.text = widget.editDetails!.user!.communicationZipCode ?? '';
      pdController.piCaAddress.text = widget.editDetails!.user!.currentAddress ?? '';
      pdController.piCAPostCode.text = widget.editDetails!.user!.currentZipCode ?? '';
    } else {
      // Handle the case where widget.editDetails!.user is null.
      // You can set default values or handle it as needed.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      children: [
        EditScreenHeader(
          tabName: widget.tabName,
          tabIndex: 1,
          tabStatus: widget.tabStatus,
          tabMessage: widget.editDetails?.message,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Form(
              key: pdController.personalDetailsFormKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                    child: Align(alignment: Alignment.topLeft,child: Text("Personal Information",style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold),)),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                    child: Align(alignment: Alignment.topLeft,child: Text("(As indicated on your passport)",style: TextStyle(fontSize: 10))),
                  ),
                  EditSTextField(
                    controller: pdController.piFName,
                    labelName: 'Given Name/s (exactly as on your passport) *',
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return 'this field is required';
                      }
                      return null;
                    },
                  ),
                  EditSTextField(
                    controller: pdController.piMName,
                    labelName: 'Middle name *',
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return 'this field is required';
                      }
                      return null;
                    },
                  ),
                  EditSTextField(
                    controller: pdController.piLName,
                    labelName: 'Family Name (exactly as on your passport) *',
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return 'this field is required';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
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
                                groupValue: pdController.otherName.value,
                                onChanged: (value){
                                  pdController.otherName.value = value.toString();
                                  pdController.otherNm.value = pdController.otherName.value == 'Yes' ? true : false;
                                },
                              ),
                            ),
                            Flexible(
                              child: RadioListTile(
                                title: Text("No",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 0.5,fontSize: 10),),
                                value: "No",
                                groupValue: pdController.otherName.value,
                                onChanged: (value){
                                  pdController.otherName.value = value.toString();
                                  pdController.otherNm.value = pdController.otherName.value == 'No' ? false : true;
                                },
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                            visible: pdController.otherNm.value,
                            child: EditSTextField(
                              controller: pdController.piOtherName,
                              labelName: 'Other name',
                            )
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
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
                                groupValue: pdController.changeName.value,
                                onChanged: (value){
                                  setState(() {
                                    pdController.changeName.value = value.toString();
                                    pdController.changeNm.value = pdController.changeName.value == 'Yes' ? true : false;
                                  });
                                },
                              ),
                            ),
                            Flexible(
                              child: RadioListTile(
                                title: Text("No",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 0.5,fontSize: 10),),
                                value: "No",
                                groupValue: pdController.changeName.value,
                                onChanged: (value){
                                  setState(() {
                                    pdController.changeName.value = value.toString();
                                    pdController.changeNm.value = pdController.changeName.value == 'No' ? false : true;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: pdController.changeNm.value,
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
                                              pdController.changeNmFile = File(pickedfile.files.single.path!);
                                            });
                                          }
                                        }
                                        on PlatformException catch (e) {
                                          print(" File not Picked ");
                                        }
                                      },
                                      child: pdController.changeNmFile == null
                                          ? const Text("Choose File",style: TextStyle(color: Colors.white))
                                          : const Text("File Picked",style: TextStyle(color: Colors.white))
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: pdController.changeNmFile == null ? const Text("No File Chosen",style: TextStyle(fontSize: 12),) : Expanded(child: Text(pdController.changeNmFile!.path.split('/').last,style: const TextStyle(fontSize: 9),))
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  EditSTextField(
                    controller: pdController.piPassportNo,
                    labelName: 'Passport number *',
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return 'this field is required';
                      }
                      return null;
                    },
                  ),
                  EditSTextField(
                    controller: pdController.piFirstLanguage,
                    labelName: 'First language *',
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return 'this field is required';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: Row(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            //height: MediaQuery.of(context).size.width / 7.5,
                            child: DropdownButtonFormField(
                              dropdownColor: Colors.white,
                              decoration: editFormsInputDecoration('Country of citizenship'),
                              value: pdController.piCountryOfCitizenShip.value.isNotEmpty
                                  ? pdController.piCountryOfCitizenShip.value
                                  : 'India',
                              style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,color: Colors.black),
                              isExpanded: true,
                              onChanged: (String? value) {
                                pdController.piCountryOfCitizenShip.value = value.toString();
                                pdController.selectedCountry = pdController.piCountryOfCitizenShip.value == 'India' ? 101 : 247;
                              },
                              validator: (value) {
                                if (value == null) {
                                  return "can't empty";
                                } else {
                                  return null;
                                }
                              },
                              items: pdController.piCountryCitizenShip.map((String? val) {
                                return DropdownMenuItem(
                                  value: val.toString(),
                                  child: Text(val.toString(),style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,color: Colors.black),),
                                );
                              }).toList(),
                            )
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                //height: MediaQuery.of(context).size.width / 8,
                                child: EditSTextField(
                                  controller: pdController.piPassportExpiryDate,
                                  labelName: 'Password expiry date',
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
                                        pdController.piPassportExpiryDate.text = formattedDate;
                                      });
                                    }else{
                                      Fluttertoast.showToast(msg: "Date is not selected",backgroundColor: Colors.deepPurple,textColor: Colors.white);
                                    }
                                  },
                                )
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
                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                          child: EditSTextField(
                            controller: pdController.piBirthDate,
                            labelName: 'Date of birth *',
                            readOnly: true,
                            onTap: ()async{
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1947),
                                  lastDate: DateTime.now()
                              );
                              if(pickedDate != null){
                                String formatDate = DateFormat('yyyy-MM-DD').format(pickedDate);
                                pdController.piBirthDate.text = formatDate;
                              }
                              else{
                                Fluttertoast.showToast(msg: "Date is not selected",backgroundColor: Colors.deepPurple,textColor: Colors.white);
                              }
                            },
                            validator: (value){
                              if (value == null || value.isEmpty) {
                                return 'this field is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Gender *",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),)
                              ),
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: RadioListTile(
                                    title: Text("M",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                                    value: "M",
                                    groupValue: pdController.piGender.value,
                                    contentPadding: EdgeInsets.zero,
                                    onChanged: (value){
                                      pdController.piGender.value = value.toString();
                                    },
                                  ),
                                ),
                                Flexible(
                                  child: RadioListTile(
                                    title: Text("F",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                                    value: "F",
                                    groupValue: pdController.piGender.value,
                                    contentPadding: EdgeInsets.zero,
                                    onChanged: (value){
                                      pdController.piGender.value = value.toString();
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
                                groupValue: pdController.piMaritalStatus.value,
                                onChanged: (value){
                                  pdController.piMaritalStatus.value = value.toString();
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
                                groupValue: pdController.piMaritalStatus.value,
                                onChanged: (value){
                                  pdController.piMaritalStatus.value = value.toString();
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
                                groupValue: pdController.piMaritalStatus.value,
                                onChanged: (value){
                                  pdController.piMaritalStatus.value = value.toString();
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
                              groupValue: pdController.piMaritalStatus.value,
                              onChanged: (value){

                                pdController.piMaritalStatus.value = value.toString();

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
                              groupValue: pdController.piMaritalStatus.value,
                              onChanged: (value){

                                pdController.piMaritalStatus.value = value.toString();

                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                    child: Align(alignment: Alignment.topLeft,child: Text("Address Detail",style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold),)),
                  ),
                  EditSTextField(
                    controller: pdController.piEmail,
                    labelName: 'Email',
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return 'this field is required';
                      }
                      return null;
                    },
                  ),
                  EditSTextField(
                      controller: pdController.piMobile,
                      labelName: 'Mobile number'
                  ),
                  EditSTextField(
                      controller: pdController.piParentEmail,
                      labelName: 'Parent email address'
                  ),
                  EditSTextField(
                      controller: pdController.piParentMobile,
                      labelName: 'Alternate no.'
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 0, 5),
                    child: Align(alignment: Alignment.topLeft,child: Text("Present address",style: TextStyle(fontSize: 12))),
                  ),
                  EditSTextField(
                      controller: pdController.piPaAddress,
                      labelName: 'Address'
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width / 6.5,
                        child: DropdownButtonFormField(
                          dropdownColor: Colors.white,
                          decoration: editFormsInputDecoration('Country'),
                          value: pdController.piPaCountry,
                          style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,color: Colors.black),
                          isExpanded: true,
                          onChanged: (value) {
                              pdController.piPaCountry = value;
                              if(pdController.piPaCountry == 'India'){
                                pdController.getCurrentStates(getAccessToken.access_token,widget.user_id,widget.user_sop_id);
                                //getCurrentCities(getAccessToken.access_token);
                              }
                              else{
                                pdController.pStatesList!.clear();
                                pdController.pCitiesList!.clear();
                                pdController.getCurrentStates(getAccessToken.access_token,widget.user_id,widget.user_sop_id);
                              }
                          },
                          validator: (value) {
                            if (value == null) {
                              return "can't empty";
                            } else {
                              return null;
                            }
                          },
                          items: pdController.piCountryCitizenShip.map((String val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(val,style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,color: Colors.black),),
                            );
                          }).toList(),
                        )
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width / 6.5,
                        child: DropdownButtonFormField(
                          decoration: editFormsInputDecoration('State'),
                          value: pdController.piPaState,
                          isExpanded: true,
                          onTap: (){
                            if(pdController.piPaCity.value == null){
                                if(pdController.piPaCountry == 'India'){
                                  pdController.getCurrentCities(getAccessToken.access_token,widget.user_id,widget.user_sop_id);
                                }
                            }
                            else{
                                pdController.piPaCity.value = '';
                                pdController.getCurrentStates(getAccessToken.access_token,widget.user_id,widget.user_sop_id);
                            }
                          },
                          onChanged: (state) {
                            if(pdController.piPaCity.value == null){
                                pdController.piPaState.value = (state as String?)!;
                                pdController.getCurrentCities(getAccessToken.access_token,widget.user_id,widget.user_sop_id);
                            }
                            else{
                              pdController.piPaCity.value = '';
                              pdController.getCurrentStates(getAccessToken.access_token,widget.user_id,widget.user_sop_id);
                            }
                          },
                          items: pdController.cStatesList?.map((item) {
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
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width / 6.5,
                        child: DropdownButtonFormField(
                          decoration: editFormsInputDecoration('City'),
                          value: pdController.piPaCity,
                          isExpanded: true,
                          onChanged: (city) {
                            pdController.piPaCity.value = (city as String?)!;
                          },
                          items: (pdController.cCitiesList ?? []).map((item) {
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
                  EditSTextField(
                      controller: pdController.piPaPostCode,
                      labelName: 'Postal/Zip code'
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 0, 5),
                    child: Row(
                      children: [
                        const Align(alignment: Alignment.topLeft,child: Text("Communication address",style: TextStyle(fontSize: 12))),
                        Flexible(
                          child: Checkbox(
                            checkColor: Colors.white,
                            value: pdController.piCdCheckBox.value,
                            onChanged: (bool? value) {
                              setState(() {
                                pdController.piCdCheckBox.value = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  EditSTextField(controller: pdController.piCaAddress, labelName: 'Address'),
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  //   child: SizedBox(
                  //       width: MediaQuery.of(context).size.width,
                  //       height: MediaQuery.of(context).size.width / 6.5,
                  //       child: DropdownButtonFormField(
                  //         dropdownColor: Colors.white,
                  //         decoration: editFormsInputDecoration('Country'),
                  //         value: pdController.piCaCountry,
                  //         style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,color: Colors.black),
                  //         isExpanded: true,
                  //         onChanged: (value) {
                  //           pdController.piCaCountry = value;
                  //             if(pdController.piCaCountry == 'India'){
                  //               pdController.getCurrentStates(getAccessToken.access_token,widget.user_id,widget.user_sop_id);
                  //               //getCurrentCities(getAccessToken.access_token);
                  //             }
                  //             else{
                  //               pdController.cStatesList!.clear();
                  //               pdController.cCitiesList!.clear();
                  //             }
                  //         },
                  //         validator: (value) {
                  //           if (value == null) {
                  //             return "can't empty";
                  //           } else {
                  //             return null;
                  //           }
                  //         },
                  //         items: pdController.piCountryCitizenShip.map((String val) {
                  //           return DropdownMenuItem(
                  //             value: val,
                  //             child: Text(val,style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,color: Colors.black),),
                  //           );
                  //         }).toSet().toList(),
                  //       )
                  //   ),
                  // ),

                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  //   child: SizedBox(
                  //     width: MediaQuery.of(context).size.width,
                  //     height: MediaQuery.of(context).size.width / 6.5,
                  //     child: DropdownButtonFormField<String>( // Specify the type for DropdownButtonFormField
                  //       decoration: editFormsInputDecoration('State'),
                  //       value: pdController.piCaState.value,
                  //       isExpanded: true,
                  //       onTap: () {
                  //         if (pdController.piCaCity.value == null) {
                  //           pdController.getCurrentCities(getAccessToken.access_token,widget.user_id,widget.user_sop_id);
                  //         } else {
                  //             pdController.piCaCity.value = '';
                  //             pdController.getCurrentStates(getAccessToken.access_token,widget.user_id,widget.user_sop_id);
                  //         }
                  //       },
                  //       onChanged: (state) {
                  //         if (pdController.piCaCity.value == null) {
                  //             pdController.piCaState.value = state.toString();
                  //             pdController.getCurrentCities(getAccessToken.access_token,widget.user_id,widget.user_sop_id);
                  //         } else {
                  //             pdController.piCaCity.value = '';
                  //             pdController.getCurrentStates(getAccessToken.access_token,widget.user_id,widget.user_sop_id);
                  //         }
                  //       },
                  //       items: pdController.cStatesList?.map((item) {
                  //         return DropdownMenuItem(
                  //           value: item['id'].toString(),
                  //           child: Text(
                  //             item['name'],
                  //             style: TextStyle(fontFamily: Constants.OPEN_SANS, fontSize: 10),
                  //           ),
                  //         );
                  //       }).toList() ?? [],
                  //     ),
                  //   ),
                  // ),

                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  //   child: SizedBox(
                  //     width: MediaQuery.of(context).size.width,
                  //     child: DropdownButtonFormField(
                  //       decoration: editFormsInputDecoration('City'),
                  //       value: pdController.piCaCity.value,
                  //       isExpanded: true,
                  //       onChanged: (city) {
                  //         setState(() {
                  //           pdController.piCaCity.value = city.toString();
                  //         });
                  //       },
                  //       items: (pdController.cCitiesList ?? []).map((item) {
                  //         return DropdownMenuItem(
                  //           value: item['id'].toString(),
                  //           child: Text(
                  //             item['name'],
                  //             style: TextStyle(fontFamily: Constants.OPEN_SANS, fontSize: 10),
                  //           ),
                  //         );
                  //       }).toList(),
                  //     ),
                  //   ),
                  // ),
                  EditSTextField(
                      controller: pdController.piCAPostCode,
                      labelName: 'Postal/Zip code'
                  ),
                ],
              ),
            ),
          ),
        ),
        BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: (){

                  },
                  icon: Icon(Icons.arrow_back)
              ),
              IconButton(
                  onPressed: ()async{
                    if(pdController.personalDetailsFormKey.currentState!.validate()){
                      pdController.updatePersonalInfo(getAccessToken.access_token, widget.user_id, widget.user_sop_id);
                    }
                  },
                  icon: Icon(Icons.arrow_back)
              ),
            ],
          ),
        ),

        // Padding(
        //   padding: const EdgeInsets.fromLTRB(10, 5, 20, 20),
        //   child: Align(
        //     alignment: Alignment.topRight,
        //     child: InkWell(
        //       onTap: () async {
        //         if (piFName.text.isNotEmpty || piLName.text.isNotEmpty || piBirthDate.text.isNotEmpty || piPassportNo.text.isNotEmpty || cNameFile == null || piFirstLanguage.text.isNotEmpty || piEmail.text.isNotEmpty || piMobile.text.isNotEmpty || piPAAddress.text.isNotEmpty) {
        //           updatePersonalInfo();
        //         }
        //         else {
        //           SnackBarMessageShow.errorMSG('Please Fill Field All', context);
        //         }
        //       },
        //       child: Container(
        //         padding: const EdgeInsets.all(8.0),
        //         decoration: BoxDecoration(
        //           color: PrimaryColorOne,
        //           borderRadius: const BorderRadius.all(Radius.circular(10)),
        //         ),
        //         child: Text(
        //           widget.tabStatus == 1 ? "Submit" : "Next",
        //           style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: Constants.OPEN_SANS),
        //           textAlign: TextAlign.center,
        //         ),
        //       ),
        //     ),
        //   ),
        // )
      ],
    ));
  }



  // Future<void> updatePersonalInfo() async {
  //   var otherNm = otherName == 'Yes' ? 1 : 0;
  //   var changeNm = changeName == 'Yes' ? 1 : 0;
  //   var gMF = piGender == 'M' ? 1 : 2;
  //   var paCountry = _piPACountry == 'India' ? 101 : 247;
  //   var caCountry = _piCACountry == 'India' ? 101 : 247;
  //   var caBox = piCABox == false ? 0 : 1;
  //   var mStatus = piMaritalStatus == 'Never Married'
  //       ? 1
  //       : piMaritalStatus =='Married'
  //         ? 2
  //         : piMaritalStatus =='Divorced'
  //           ? 3
  //           : piMaritalStatus =='Separated'
  //             ? 4
  //             : 5;
  //   var medicalS = piMedicalCondition == 'Yes' ? 1 : 0;
  //   try {
  //     Dio dio = Dio(BaseOptions(
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Authorization': 'Bearer ${getAccessToken.access_token}',
  //           'Accept': 'application/json',
  //         }
  //     ));
  //
  //     FormData formData = FormData.fromMap({
  //       'step': 1,
  //       'user_id': widget.user_id,
  //       'user_sop_id': widget.user_sop_id,
  //       'user[first_name]': piFName.text,
  //       'user[middle_name]': piMName.text,
  //       'user[last_name]': piLName.text,
  //       'user[other_name_status]': otherNm.toString(),
  //       'user[other_name]': piOtherName.text,
  //       'user[changed_name_status]': changeNm.toString(),
  //
  //       'user[changed_name]': cNameFile == null ? '' : await MultipartFile.fromFile(cNameFile!.path),
  //
  //       'user[dob]': piBirthDate.text,
  //       'user[passport_no]': piPassportNo.text,
  //       'user[passport_exp_date]': piPassportExpiryDate.text,
  //       'user[first_language]': piFirstLanguage.text,
  //       'user[citizen_country_id]': _piCountryOfCitizenShip.toString(),
  //       'user[gender]': gMF.toString(),
  //       'user[marital_status]': mStatus.toString(),
  //       'user[medical_condition_status]': medicalS.toString(),
  //       'user[medical_condition_note]': piSpecifyMedical.text,
  //       'user[email_id]': piEmail.text,
  //       'user[mobile_no]': piMobile.text,
  //       'user[parent_email_id]': piParentEmail.text,
  //       'user[phone_no]': piParentMobile.text,
  //
  //       'user[current_address]': piPAAddress.text,
  //       'user[current_country_id]': paCountry,
  //       'user[current_state_id]': _piPAState.toString(),
  //       'user[current_city_id]': _piPACity.toString(),
  //       'user[current_zip_code]': piPAPostCode.text,
  //
  //       'user[same_as_current_address]': piCABox.toString(),
  //
  //       'user[communication_address]': caBox == 1 ?  piPAAddress.text : piCAAddress.text,
  //       'user[communication_country_id]': caBox == 1 ? paCountry : caCountry,
  //       'user[communication_state_id]': caBox == 1 ? _piPAState : _piCAState.toString(),
  //       'user[communication_city_id]': caBox == 1 ? _piCACity : _piCACity.toString(),
  //       'user[communication_zip_code]': caBox == 1 ? piPAPostCode.text : piCAPostCode.text,
  //     });
  //     final response = await dio.post(
  //         ApiConstants.getOVFUpdate,
  //         data: formData,
  //         onSendProgress: (int sent, int total) {
  //           print('$sent $total');
  //         }
  //     );
  //     print("response code ->${response.statusCode}");
  //     print("response Message ->${response.statusMessage}");
  //     if (response.statusCode == 200) {
  //       var jsonResponse = response.data;
  //       var status = jsonResponse['status'];
  //       var message = jsonResponse['message'];
  //
  //       print("Status -> $status");
  //       print("Message -> $message");
  //
  //       if (status == 200) {
  //         SnackBarMessageShow.successsMSG('$message', context);
  //         widget.pagecontroller.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
  //       } else {
  //         SnackBarMessageShow.errorMSG('$message', context);
  //         Navigator.pop(context);
  //       }
  //     } else {
  //       SnackBarMessageShow.errorMSG('Something went wrong', context);
  //       Navigator.pop(context);
  //     }
  //   } catch (error) {
  //     SnackBarMessageShow.errorMSG('Something went wrong', context);
  //     Navigator.pop(context);
  //   }
  // }

}
