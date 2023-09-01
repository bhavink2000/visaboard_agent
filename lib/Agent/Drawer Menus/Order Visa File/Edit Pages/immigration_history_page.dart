//@dart=2.9
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


class ImmigrationHistoryPage extends StatefulWidget {
  var pagecontroller;
  OVFEditData editDetails;
  var user_id, user_sop_id;
  var tabStatus,tabName;
  ImmigrationHistoryPage({Key key,this.pagecontroller,this.editDetails,this.user_id,this.user_sop_id,this.tabStatus,this.tabName}) : super(key: key);

  @override
  State<ImmigrationHistoryPage> createState() => _ImmigrationHistoryPageState();
}

class _ImmigrationHistoryPageState extends State<ImmigrationHistoryPage> {

  String applyvisaforanycountry = '';

  String _country;
  String _pApplication;

  int dItems = 1;
  String dTravelled = '';
  List<String> dCountry = [null];
  List<String> dTravel = [null];
  List<TextEditingController> dDate = [TextEditingController()];
  List<TextEditingController> aDate = [TextEditingController()];

  int rItems = 1;
  String visaRefused = '';
  List<String> rCountry = [null];
  List<String> rPTravel = [null];
  List<TextEditingController> rDate = [TextEditingController()];
  List<TextEditingController> rNumber = [TextEditingController()];

  String deniedRemoveDeported = '';
  final dRDSpecify = TextEditingController();

  String visaRevoked = '';
  final visaRSpecify = TextEditingController();

  String polishVerification = '';
  String criminalProceeding = '';
  String criminalOffence = '';

