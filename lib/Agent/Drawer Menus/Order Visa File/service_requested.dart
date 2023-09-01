//@dart=2.9
// ignore_for_file: use_build_context_synchronously, missing_return

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Enums/enums_status.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Providers/Drawer%20Data%20Provider/drawer_menu_provider.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Ui%20Helper/error_helper.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Ui%20Helper/loading_always.dart';
import 'package:visaboard_agent/Agent/Authentication%20Pages/OnBoarding/constants/constants.dart';

import '../../App Helper/Api Repository/api_urls.dart';
import '../../App Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Routes/App Routes/drawer_menus_routes_names.dart';
import '../../App Helper/Ui Helper/loading.dart';
import '../../App Helper/Ui Helper/snackbar_msg_show.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';

class ServiceRequested extends StatefulWidget {
  var u_sop_id;
  ServiceRequested({Key key,this.u_sop_id}) : super(key: key);

  @override
  State<ServiceRequested> createState() => _ServiceRequestedState();
}

class _ServiceRequestedState extends State<ServiceRequested> {

  GetAccessToken getAccessToken = GetAccessToken();
  AgentDrawerMenuProvider agentDrawerMenuProvider = AgentDrawerMenuProvider();
  bool priceVisible = false;
  bool addService = false;
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        _getserviceList(getAccessToken.access_token);
      });
    });
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        agentDrawerMenuProvider.fetchServiceR(widget.u_sop_id, getAccessToken.access_token);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimaryColorOne,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Align(alignment: Alignment.topRight,child: Text("Service Requested".toString().toUpperCase(),style: AllHeader)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: (){Navigator.pop(context);},
            icon: const Icon(Icons.arrow_back,color: Colors.white,size: 30,)
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                    child: Text("Wallet Balance :- 1334.00",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: PrimaryColorOne),textAlign: TextAlign.center,),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: (){
                      setState(() {
                        addService = true;
                      });
                    },
                    icon: const Icon(Icons.add_box_rounded,color: Colors.white,),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),topRight: Radius.circular(15)
                  ),color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: addService,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                            child: Text("Service Requested",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),),
                          ),
                          Container(width: MediaQuery.of(context).size.width / 1,height: 1,color: PrimaryColorOne,),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                              child: Container(
                                //color: Colors.green,
                                //width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.width / 9,
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Service Type',
                                      hintStyle: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,letterSpacing: 1)
                                  ),
                                  value: _selectedService,
                                  isExpanded: true,
                                  onTap: (){
                                    setState(() {
                                      _selectedService = null;
                                      _selectedCountry = null;
                                      _selectedLetter = null;
                                      _getCountryList(getAccessToken.access_token);
                                    });
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedService = value;
                                      _selectedCountry = null;
                                      _selectedLetter = null;
                                      _getCountryList(getAccessToken.access_token);
                                      print("Service ->$_selectedService");
                                    });
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      _selectedService = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "can't empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                  items: serviceList?.map((item) {
                                    return DropdownMenuItem(
                                      value: item['id'].toString(),
                                      child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                                    );
                                  })?.toList() ?? [],
                                ),
                              )
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                              child: SizedBox(
                                //width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.width / 9,
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Country',
                                      hintStyle: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,letterSpacing: 1)
                                  ),
                                  value: _selectedCountry,
                                  isExpanded: true,
                                  onTap: (){
                                    if(_selectedLetter == null){
                                      setState(() {
                                        _selectedLetter == null ;
                                        _getCountryList(getAccessToken.access_token);
                                        _getletterList(getAccessToken.access_token, _selectedService, _selectedCountry);
                                      });
                                    }
                                    else{
                                      setState(() {
                                        _selectedLetter = null;
                                        _getCountryList(getAccessToken.access_token);
                                      });
                                    }
                                  },
                                  onChanged: (country) {
                                    if(_selectedLetter == null){
                                      setState(() {
                                        _selectedCountry = country;
                                        _selectedLetter == null;
                                        _getletterList(getAccessToken.access_token, _selectedService, _selectedCountry);
                                      });
                                    }
                                    else{
                                      setState(() {
                                        _selectedLetter = null;
                                        _getCountryList(getAccessToken.access_token);
                                      });
                                    }
                                  },
                                  items: countryList?.map((item) {
                                    return DropdownMenuItem(
                                      value: item['id'].toString(),
                                      child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                                    );
                                  })?.toList() ?? [],
                                ),
                              )
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                              child: SizedBox(
                                //width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.width / 9,
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Letter Type',
                                      hintStyle: TextStyle(fontSize: 10,fontFamily: Constants.OPEN_SANS,letterSpacing: 1)
                                  ),
                                  value: _selectedLetter,
                                  isExpanded: true,
                                  onChanged: (value) {
                                    if(letterList.isNotEmpty){
                                      setState(() {
                                        _selectedLetter = value;
                                        _selectedLetterPrice = double.parse(letterList.firstWhere((item) =>
                                        item['id'].toString() == _selectedLetter)['price'].toString()).toString();
                                        priceVisible = true;
                                      });
                                    }
                                    else{
                                      print("else");
                                    }
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      _selectedLetter = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "can't empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                  items: letterList?.map((item) {
                                    return DropdownMenuItem(
                                      value: item['id'].toString(),
                                      child: Row(
                                        children: [
                                          Container(
                                              width: 200,
                                              child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                                              )
                                          ),
                                          const SizedBox(width: 5),
                                          Text("(Price :- ${item['price']})",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)),
                                        ],
                                      ),
                                    );
                                  })?.toSet()?.toList() ?? [],
                                ),
                              )
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.width / 9,
                              child: TextField(
                                controller: note,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Note',
                                    hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: priceVisible,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width / 4,
                                    height: MediaQuery.of(context).size.height / 22,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(color: Colors.grey,width: 1)
                                    ),
                                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: TextFormField(
                                        controller: quantity,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            hintText: 'Quantity',
                                            hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                                        )
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width / 1.6,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey,width: 1),
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Order Price",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.black),),
                                        Text("$_selectedLetterPrice",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.black),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: (){
                                    _selectedService = null;
                                    _selectedCountry = null;
                                    _selectedLetter = null;
                                    _selectedLetterPrice = null;
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: 100,
                                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),color: PrimaryColorOne
                                    ),
                                    child: Text("Discard",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white,letterSpacing: 1),),
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    if(note.text.isEmpty){
                                      Fluttertoast.showToast(msg: 'Fill Required Field',textColor: Colors.white,backgroundColor: PrimaryColorOne);
                                    }
                                    else{
                                      if(_selectedService == null || _selectedCountry == null || _selectedLetter == null){
                                        Fluttertoast.showToast(msg: 'Fill Required Field',textColor: Colors.white,backgroundColor: PrimaryColorOne);
                                      }
                                      else{
                                        addServiceRequested();
                                      }
                                    }
                                  },
                                  child: Container(
                                    width: 100,
                                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),color: PrimaryColorOne
                                    ),
                                    child: Text("Send",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white,letterSpacing: 1),textAlign: TextAlign.center,),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ChangeNotifierProvider<AgentDrawerMenuProvider>(
                        create: (BuildContext context)=> agentDrawerMenuProvider,
                        child: Consumer<AgentDrawerMenuProvider>(
                          builder: (context, value, __){
                            switch(value.serviceRData.status){
                              case Status.loading:
                                return const CenterLoading();
                              case Status.error:
                                return const ErrorHelper();
                              case Status.completed:
                                return ListView.builder(
                                  itemCount: value.serviceRData.data.serviceRData.appliedFor.length,
                                  itemBuilder: (context, index){
                                    var serviceR = value.serviceRData.data.serviceRData.appliedFor;
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.green),
                                        child: Text(
                                            "You have submitted request for ${serviceR[index].letterTypeName}, ${serviceR[index].countryName} on Date: ${serviceR[index].createAt}.",
                                          style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white),
                                        ),
                                      ),
                                    );
                                  },
                                );
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  final note = TextEditingController();
  final quantity = TextEditingController();

  openServiceRequested() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState){
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                        child: Text("Service Requested",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),),
                      ),
                      Divider(thickness: 1.5,color: PrimaryColorOne,),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                          child: SizedBox(
                            //width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.width / 7,
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Service Type',
                                  hintStyle: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,letterSpacing: 1)
                              ),
                              value: _selectedService,
                              isExpanded: true,
                              onTap: (){
                                setState(() {
                                  _selectedService = null;
                                  _selectedCountry = null;
                                  _selectedLetter = null;
                                  _getCountryList(getAccessToken.access_token);
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  _selectedService = value;
                                  _selectedCountry = null;
                                  _selectedLetter = null;
                                  _getCountryList(getAccessToken.access_token);
                                  print("Service ->$_selectedService");
                                });
                              },
                              onSaved: (value) {
                                setState(() {
                                  _selectedService = value;
                                });
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "can't empty";
                                } else {
                                  return null;
                                }
                              },
                              items: serviceList?.map((item) {
                                return DropdownMenuItem(
                                  value: item['id'].toString(),
                                  child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                                );
                              })?.toList() ?? [],
                            ),
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                          child: SizedBox(
                            //width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.width / 7,
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Country',
                                  hintStyle: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,letterSpacing: 1)
                              ),
                              value: _selectedCountry,
                              isExpanded: true,
                              onTap: (){
                                if(_selectedLetter == null){
                                  setState(() {
                                    _selectedLetter == null ;
                                    _getCountryList(getAccessToken.access_token);
                                    _getletterList(getAccessToken.access_token, _selectedService, _selectedCountry);
                                  });
                                }
                                else{
                                  setState(() {
                                    _selectedLetter = null;
                                    _getCountryList(getAccessToken.access_token);
                                  });
                                }
                              },
                              onChanged: (country) {
                                if(_selectedLetter == null){
                                  setState(() {
                                    _selectedCountry = country;
                                    _selectedLetter == null;
                                    _getletterList(getAccessToken.access_token, _selectedService, _selectedCountry);
                                  });
                                }
                                else{
                                  setState(() {
                                    _selectedLetter = null;
                                    _getCountryList(getAccessToken.access_token);
                                  });
                                }
                              },
                              items: countryList?.map((item) {
                                return DropdownMenuItem(
                                  value: item['id'].toString(),
                                  child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
                                );
                              })?.toList() ?? [],
                            ),
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                          child: SizedBox(
                            //width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.width / 7,
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Letter Type',
                                  hintStyle: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,letterSpacing: 1)
                              ),
                              value: _selectedLetter,
                              isExpanded: true,
                              onChanged: (value) {
                                if(letterList.isNotEmpty){
                                  setState(() {
                                    _selectedLetter = value;
                                    _selectedLetterPrice = double.parse(letterList.firstWhere((item) =>
                                    item['id'].toString() == _selectedLetter)['price'].toString()).toString();
                                    priceVisible = true;
                                  });
                                }
                                else{
                                  print("else");
                                }
                              },
                              onSaved: (value) {
                                setState(() {
                                  _selectedLetter = value;
                                });
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "can't empty";
                                } else {
                                  return null;
                                }
                              },
                              items: letterList?.map((item) {
                                return DropdownMenuItem(
                                  value: item['id'].toString(),
                                  child: Row(
                                    children: [
                                      Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)),
                                      const SizedBox(width: 5),
                                      Text("(Price :- ${item['price']})",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)),
                                    ],
                                  ),
                                );
                              })?.toSet()?.toList() ?? [],
                            ),
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 7,
                          child: TextField(
                            controller: note,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                                hintText: 'Note',
                                hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: priceVisible,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: Colors.grey,width: 1)
                                ),
                                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Quantity",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.black),),
                                    Divider(color: Colors.grey.withOpacity(0.5),thickness: 0.5),
                                    TextFormField(
                                        controller: quantity,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            hintText: 'Add',
                                            hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                                        )
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.6,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey,width: 1),
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Order Price",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.black),),
                                    Text("$_selectedLetterPrice",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.black),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(32),
                              bottomLeft: Radius.circular(30),
                            ),color: PrimaryColorOne
                        ),
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Discard",
                                    style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              const VerticalDivider(thickness: 1.5,color: Colors.white,),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                                child: InkWell(
                                  onTap: (){},
                                  child: Text(
                                    "Submit",
                                    style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
    );
  }

  String _selectedService;
  List serviceList;
  Future<String> _getserviceList(var accesstoken) async {
    print("calling");
    await http.get(
        Uri.parse(ApiUrls.getServiceType),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accesstoken',
        }
    ).then((response) {
      print(response.body);
      var data = json.decode(response.body);
      setState(() {
        serviceList = data['data'];
      });
    });
  }

  String _selectedCountry;
  List countryList;
  Future<String> _getCountryList(var accesstoken) async {
    await http.get(
        Uri.parse(ApiUrls.getCountry),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accesstoken',
        }
    ).then((response) {
      print(response.body);
      var data = json.decode(response.body);
      setState(() {
        countryList = data['data'];
      });
    });
  }

  String _selectedLetter;
  var _selectedLetterPrice;
  List letterList;
  Future<String> _getletterList(var accesstoken,var selectService,var selectcountry) async {
    await http.post(
        Uri.parse(ApiUrls.getLetterType),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accesstoken',
        },
        body: jsonEncode({'service_id': selectService,'country_id': selectcountry})
    ).then((response) {
      print(response.body);
      var data = json.decode(response.body);
      setState(() {
        letterList = data['data'];
      });
    });
  }

  Future addServiceRequested()async{
    LoadingIndicater().onLoad(true, context);

    Dio dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${getAccessToken.access_token}";
    dio.options.headers["Accept"] = "application/json";

    FormData formData = FormData.fromMap({
      'user_id' : widget.u_sop_id,
      'service_type_id' : _selectedService,
      'country_id': _selectedCountry,
      'letter_type_id': _selectedLetter,
      'description': note.text,
      'order_qty': quantity.text ?? 1,
    });
    var response = await dio.post(
        ApiConstants.getServiceRequestedAdd,
        options: Options(validateStatus: (_)=> true),
        data: formData,
        onSendProgress: (int sent, int total) {print('$sent $total');}
    );
    if (response.statusCode == 200) {
      var jsonResponse = response.data;
      var status = jsonResponse['status'];
      var link = jsonResponse['link'];
      if (status == 200) {
        if (link != null) {
          launch("$link").whenComplete((){
            Navigator.pushNamed(context, DrawerMenusName.order_visa_file);
            LoadingIndicater().onLoadExit(false, context);
          }).then((value) {
            Navigator.pushNamed(context, DrawerMenusName.order_visa_file);
            LoadingIndicater().onLoadExit(false, context);
          }).catchError((error) {
            print("error->$error");
            LoadingIndicater().onLoadExit(false, context);
          });
        } else {
          SnackBarMessageShow.successsMSG('Something Get Wrong', context);
        }
      } else {
        SnackBarMessageShow.errorMSG('Something Get Wrong', context);
        Navigator.pop(context);
        LoadingIndicater().onLoadExit(false, context);
      }
    }
    else{
      SnackBarMessageShow.errorMSG('Something went wrong', context);
      Navigator.pop(context);
      LoadingIndicater().onLoadExit(false, context);
    }
  }
}
