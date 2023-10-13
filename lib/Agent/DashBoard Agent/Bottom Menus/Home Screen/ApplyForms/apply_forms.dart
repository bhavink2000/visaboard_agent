
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Routes/App%20Routes/app_routes_name.dart';
import 'package:visaboard_agent/Agent/Authentication%20Pages/OnBoarding/constants/constants.dart';

import '../../../../App Helper/Api Repository/api_urls.dart';
import '../../../../App Helper/Get Access Token/get_access_token.dart';
import '../../../../App Helper/Ui Helper/loading.dart';
import '../../../../App Helper/Ui Helper/snackbar_msg_show.dart';
import '../../../../App Helper/Ui Helper/ui_helper.dart';
import '../../../../Drawer Menus/drawer_menus.dart';

class ApplyForms extends StatefulWidget {
  var name;
  ApplyForms({Key? key,this.name}) : super(key: key);

  @override
  State<ApplyForms> createState() => _ApplyFormsState();
}

class _ApplyFormsState extends State<ApplyForms> {

  GetAccessToken getAccessToken = GetAccessToken();

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final _advancedDrawerController = AdvancedDrawerController();

  final desc = TextEditingController();
  final collage = TextEditingController();
  final quntity = TextEditingController();
  final orderP = TextEditingController();

