//@dart=2.9
// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../App Helper/Api Repository/api_urls.dart';
import '../../../App Helper/Get Access Token/get_access_token.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Models/Drawer%20Menus%20Model/order_visafile_edit_model.dart';
import '../../../App Helper/Ui Helper/snackbar_msg_show.dart';
import '../../../App Helper/Ui Helper/ui_helper.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';


class FundingSponsorPage extends StatefulWidget {
  var pagecontroller;
  OVFEditData editDetails;
  var user_id, user_sop_id;
  var tabStatus, tabName;
  FundingSponsorPage({Key key,this.pagecontroller,this.editDetails,this.user_id,this.user_sop_id,this.tabStatus,this.tabName}) : super(key: key);

  @override
  State<FundingSponsorPage> createState() => _FundingSponsorPageState();
}

class _FundingSponsorPageState extends State<FundingSponsorPage> {

  String _fsSStudies;
  final fsName = TextEditingController();
  String _fsSOccupation;
  final fsSOrganization = TextEditingController();
  final fsSAnnualIncome = TextEditingController();
  final fsSFundAvaiable = TextEditingController();

  String fsLoanSupport = '';
  final fsBankName = TextEditingController();
  final fsLoanAmount = TextEditingController();
  final fsGuarantor = TextEditingController();