  GetAccessToken getAccessToken = GetAccessToken();
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        getCountryType(getAccessToken.access_token);
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
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Text("Have you ever applied for a visa for any country?",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),)
                ),
                Row(
                  children: [
                    Flexible(
                      child: RadioListTile(
                        title: Text("Yes",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                        value: "Yes",
                        groupValue: applyvisaforanycountry,
                        onChanged: (value){
                          setState(() {
                            applyvisaforanycountry = value.toString();
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: RadioListTile(
                        title: Text("No",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                        value: "No",
                        groupValue: applyvisaforanycountry,
                        onChanged: (value){
                          setState(() {
                            applyvisaforanycountry = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: applyvisaforanycountry == 'Yes' ? true : false,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width / 6.5,
                            child: DropdownButtonFormField(
                              dropdownColor: Colors.white,
                              decoration: const InputDecoration(
                                //border: InputBorder.none,
                                  hintText: 'Name of the country',
                                  hintStyle: TextStyle(fontSize: 10)
                              ),
                              value: _country,
                              style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,color: Colors.black),
                              isExpanded: true,
                              onChanged: (value) {
                                setState(() {
                                  _country = value;
                                });
                              },
                              onSaved: (value) {
                                setState(() {
                                  _country = value;
                                });
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "can't empty";
                                } else {
                                  return null;
                                }
                              },
                              items: countryType?.map((item) {
                                return DropdownMenuItem(
                                  value: item['id'].toString(),
                                  child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)),
                                );
                              })?.toList() ?? [],
                            )
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
                                  hintText: 'Purpose of Application',
                                  hintStyle: TextStyle(fontSize: 10)
                              ),
                              value: _pApplication,
                              style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,color: Colors.black),
                              isExpanded: true,
                              onChanged: (value) {
                                setState(() {
                                  _pApplication = value;
                                });
                              },
                              onSaved: (value) {
                                setState(() {
                                  _pApplication = value;
                                });
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "can't empty";
                                } else {
                                  return null;
                                }
                              },
                              items: application?.map((item) {
                                return DropdownMenuItem(
                                  value: item['id'].toString(),
                                  child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)),
                                );
                              })?.toList() ?? [],
                            )
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Text("Have you travelled out of your home nation in last 10 years?",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),)
                ),
                Row(
                  children: [
                    Flexible(
                      child: RadioListTile(
                        title: Text("Yes",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                        value: "Yes",
                        groupValue: dTravelled,
                        onChanged: (value){
                          setState(() {
                            dTravelled = value.toString();
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: RadioListTile(
                        title: Text("No",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                        value: "No",
                        groupValue: dTravelled,
                        onChanged: (value){
                          setState(() {
                            dTravelled = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: dTravelled == 'Yes' ? true : false,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: InkWell(
                          onTap: (){
                            dDate.add(TextEditingController());
                            aDate.add(TextEditingController());
                            dTravel.add(null);
                            dCountry.add(null);
                            dItems++;
                            setState(() {});
                          },
                          child: Container(
                            color: PrimaryColorOne,
                            padding: const EdgeInsets.all(6),
                            child: Text("Add More +",style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 4,
                        child: ListView.builder(
                          itemCount: dItems,
                          itemBuilder: (context, index){
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.width / 6.5,
                                      child: DropdownButtonFormField(
                                        dropdownColor: Colors.white,
                                        decoration: const InputDecoration(
                                          hintText: 'Name of the country',
                                          hintStyle: TextStyle(fontSize: 10),
                                        ),
                                        value: dCountry[index],
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: Constants.OPEN_SANS,
                                          color: Colors.black,
                                        ),
                                        isExpanded: true,
                                        onChanged: (value) {
                                          setState(() {
                                            dCountry[index] = value;
                                          });
                                        },
                                        onSaved: (value) {
                                          setState(() {
                                            dCountry[index] = value;
                                          });
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Can't be empty";
                                          } else {
                                            return null;
                                          }
                                        },
                                        items: countryType?.map((item) {
                                          return DropdownMenuItem(
                                            value: item['id'].toString(),
                                            child: Text(
                                              item['name'],
                                              style: TextStyle(
                                                fontFamily: Constants.OPEN_SANS,
                                                fontSize: 10,
                                              ),
                                            ),
                                          );
                                        })?.toSet()?.toList() ?? [],
                                      )
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
                                            hintText: 'Purpose of Application',
                                            hintStyle: TextStyle(fontSize: 10)
                                        ),
                                        value: dTravel[index],
                                        style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,color: Colors.black),
                                        isExpanded: true,
                                        onChanged: (value) {
                                          setState(() {
                                            dTravel[index] = value;
                                          });
                                        },
                                        onSaved: (value) {
                                          setState(() {
                                            dTravel[index] = value;
                                          });
                                        },
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "can't empty";
                                          } else {
                                            return null;
                                          }
                                        },
                                        items: application?.map((item) {
                                          return DropdownMenuItem(
                                            value: item['id'].toString(),
                                            child: Text(
                                              item['name'],
                                              style: TextStyle(
                                                fontFamily: Constants.OPEN_SANS,
                                                fontSize: 10,
                                              ),
                                            ),
                                          );
                                        })?.toSet()?.toList() ?? [],
                                      )
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width / 2.8,
                                        height: MediaQuery.of(context).size.width / 6,
                                        child: TextField(
                                          controller: dDate[index],
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                              labelText: "Departure Date"
                                          ),
                                          readOnly: true,
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
                                                dDate[index].text = formattedDate;
                                              });
                                            }else{
                                              Fluttertoast.showToast(msg: "Date is not selected",backgroundColor: Colors.deepPurple,textColor: Colors.white);
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width / 2.8,
                                        height: MediaQuery.of(context).size.width / 6,
                                        child: TextField(
                                          controller: aDate[index],
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                              labelText: "Arrival Date"
                                          ),
                                          readOnly: true,
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
                                                aDate[index].text = formattedDate;
                                              });
                                            }else{
                                              Fluttertoast.showToast(msg: "Date is not selected",backgroundColor: Colors.deepPurple,textColor: Colors.white);
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Text("Has your application for a visa ever been refused for any country?",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),)
                ),
                Row(
                  children: [
                    Flexible(
                      child: RadioListTile(
                        title: Text("Yes",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                        value: "Yes",
                        groupValue: visaRefused,
                        onChanged: (value){
                          setState(() {
                            visaRefused = value.toString();
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: RadioListTile(
                        title: Text("No",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                        value: "No",
                        groupValue: visaRefused,
                        onChanged: (value){
                          setState(() {
                            visaRefused = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: visaRefused == 'Yes' ? true : false,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: InkWell(
                          onTap: (){
                            rDate.add(TextEditingController());
                            rNumber.add(TextEditingController());
                            rPTravel.add(null);
                            rCountry.add(null);
                            rItems++;
                            setState(() {});
                          },
                          child: Container(
                            color: PrimaryColorOne,
                            padding: const EdgeInsets.all(6),
                            child: Text("Add More +",style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 3,
                        child: ListView.builder(
                          itemCount: rItems,
                          itemBuilder: (context, index){
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.width / 6.5,
                                      child: DropdownButtonFormField(
                                        dropdownColor: Colors.white,
                                        decoration: const InputDecoration(
                                          //border: InputBorder.none,
                                            hintText: 'Name of the country',
                                            hintStyle: TextStyle(fontSize: 10)
                                        ),
                                        value: rCountry[index],
                                        style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,color: Colors.black),
                                        isExpanded: true,
                                        onChanged: (value) {
                                          setState(() {
                                            rCountry[index] = value;
                                          });
                                        },
                                        onSaved: (value) {
                                          setState(() {
                                            rCountry[index] = value;
                                          });
                                        },
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "can't empty";
                                          } else {
                                            return null;
                                          }
                                        },
                                        items: countryType?.map((item) {
                                          return DropdownMenuItem(
                                            value: item['id'].toString(),
                                            child: Text(
                                              item['name'],
                                              style: TextStyle(
                                                fontFamily: Constants.OPEN_SANS,
                                                fontSize: 10,
                                              ),
                                            ),
                                          );
                                        })?.toSet()?.toList() ?? [],
                                      )
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.width / 6.5,
                                      child: DropdownButtonFormField(
                                        dropdownColor: Colors.white,
                                        decoration: const InputDecoration(
                                          //border: InputBorder.none,
                                            hintText: 'Purpose of Application',
                                            hintStyle: TextStyle(fontSize: 10)
                                        ),
                                        value: rPTravel[index],
                                        style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,color: Colors.black),
                                        isExpanded: true,
                                        onChanged: (value) {
                                          setState(() {
                                            rPTravel[index] = value;
                                          });
                                        },
                                        onSaved: (value) {
                                          setState(() {
                                            rPTravel[index] = value;
                                          });
                                        },
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "can't empty";
                                          } else {
                                            return null;
                                          }
                                        },
                                        items: application?.map((item) {
                                          return DropdownMenuItem(
                                            value: item['id'].toString(),
                                            child: Text(
                                              item['name'],
                                              style: TextStyle(
                                                fontFamily: Constants.OPEN_SANS,
                                                fontSize: 10,
                                              ),
                                            ),
                                          );
                                        })?.toSet()?.toList() ?? [],
                                      )
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width / 3,
                                        height: MediaQuery.of(context).size.width / 8,
                                        child: TextField(
                                          controller: rDate[index],
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                              labelText: "Refusal Date"
                                          ),
                                          readOnly: true,
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
                                                rDate[index].text = formattedDate;
                                              });
                                            }else{
                                              Fluttertoast.showToast(msg: "Date is not selected",backgroundColor: Colors.deepPurple,textColor: Colors.white);
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(15, 5, 0, 10),
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width / 2.2,
                                        height: MediaQuery.of(context).size.width / 8,
                                        child: TextField(
                                          controller: rNumber[index],
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                              labelText: "Refusal Reference Number"
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Text("Have you ever been denied entry, removed or deported from any country?",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),)
                ),
                Row(
                  children: [
                    Flexible(
                      child: RadioListTile(
                        title: Text("Yes",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                        value: "Yes",
                        groupValue: deniedRemoveDeported,
                        onChanged: (value){
                          setState(() {
                            deniedRemoveDeported = value.toString();
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: RadioListTile(
                        title: Text("No",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                        value: "No",
                        groupValue: deniedRemoveDeported,
                        onChanged: (value){
                          setState(() {
                            deniedRemoveDeported = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: deniedRemoveDeported == 'Yes' ? true : false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1,
                      height: MediaQuery.of(context).size.width / 8,
                      child: TextField(
                        controller: dRDSpecify,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            labelText: "Specify "
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Text("Has your visa ever been cancelled or revoked?",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),)
                ),
                Row(
                  children: [
                    Flexible(
                      child: RadioListTile(
                        title: Text("Yes",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                        value: "Yes",
                        groupValue: visaRevoked,
                        onChanged: (value){
                          setState(() {
                            visaRevoked = value.toString();
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: RadioListTile(
                        title: Text("No",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                        value: "No",
                        groupValue: visaRevoked,
                        onChanged: (value){
                          setState(() {
                            visaRevoked = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: visaRevoked == 'Yes' ? true : false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1,
                      height: MediaQuery.of(context).size.width / 8,
                      child: TextField(
                        controller: visaRSpecify,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            labelText: "Specify "
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Text("Do you hold a Police Verification Certificate (issued within last 6 months)?",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),)
                ),
                Row(
                  children: [
                    Flexible(
                      child: RadioListTile(
                        title: Text("Yes",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                        value: "Yes",
                        groupValue: polishVerification,
                        onChanged: (value){
                          setState(() {
                            polishVerification = value.toString();
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: RadioListTile(
                        title: Text("No",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                        value: "No",
                        groupValue: polishVerification,
                        onChanged: (value){
                          setState(() {
                            polishVerification = value.toString();
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
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Text("Do you have any pending criminal proceedings in any country?",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),)
                ),
                Row(
                  children: [
                    Flexible(
                      child: RadioListTile(
                        title: Text("Yes",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                        value: "Yes",
                        groupValue: criminalProceeding,
                        onChanged: (value){
                          setState(() {
                            criminalProceeding = value.toString();
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: RadioListTile(
                        title: Text("No",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                        value: "No",
                        groupValue: criminalProceeding,
                        onChanged: (value){
                          setState(() {
                            criminalProceeding = value.toString();
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
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Text("Have you ever been convicted of a criminal offence in any country?",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),)
                ),
                Row(
                  children: [
                    Flexible(
                      child: RadioListTile(
                        title: Text("Yes",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                        value: "Yes",
                        groupValue: criminalOffence,
                        onChanged: (value){
                          setState(() {
                            criminalOffence = value.toString();
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: RadioListTile(
                        title: Text("No",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                        value: "No",
                        groupValue: criminalOffence,
                        onChanged: (value){
                          setState(() {
                            criminalOffence = value.toString();
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
                      updateImmigration();
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

  List countryType;
  List application;
  Future<String> getCountryType(var accesstoken) async {
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
        countryType = data['data']['countries'];
        application = data['data']['application'];
      });
      print("Education List -> $countryType");
    });
  }

  Future<void> updateImmigration() async {
    var cvaStatus = applyvisaforanycountry == 'Yes' ? 1 : 0;
    var dTrave = dTravelled == 'Yes' ? 1 : 0;
    var vRefu = visaRefused == 'Yes' ? 1 : 0;
    var dRevo = deniedRemoveDeported == 'Yes' ? 1 : 0;
    var vRevo = visaRevoked == 'Yes' ? 1 : 0;

    var pVerify = polishVerification == 'Yes' ? 1 : 0;
    var pCrimnal = criminalProceeding == 'Yes' ? 1 : 0;
    var cCriminal = criminalOffence == 'Yes' ? 1 : 0;
    try {
      Dio dio = Dio(BaseOptions(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${getAccessToken.access_token}',
            'Accept': 'application/json',
          }
      ));

      FormData formData = FormData.fromMap({
        'step': 8,
        'user_id': widget.user_id,
        'user_sop_id': widget.user_sop_id,
        'user[immigration_history_flag]': '1',
        'user[country_visa_applied_status]': cvaStatus.toString(),
        'user[visa_applied_country_id]': _country.toString(),
        'user[visa_applied_application]': _pApplication.toString(),
        'user[travelled_history_status]': dTrave.toString(),
        'user[country_visa_refused_status]': vRefu.toString(),
        'user[denied_country_entry_status]': dRevo.toString(),
        'user[denied_country_entry_note]': dRDSpecify.text,
        'user[applied_visa_cancelled_status]': vRevo.toString(),
        'user[applied_visa_cancelled_note]': visaRSpecify.text,
        'user[police_verify_certificate_status]': pVerify.toString(),
        'user[pending_criminal_status]': pCrimnal.toString(),
        'user[convicted_criminal_status]': cCriminal.toString(),
      });
      for(int i = 0; i < dDate.length; i++) {
        formData.fields.addAll([
          MapEntry('user_travelled_history[$i][country_id]', dCountry[i].toString()),
          MapEntry('user_travelled_history[$i][travelled_application]', dTravel[i].toString()),
          MapEntry('user_travelled_history[$i][departure_date]', dDate[i].text),
          MapEntry('user_travelled_history[$i][arrival_date]', aDate[i].text),
        ]);
      }

      for(int i = 0; i < rDate.length; i++) {
        formData.fields.addAll([
          MapEntry('user_refused_visa[$i][country_id]', rCountry[i].toString()),
          MapEntry('user_refused_visa[$i][travelled_application]', rPTravel[i].toString()),
          MapEntry('user_refused_visa[$i][refusal_date]', rDate[i].text),
          MapEntry('user_refused_visa[$i][refusal_ref_no]', rNumber[i].text),
        ]);
      }

      print("---------------------------------------");
      print("Form Data->${formData.fields}");
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