  bool wallet = false;
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        _getserviceList(getAccessToken.access_token);
      });
    });
    Future.delayed(const Duration(seconds: 3),(){
      setState(() {
        _getClientsList(getAccessToken.access_token);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      key: _key,
      drawer: CustomDrawer(controller: _advancedDrawerController,),
      backdropColor: const Color(0xff0052D4),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      childDecoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Scaffold(
        backgroundColor: const Color(0xff0052D4),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Align(alignment: Alignment.topRight,child: Text(widget.name.toString().toUpperCase(),style: AllHeader)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: (){Navigator.pop(context);},
              icon: const Icon(Icons.arrow_back,color: Colors.white,size: 30,)
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomLeft: Radius.circular(5),
                                      topRight: Radius.circular(25),
                                      bottomRight: Radius.circular(25)
                                  ),
                                  color: PrimaryColorOne
                              ),
                              padding: const EdgeInsets.fromLTRB(15, 10, 25, 10),
                              child: Text("Quick Apply",style: TextStyle(fontSize: 15,color: Colors.white,fontFamily: Constants.OPEN_SANS),),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                          child: Card(
                            elevation: 5,
                            color: PrimaryColorOne,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                  child: Icon(Icons.room_service,color: Colors.white),
                                ),
                                const Spacer(),
                                Container(
                                  width: MediaQuery.of(context).size.width / 1.3,
                                  height: MediaQuery.of(context).size.width / 7.5,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                                  padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
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
                                        countryList!.clear();
                                        letterList!.clear();
                                        _selectedService = null;
                                        _selectedCountry = null;
                                        _selectedLetter = null;
                                        _selectedLetterPrice = null;
                                        college_name_show = null;
                                        _getCountryList(getAccessToken.access_token);
                                      });
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedService = value as String?;
                                        _selectedCountry = null;
                                        _selectedLetter = null;
                                        _selectedLetterPrice = null;
                                        college_name_show = null;
                                        _getCountryList(getAccessToken.access_token);
                                        print("Service ->$_selectedService");
                                      });
                                    },
                                    onSaved: (value) {
                                      setState(() {
                                        _selectedService = value as String?;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return "can't empty";
                                      } else {
                                        return null;
                                      }
                                    },
                                    items: serviceList?.map((item) {
                                      return DropdownMenuItem(
                                        value: item['id'], // Ensure this is a unique identifier
                                        child: Text(item['name'], style: TextStyle(fontFamily: Constants.OPEN_SANS, fontSize: 10),),
                                      );
                                    }).toList() ?? [],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                          child: Card(
                            elevation: 5,
                            color: PrimaryColorOne,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                  child: Icon(Icons.code,color: Colors.white),
                                ),
                                const Spacer(),
                                Container(
                                  width: MediaQuery.of(context).size.width / 1.3,
                                  height: MediaQuery.of(context).size.width / 7.5,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                                  padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
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
                                          letterList!.clear();
                                          _selectedLetter == null ;
                                          //_getCountryList(getAccessToken.access_token);
                                          //_getletterList(getAccessToken.access_token, _selectedService, _selectedCountry);
                                        });
                                      }
                                      else{
                                        setState(() {
                                          _selectedLetter = null;
                                          //_getCountryList(getAccessToken.access_token);
                                        });
                                      }
                                    },
                                    onChanged: (country) {
                                      if(_selectedLetter == null){
                                        setState(() {
                                          _selectedCountry = country as String?;
                                          _selectedLetter == null;
                                          _getletterList(getAccessToken.access_token, _selectedService, _selectedCountry);
                                          print("country ->$_selectedCountry}");
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
                                        child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10),),
                                      );
                                    }).toList() ?? [],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                          child: Card(
                            elevation: 5,
                            color: PrimaryColorOne,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                  child: Icon(Icons.legend_toggle,color: Colors.white),
                                ),
                                const Spacer(),
                                Container(
                                  width: MediaQuery.of(context).size.width / 1.3,
                                  height: MediaQuery.of(context).size.width / 7.5,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                                  padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Letter Type',
                                        hintStyle: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,letterSpacing: 1)
                                    ),
                                    value: _selectedLetter,
                                    isExpanded: true,
                                    onChanged: (value) {
                                      if(letterList!.isNotEmpty){
                                        setState(() {
                                          _selectedLetter = value as String?;
                                          checkShowData();
                                        });
                                      }
                                      else{
                                        print("else");
                                      }
                                    },
                                    onSaved: (value) {
                                      setState(() {
                                        _selectedLetter = value as String?;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return "can't empty";
                                      } else {
                                        return null;
                                      }
                                    },
                                    items: letterList?.map((item) {
                                      return DropdownMenuItem(
                                        value: item['id'].toString(),
                                        child: Text("${item['name']}\n(Price :- "
                                            '${getAccessToken.countryId == '101' ? '\u{20B9}' : '\$'}'
                                            "${getAccessToken.countryId == '101'
                                            ? item['price'] == null ? 0 : item['price']
                                            : item['usd_price'] == null ? 0 : item['usd_price']})",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 9)),
                                      );
                                    }).toSet().toList() ?? [],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                          child: Card(
                            elevation: 5,
                            color: PrimaryColorOne,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                  child: Icon(Icons.person_pin,color: Colors.white),
                                ),
                                const Spacer(),
                                Container(
                                  width: MediaQuery.of(context).size.width / 1.3,
                                  height: MediaQuery.of(context).size.width / 7.5,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                                  padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Clients',
                                        hintStyle: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,letterSpacing: 1)
                                    ),
                                    value: _clientId,
                                    isExpanded: true,
                                    onChanged: (value) {
                                      _clientId = value as String?;
                                    },
                                    onSaved: (value) {
                                      setState(() {
                                        _clientId = value as String?;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return "can't empty";
                                      } else {
                                        return null;
                                      }
                                    },
                                    items: clientSList?.map((item) {
                                      return DropdownMenuItem(
                                        value: item['enc_id'],
                                        child: Row(
                                          children: [
                                            Text("${item['first_name']} ${item['last_name']}",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)),
                                            const SizedBox(width: 5),
                                            Text("(Id -${item['id']})",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)),
                                          ],
                                        ),
                                      );
                                    }).toSet().toList() ?? [],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        formDataShow('Note', desc),
                        Visibility(
                          visible: college_name_show == 1 ? true : false,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                            child: Card(
                              elevation: 5,
                              color: PrimaryColorOne,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                    child: Icon(Icons.school,color: Colors.white),
                                  ),
                                  const Spacer(),
                                  Container(
                                    width: MediaQuery.of(context).size.width / 1.3,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                                    padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                    child: TextField(
                                      controller: collage,
                                      style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'College',
                                        hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: college_name_show == 0 ? true : false,
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
                                      controller: quntity,
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
                                      Text("${_selectedLetterPrice}",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.black),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text("Payment Options",
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: Constants.OPEN_SANS,
                                
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                value: wallet,
                                onChanged: (bool? value) {
                                  setState(() {
                                    wallet = value!;
                                  });
                                },
                              ),
                              Text("Pay From Wallet",style: TextStyle(fontFamily: Constants.OPEN_SANS),),
                            ],
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
                                  if(_selectedService == null){
                                    Fluttertoast.showToast(msg: 'Please select service');
                                  }
                                  else if(_selectedCountry == null || _selectedCountry == ''){
                                    Fluttertoast.showToast(msg: 'Please select country');
                                  }
                                  else if(_selectedLetter == null || _selectedLetter == ''){
                                    Fluttertoast.showToast(msg: 'Please select letter');
                                  }
                                  else if(_clientId == null){
                                    Fluttertoast.showToast(msg: 'Please select client');
                                  }
                                  else if(_selectedService == '1'){
                                    if(collage.text.isEmpty){
                                      Fluttertoast.showToast(msg: 'Please enter collage');
                                    }
                                  }
                                  else if(quntity.text.isEmpty){
                                    Fluttertoast.showToast(msg: 'Please enter quantity');
                                  }
                                  else{
                                    addApplicant();
                                  }
                                },
                                child: Container(
                                  width: 100,
                                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),color: PrimaryColorOne
                                  ),
                                  child: Text("Pay Now",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white,letterSpacing: 1),textAlign: TextAlign.center,),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget formDataShow(String label, TextEditingController controller){
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
      child: Card(
        elevation: 5,
        color: PrimaryColorOne,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Icon(Icons.note,color: Colors.white),
            ),
            const Spacer(),
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
              padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
              child: TextField(
                controller: controller,
                style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '$label',
                  hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _selectedService;
  List<Map<String, dynamic>> serviceList = [];
  Future<String?> _getserviceList(var accesstoken) async {
    print("calling");
    await http.get(
        Uri.parse(ApiUrls.getServiceType),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accesstoken',
        }
    ).then((response) {
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'] as List<dynamic>;
        setState(() {
          serviceList = data.map((item) => {
            'id': item['id'].toString(),
            'name': item['name'],
          }).toList();
        });
      }
      print(response.body);
    });
  }

  String? _selectedCountry = '';
  List? countryList;
  Future<String?> _getCountryList(var accesstoken) async {
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

  String? _selectedLetter = '';
  var _selectedLetterPrice;
  List? letterList;
  Future<String?> _getletterList(var accesstoken,var selectService,var selectcountry) async {
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

  String? _clientId;
  List? clientSList;
  Future<String?> _getClientsList(var accesstoken) async {
    print("calling");
    await http.post(
        Uri.parse(ApiConstants.getClientList),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accesstoken',
        }
    ).then((response) {
      print(response.body);
      var data = json.decode(response.body);
      setState(() {
        clientSList = data['data'];
      });
    });
  }

  var college_name_show;
  Future<dynamic> checkShowData() async {
    var response = await http.post(
      Uri.parse(ApiConstants.getCheckShowData),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${getAccessToken.access_token}',
      },
      body: jsonEncode({
        'service_type_id': _selectedService,
        'country_id': _selectedCountry,
        'letter_type_id': _selectedLetter,
      }),
    );
    print("res->>>>${response.body}");
    var status = jsonDecode(response.body)['status'];
    if(status == 200){
      setState(() {
        college_name_show = jsonDecode(response.body)['college_name_show'];
        _selectedLetterPrice = jsonDecode(response.body)['order_price'];
      });
    }
    else{
      Fluttertoast.showToast(msg: "Try Again");
    }
  }

  Future addApplicant()async{
    LoadingIndicater().onLoad(true, context);

    Dio dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${getAccessToken.access_token}";
    dio.options.headers["Accept"] = "application/json";

    FormData formData = FormData.fromMap({
      'service_type_id' : _selectedService,
      'country_id': _selectedCountry,
      'letter_type_id': _selectedLetter,
      'user_id': _clientId,
      'description': desc.text,
      'foreign_institute_name': collage.text,
    });
    var response = await dio.post(
        ApiConstants.getQuickApply,
        options: Options(validateStatus: (_)=> true),
        data: formData,
        onSendProgress: (int sent, int total) {
          print('$sent $total');
        }
    );
    var jsonResponse = response.data;
    if (response.statusCode == 200) {
      var status = jsonResponse['status'];
      if (status == 200) {
        Navigator.pushNamed(context, AppRoutesName.dashboard);
        LoadingIndicater().onLoadExit(false, context);
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
