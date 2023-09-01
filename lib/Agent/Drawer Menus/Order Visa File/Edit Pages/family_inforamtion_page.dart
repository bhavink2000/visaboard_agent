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
import '../../../App Helper/Routes/App Routes/app_routes_name.dart';
import '../../../App Helper/Ui Helper/snackbar_msg_show.dart';
import '../../../App Helper/Ui Helper/ui_helper.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';


class FamilyInfoPage extends StatefulWidget {
  var pagecontroller;
  OVFEditData editDetails;
  var user_id, user_sop_id;
  var tabStatus,tabName;
  FamilyInfoPage({Key key,this.pagecontroller,this.editDetails,this.user_id,this.user_sop_id,this.tabStatus,this.tabName}) : super(key: key);

  @override
  State<FamilyInfoPage> createState() => _FamilyInfoPageState();
}

class _FamilyInfoPageState extends State<FamilyInfoPage> {

  List<TextEditingController> fiFNm = [TextEditingController()];
  List<TextEditingController> fiBirthDate = [TextEditingController()];
  List<TextEditingController> fiBirthPlace = [TextEditingController()];
  List<TextEditingController> fiOccupation = [TextEditingController()];
  List<TextEditingController> fiRemark = [TextEditingController()];

  List<String> fiRelation = [null];
  List<String> fiResidence = [null];
  List<String> fiMarital = [null];

  int numberofitems = 1;


  GetAccessToken getAccessToken = GetAccessToken();
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        getRelationType(getAccessToken.access_token);
      });
    });
    Future.delayed(const Duration(seconds: 2),(){
      setState(() {
        getCountryType(getAccessToken.access_token);
      });
    });
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
              child: Text("You have submitted request for Visa File SOP, Canada, on Date: December 7th, 2022 12:46 PM.",style: TextStyle(fontSize: 13,fontFamily: Constants.OPEN_SANS,color: Colors.green),),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
              child: Align(alignment: Alignment.topLeft,child: Text("Family Information",style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold),)),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: InkWell(
                onTap: (){
                  fiFNm.add(TextEditingController());
                  fiRemark.add(TextEditingController());
                  fiOccupation.add(TextEditingController());
                  fiBirthPlace.add(TextEditingController());
                  fiBirthDate.add(TextEditingController());
                  fiRelation.add(null);
                  fiMarital.add(null);
                  fiResidence.add(null);
                  numberofitems++;
                  setState(() {});
                },
                child: Container(
                  color: PrimaryColorOne,
                  padding: const EdgeInsets.all(6),
                  child: Text("Add More +",style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                ),
              ),
            )
          ],
        ),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: numberofitems,
            itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  elevation: 8,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 8,
                          child: TextField(
                            controller: fiFNm[index],
                            decoration: InputDecoration(
                                hintText: 'Full Name ',
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
                                  hintText: 'Relation to you',
                                  hintStyle: TextStyle(fontSize: 10)
                              ),
                              value: fiRelation[index],
                              style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,color: Colors.black),
                              isExpanded: true,
                              onChanged: (value) {
                                setState(() {
                                  fiRelation[index] = value;
                                });
                              },
                              onSaved: (value) {
                                setState(() {
                                  fiRelation[index] = value;
                                });
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "can't empty";
                                } else {
                                  return null;
                                }
                              },
                              items: relationTypes?.map((item) {
                                return DropdownMenuItem(
                                  value: item['id'].toString(),
                                  child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)),
                                );
                              })?.toList() ?? [],
                            )
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 8,
                          child: TextField(
                            controller: fiBirthPlace[index],
                            decoration: InputDecoration(
                                hintText: 'Place of Birth',
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
                                  hintText: 'Country of Residence',
                                  hintStyle: TextStyle(fontSize: 10)
                              ),
                              value: fiResidence[index],
                              style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,color: Colors.black),
                              isExpanded: true,
                              onChanged: (value) {
                                setState(() {
                                  fiResidence[index] = value;
                                });
                              },
                              onSaved: (value) {
                                setState(() {
                                  fiResidence[index] = value;
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
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 8,
                          child: TextField(
                            controller: fiOccupation[index],
                            decoration: InputDecoration(
                                hintText: 'Occupation',
                                hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                            ),
                          ),
                        ),
                      ),
                      Column(
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
                                    Expanded(child: _buildRadioListTile("Married", index)),
                                    Expanded(child: _buildRadioListTile("Divorced", index)),
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
                                  Expanded(child: _buildRadioListTile("Never Married", index)),
                                  Expanded(child: _buildRadioListTile("Separated", index)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 8,
                          child: Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.3,
                                height: MediaQuery.of(context).size.height / 6.3,
                                child: TextField(
                                  controller: fiRemark[index],
                                  decoration: InputDecoration(
                                      hintText: 'Remark',
                                      hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15, 10, 5, 0),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 3,
                                  height: MediaQuery.of(context).size.width / 8,
                                  child: TextField(
                                    controller: fiBirthDate[index],
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                        labelText: "Date of birth"
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
                                          fiBirthDate[index].text = formattedDate;
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
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
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
                    updateFamilyInfo();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: PrimaryColorOne,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Text(
                      "Submit",
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
    );
  }

  Widget _buildRadioListTile(String title, int index) {
    return RadioListTile(
      title: Text(
        title,
        style: TextStyle(
          fontFamily: Constants.OPEN_SANS,
          letterSpacing: 0.5,
          fontSize: 10,
        ),
      ),
      value: title,
      groupValue: fiMarital[index],
      onChanged: (value) {
        setState(() {
          fiMarital[index] = value;
        });
      },
    );
  }

  List relationTypes;
  Future<String> getRelationType(var accesstoken) async {
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
        relationTypes = data['data']['family_relation'];
      });
      print("Education List -> $relationTypes");
    });
  }

  List countryType;
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
      });
      print("Education List -> $countryType");
    });
  }


  Future<void> updateFamilyInfo() async {
    try {
      Dio dio = Dio(BaseOptions(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${getAccessToken.access_token}',
            'Accept': 'application/json',
          }
      ));

      FormData formData = FormData.fromMap({
        'step': 9,
        'user_id': widget.user_id,
        'user_sop_id': widget.user_sop_id,
      });
      for(int i = 0; i < fiFNm.length; i++) {
        var mStatus = fiMarital[i] == 'Never Married'
            ? 1
            : fiMarital[i] =='Married'
            ? 2
            : fiMarital[i] =='Divorced'
            ? 3
            : fiMarital[i] =='Separated'
            ? 4
            : 5;
        formData.fields.addAll([
          MapEntry('user_family_detail[$i][full_name]', fiFNm[i].text),
          MapEntry('user_family_detail[$i][relation_id]', fiRelation[i].toString()),
          MapEntry('user_family_detail[$i][dob]', fiBirthDate[i].text),
          MapEntry('user_family_detail[$i][birth_place]', fiBirthPlace[i].text),
          MapEntry('user_family_detail[$i][country_id]', fiResidence[i].toString()),
          MapEntry('user_family_detail[$i][occupation]', fiOccupation[i].text),
          MapEntry('user_family_detail[$i][marital_status]', mStatus.toString()),
          MapEntry('user_family_detail[$i][remark]', fiRemark[i].text),
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
          Navigator.pushNamed(context, AppRoutesName.dashboard);
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
