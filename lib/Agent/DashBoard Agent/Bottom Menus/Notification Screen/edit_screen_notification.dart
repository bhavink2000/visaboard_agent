//@dart=2.9
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../../App Helper/Api Repository/api_urls.dart';
import '../../../App Helper/Ui Helper/ui_helper.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';


class EditNotification extends StatefulWidget {
  const EditNotification({Key key}) : super(key: key);

  @override
  State<EditNotification> createState() => _EditNotification();
}

class _EditNotification extends State<EditNotification> {
  TextEditingController birthdate = TextEditingController();
  String _selectedvaluecountry;
  List<String> listOfcountry = ['India', 'Other Country'];

  String _selectedState;
  String _selectedCity;

  String othername = '';
  String yourname = '';
  String maritalstatus = '';
  String medicalstatus = '';
  String gender = '';
  String sameasabove = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back)
                    ),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("Personal Details",
                          style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 18,letterSpacing: 1),
                        )
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.white,
                        boxShadow: [BoxShadow(color: Colors.black45.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)]
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("You have submitted request for Visa File SOP, Canada, on Date: December 7th, 2022 12:46 PM.",style: TextStyle(fontSize: 13,fontFamily: Constants.OPEN_SANS,color: Colors.green),),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: persoalDetails(),
            )
          ],
        ),
      ),
    );
  }

  Widget persoalDetails(){
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 0, 5),
                child: Align(alignment: Alignment.topLeft,child: Text("Personal Details",style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold),)),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                child: Align(alignment: Alignment.topLeft,child: Text("(As indicated on your passwort)",style: TextStyle(fontSize: 10))),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width / 8,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Given Names (exactly as on your passport) *',
                            hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width / 8,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Middle Name *',
                            hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width / 8,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Family Name (exactly as on your passport)*',
                            hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                                  groupValue: othername,
                                  onChanged: (value){
                                    setState(() {
                                      othername = value.toString();
                                    });
                                  },
                                ),
                              ),
                              Flexible(
                                child: RadioListTile(
                                  title: Text("No",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 0.5,fontSize: 10),),
                                  value: "No",
                                  groupValue: othername,
                                  onChanged: (value){
                                    setState(() {
                                      othername = value.toString();
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
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                                  groupValue: yourname,
                                  onChanged: (value){
                                    setState(() {
                                      yourname = value.toString();
                                    });
                                  },
                                ),
                              ),
                              Flexible(
                                child: RadioListTile(
                                  title: Text("No",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 0.5,fontSize: 10),),
                                  value: "No",
                                  groupValue: yourname,
                                  onChanged: (value){
                                    setState(() {
                                      yourname = value.toString();
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
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width / 8,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Passport Number * ',
                            hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width / 8,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Passport Expiry Date*',
                            hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width / 8,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'First language *',
                            hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width / 6.5,
                        child: DropdownButtonFormField(
                          dropdownColor: Colors.white,
                          decoration: InputDecoration(
                            //border: InputBorder.none,
                              hintText: 'Country of citizenship',
                              hintStyle: TextStyle(fontSize: 10)
                          ),
                          value: _selectedvaluecountry,
                          style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,color: Colors.black),
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              _selectedvaluecountry = value;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              _selectedvaluecountry = value;
                            });
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "can't empty";
                            } else {
                              return null;
                            }
                          },
                          items: listOfcountry.map((String val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(val,style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,color: Colors.black),),
                            );
                          }).toList(),
                        )
                    ),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 2.8,
                            height: MediaQuery.of(context).size.width / 6,
                            child: TextField(
                              controller: birthdate,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  labelText: "Date of birth *"
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
                                    birthdate.text = formattedDate;
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
                                    groupValue: gender,
                                    onChanged: (value){
                                      setState(() {
                                        gender = value.toString();
                                      });
                                    },
                                  ),
                                ),
                                Flexible(
                                  child: RadioListTile(
                                    title: Text("F",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                                    value: "F",
                                    groupValue: gender,
                                    onChanged: (value){
                                      setState(() {
                                        gender = value.toString();
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
                ],
              ),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                                  contentPadding: EdgeInsets.all(1),
                                  title: Text("Married",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10),),
                                  value: "Married",
                                  groupValue: maritalstatus,
                                  onChanged: (value){
                                    setState(() {
                                      maritalstatus = value.toString();
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3.2,
                                height: MediaQuery.of(context).size.height / 20,
                                child: RadioListTile(
                                  contentPadding: EdgeInsets.all(1),
                                  title: Text("Divorced",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10),),
                                  value: "Divorced",
                                  groupValue: maritalstatus,
                                  onChanged: (value){
                                    setState(() {
                                      maritalstatus = value.toString();
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3.2,
                                height: MediaQuery.of(context).size.height / 20,
                                child: RadioListTile(
                                  contentPadding: EdgeInsets.all(1),
                                  title: Text("Separated",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10),),
                                  value: "Separated",
                                  groupValue: maritalstatus,
                                  onChanged: (value){
                                    setState(() {
                                      maritalstatus = value.toString();
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
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 20,
                        child: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 20,
                              child: RadioListTile(
                                contentPadding: EdgeInsets.all(1),
                                title: Text("Never Married",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10),),
                                value: "Never Married",
                                groupValue: maritalstatus,
                                onChanged: (value){
                                  setState(() {
                                    maritalstatus = value.toString();
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 3.1,
                              height: MediaQuery.of(context).size.height / 20,
                              child: RadioListTile(
                                contentPadding: EdgeInsets.all(1),
                                title: Text("Betrothed",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10),),
                                value: "Betrothed",
                                groupValue: maritalstatus,
                                onChanged: (value){
                                  setState(() {
                                    maritalstatus = value.toString();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 5),
                  child: Align(alignment: Alignment.topLeft,child: Text("Address Detail",style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold),)),
                ),
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 8,
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 8,
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: 'Phone number ',
                                hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 8,
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: 'Parents email address',
                                hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 8,
                          child: TextField(
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
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 0, 5),
                        child: Align(alignment: Alignment.topLeft,child: Text("Present address",style: TextStyle(fontSize: 12))),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 8,
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: 'Address ',
                                hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width / 6.5,
                            child: DropdownButtonFormField(
                              dropdownColor: Colors.white,
                              decoration: InputDecoration(
                                //border: InputBorder.none,
                                  hintText: 'Country',
                                  hintStyle: TextStyle(fontSize: 10)
                              ),
                              value: _selectedvaluecountry,
                              style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,color: Colors.black),
                              isExpanded: true,
                              onChanged: (value) {
                                setState(() {
                                  _selectedvaluecountry = value;
                                });
                              },
                              onSaved: (value) {
                                setState(() {
                                  _selectedvaluecountry = value;
                                });
                              },
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "can't empty";
                                } else {
                                  return null;
                                }
                              },
                              items: listOfcountry.map((String val) {
                                return DropdownMenuItem(
                                  value: val,
                                  child: Text(val,style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,color: Colors.black),),
                                );
                              }).toList(),
                            )
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width / 6.5,
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              //border: InputBorder.none,
                                hintText: 'State',
                                hintStyle: TextStyle(fontSize: 12)
                            ),
                            value: _selectedState,
                            isExpanded: true,
                            onTap: (){
                              /*if(_selectedCity == null){
                                                setState(() {
                                                  _getCityList(access_token,token_type,_selectedCountry,_selectedState);
                                                });
                                              }
                                              else{
                                                setState(() {
                                                  _selectedCity = null;
                                                  _getStateList(access_token, token_type, _selectedCountry);
                                                });
                                              }*/
                            },
                            onChanged: (state) {
                              /*if(_selectedCity == null){
                                                setState(() {
                                                  _selectedState = state;
                                                  _getCityList(access_token,token_type,_selectedCountry,_selectedState);
                                                });
                                              }
                                              else{
                                                setState(() {
                                                  _selectedCity = null;
                                                  _getStateList(access_token,token_type,_selectedCountry);
                                                });
                                              }*/
                            },
                            items: stateList?.map((item) {
                              return DropdownMenuItem(
                                value: item['id'].toString(),
                                child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)),
                              );
                            })?.toList() ?? [],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width / 6.5,
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              //border: InputBorder.none,
                                hintText: 'City',
                                hintStyle: TextStyle(fontSize: 12)
                            ),
                            value: _selectedCity,
                            isExpanded: true,
                            onChanged: (city) {
                              /*setState(() {
                                                _selectedCity = city;
                                              });*/
                            },
                            items: cityList?.map((item) {
                              return DropdownMenuItem(
                                value: item['id'].toString(),
                                child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10),),
                              );
                            })?.toList() ?? [],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 8,
                          child: TextField(
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
                        padding: EdgeInsets.fromLTRB(20, 10, 0, 5),
                        child: Row(
                          children: [
                            Align(alignment: Alignment.topLeft,child: Text("Communication address",style: TextStyle(fontSize: 12))),
                            Flexible(
                              child: RadioListTile(
                                contentPadding: EdgeInsets.all(1),
                                title: Text("Same as Above",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 11),),
                                value: "yes",
                                groupValue: sameasabove,
                                onChanged: (value){
                                  setState(() {
                                    sameasabove = value.toString();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 8,
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: 'Address ',
                                hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width / 6.5,
                            child: DropdownButtonFormField(
                              dropdownColor: Colors.white,
                              decoration: InputDecoration(
                                //border: InputBorder.none,
                                  hintText: 'Country',
                                  hintStyle: TextStyle(fontSize: 10)
                              ),
                              value: _selectedvaluecountry,
                              style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,color: Colors.black),
                              isExpanded: true,
                              onChanged: (value) {
                                setState(() {
                                  _selectedvaluecountry = value;
                                });
                              },
                              onSaved: (value) {
                                setState(() {
                                  _selectedvaluecountry = value;
                                });
                              },
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "can't empty";
                                } else {
                                  return null;
                                }
                              },
                              items: listOfcountry.map((String val) {
                                return DropdownMenuItem(
                                  value: val,
                                  child: Text(val,style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,color: Colors.black),),
                                );
                              }).toList(),
                            )
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width / 6.5,
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              //border: InputBorder.none,
                                hintText: 'State',
                                hintStyle: TextStyle(fontSize: 12)
                            ),
                            value: _selectedState,
                            isExpanded: true,
                            onTap: (){
                              /*if(_selectedCity == null){
                                                setState(() {
                                                  _getCityList(access_token,token_type,_selectedCountry,_selectedState);
                                                });
                                              }
                                              else{
                                                setState(() {
                                                  _selectedCity = null;
                                                  _getStateList(access_token, token_type, _selectedCountry);
                                                });
                                              }*/
                            },
                            onChanged: (state) {
                              /*if(_selectedCity == null){
                                                setState(() {
                                                  _selectedState = state;
                                                  _getCityList(access_token,token_type,_selectedCountry,_selectedState);
                                                });
                                              }
                                              else{
                                                setState(() {
                                                  _selectedCity = null;
                                                  _getStateList(access_token,token_type,_selectedCountry);
                                                });
                                              }*/
                            },
                            items: stateList?.map((item) {
                              return DropdownMenuItem(
                                value: item['id'].toString(),
                                child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)),
                              );
                            })?.toList() ?? [],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width / 6.5,
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              //border: InputBorder.none,
                                hintText: 'City',
                                hintStyle: TextStyle(fontSize: 12)
                            ),
                            value: _selectedCity,
                            isExpanded: true,
                            onChanged: (city) {
                              /*setState(() {
                                                _selectedCity = city;
                                              });*/
                            },
                            items: cityList?.map((item) {
                              return DropdownMenuItem(
                                value: item['id'].toString(),
                                child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10),),
                              );
                            })?.toList() ?? [],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 15),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 8,
                          child: TextField(
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
            padding: EdgeInsets.fromLTRB(10, 5, 20, 20),
            child: Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: (){
                  //_pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
                },
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: PrimaryColorOne,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text(
                    "Submit",
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
  List stateList;
  Future<String> _getStateList(var accesstoken,var token_type,var selectCountry) async {
    await http.post(
        Uri.parse(ApiUrls.getState),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accesstoken',
        },
        body: jsonEncode({'country_id': selectCountry})
    ).then((response) {
      print(response.body);
      var data = json.decode(response.body);
      setState(() {
        stateList = data['data'];
      });
    });
  }

  List cityList;
  Future<String> _getCityList(var accesstoken,var token_type,var selectCountry,var selectState) async {
    await http.post(
        Uri.parse(ApiUrls.getCity),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accesstoken',
        },
        body: jsonEncode({
          'country_id': selectCountry,
          'state_id': selectState})
    ).then((response) {
      print(response.body);
      var data = json.decode(response.body);
      setState(() {
        cityList = data['data'];
      });
    });
  }
}