  List<String> fsFundsType = [null];
  List<TextEditingController> fsAmount = [TextEditingController()];
  String fsSponsorship = '';
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
        getOccupationType(getAccessToken.access_token);
      });
    });
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        getFundsType(getAccessToken.access_token);
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
              child: Align(alignment: Alignment.topLeft,child: Text("Details of the Sponsor",style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold),)),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: InkWell(
                onTap: (){
                  fsFundsType.add(null);
                  fsAmount.add(TextEditingController());
                  numberofitems++;
                  setState(() {});
                },
                child: Container(
                  color: PrimaryColorOne,
                  padding: EdgeInsets.all(6),
                  child: Text("Add More +",style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                ),
              ),
            )
          ],
        ),
        Flexible(
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width / 6.5,
                        child: DropdownButtonFormField(
                          dropdownColor: Colors.white,
                          decoration: const InputDecoration(
                            //border: InputBorder.none,
                              hintText: 'Who is going to sponsor your studies, living & accommodation? *',
                              hintStyle: TextStyle(fontSize: 10)
                          ),
                          value: _fsSStudies,
                          style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,color: Colors.black),
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              _fsSStudies = value;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              _fsSStudies = value;
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
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width / 8,
                      child: TextField(
                        controller: fsName,
                        decoration: InputDecoration(
                            hintText: 'Name ',
                            hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width / 6.5,
                        child: DropdownButtonFormField(
                          dropdownColor: Colors.white,
                          decoration: const InputDecoration(
                            //border: InputBorder.none,
                              hintText: 'What is the occupation of your sponsor?*',
                              hintStyle: TextStyle(fontSize: 10)
                          ),
                          value: _fsSOccupation,
                          style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,color: Colors.black),
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              _fsSOccupation = value;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              _fsSOccupation = value;
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width / 8,
                      child: TextField(
                        controller: fsSOrganization,
                        decoration: InputDecoration(
                            hintText: 'Name of the organization your sponsor offers duties *',
                            hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width / 8,
                      child: TextField(
                        controller: fsSAnnualIncome,
                        decoration: InputDecoration(
                            hintText: 'What is the annual income of your sponsor (from all sources)?',
                            hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width / 8,
                      child: TextField(
                        controller: fsSFundAvaiable,
                        decoration: InputDecoration(
                            hintText: 'How much fund is available with your sponsor to support your studies? *',
                            hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text("Have you taken a loan to support your studies?",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),)
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: RadioListTile(
                                title: Text("Yes",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                                value: "Yes",
                                groupValue: fsLoanSupport,
                                onChanged: (value){
                                  setState(() {
                                    fsLoanSupport = value.toString();
                                  });
                                },
                              ),
                            ),
                            Flexible(
                              child: RadioListTile(
                                title: Text("No",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                                value: "No",
                                groupValue: fsLoanSupport,
                                onChanged: (value){
                                  setState(() {
                                    fsLoanSupport = value.toString();
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
                    visible: fsLoanSupport == 'Yes' ? true : false,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.width / 8,
                            child: TextField(
                              controller: fsBankName,
                              decoration: InputDecoration(
                                  hintText: 'Bank Name *',
                                  hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.width / 8,
                            child: TextField(
                              controller: fsLoanAmount,
                              decoration: InputDecoration(
                                  hintText: 'Loan Amount *',
                                  hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.width / 8,
                            child: TextField(
                              controller: fsGuarantor,
                              decoration: InputDecoration(
                                  hintText: 'Guarantor *',
                                  hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text("Has your sponsor supported you with a certified Affidavit of Sponsorship?",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),)
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: RadioListTile(
                                title: Text("Yes",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                                value: "Yes",
                                groupValue: fsSponsorship,
                                onChanged: (value){
                                  setState(() {
                                    fsSponsorship = value.toString();
                                  });
                                },
                              ),
                            ),
                            Flexible(
                              child: RadioListTile(
                                title: Text("No",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                                value: "No",
                                groupValue: fsSponsorship,
                                onChanged: (value){
                                  setState(() {
                                    fsSponsorship = value.toString();
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
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: numberofitems,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Card(
                          elevation: 8,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                                child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.width / 6.5,
                                    child: DropdownButtonFormField(
                                      dropdownColor: Colors.white,
                                      decoration: const InputDecoration(
                                        //border: InputBorder.none,
                                          hintText: 'Source of Fund *',
                                          hintStyle: TextStyle(fontSize: 10)
                                      ),
                                      value: fsFundsType[index],
                                      style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,color: Colors.black),
                                      isExpanded: true,
                                      onChanged: (value) {
                                        setState(() {
                                          fsFundsType[index] = value;
                                        });
                                      },
                                      onSaved: (value) {
                                        setState(() {
                                          fsFundsType[index] = value;
                                        });
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "can't empty";
                                        } else {
                                          return null;
                                        }
                                      },
                                      items: fundsTypes?.map((item) {
                                        return DropdownMenuItem(
                                          value: item['id'].toString(),
                                          child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)),
                                        );
                                      })?.toList() ?? [],
                                    )
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.width / 8,
                                  child: TextField(
                                    controller: fsAmount[index],
                                    decoration: InputDecoration(
                                        hintText: 'Amount',
                                        hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
                                    ),
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
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
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
                  onTap: () async{
                    updateFundingSponsor();
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
      ],
    );
  }

  List fundsTypes;
  Future<String> getFundsType(var accesstoken) async {
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
        fundsTypes = data['data']['source_of_found'];
      });
      print("Education List -> $fundsTypes");
    });
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

  Future<void> updateFundingSponsor() async {
    var lSupport = fsLoanSupport == 'Yes' ? 1 : 0;
    try {
      Dio dio = Dio(BaseOptions(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${getAccessToken.access_token}',
            'Accept': 'application/json',
          }
      ));

      FormData formData = FormData.fromMap({
        'step': 7,
        'user_id': widget.user_id,
        'user_sop_id': widget.user_sop_id,
        'user[sponsor_relation]': _fsSStudies.toString(),
        'user[sponsor_full_name]': fsName.text,
        'user[sponsor_occupation]': _fsSOccupation.toString(),
        'user[sponsor_organization_name]': fsSOrganization.text,
        'user[sponsor_annual_income]': fsSAnnualIncome.text,
        'user[sponsor_available_bal]': fsSFundAvaiable.text,
        'user[study_loan_status]': lSupport.toString(),
        'user[loan_bank_name]': fsBankName.text,
        'user[loan_amount]': fsLoanAmount.text,
        'user[loan_guarantor]': fsGuarantor.text,
        'user[sponsor_affidavit_status]': fsSponsorship.toString(),
      });
      for(int i = 0; i < fsAmount.length; i++) {
        formData.fields.addAll([
          MapEntry('user_sof[$i][sponsor_source_of_found]', fsFundsType[i].toString()),
          MapEntry('user_sof[$i][sponsor_source_of_found_amount]', fsAmount[i].text),
        ]);
      }
      print("Form data->${formData.fields}");
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
