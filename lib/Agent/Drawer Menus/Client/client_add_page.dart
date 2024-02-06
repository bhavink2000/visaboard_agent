
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../App Helper/Api Repository/api_urls.dart';
import '../../App Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Payment Geteway/Razorpay Payment/razorpay_controller.dart';
import '../../App Helper/Payment Geteway/Stripe Payment/stripe_controller.dart';
import '../../App Helper/Routes/App Routes/drawer_menus_routes_names.dart';
import '../../App Helper/Ui Helper/loading.dart';
import '../../App Helper/Ui Helper/loading_always.dart';
import '../../App Helper/Ui Helper/snackbar_msg_show.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../drawer_menus.dart';


class ClientAddPage extends StatefulWidget {
  const ClientAddPage({Key? key}) : super(key: key);

  @override
  State<ClientAddPage> createState() => _ClientAddPageState();
}

class _ClientAddPageState extends State<ClientAddPage> {

  GetAccessToken getAccessToken = GetAccessToken();
  Map<String, dynamic>? paymentIntent;

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final _advancedDrawerController = AdvancedDrawerController();

  TextEditingController fNM = TextEditingController();
  TextEditingController mNM = TextEditingController();
  TextEditingController lNM = TextEditingController();
  TextEditingController order_qty = TextEditingController();
  TextEditingController order_price = TextEditingController();
  bool priceVisible = false;
  //bool paymentWallet = false;
  bool paymentMethodVisible = false;

  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    order_qty.text = '1';
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        checkAvailablePaymentMethod();
      });
    });
    Future.delayed(const Duration(seconds: 2),(){
      setState(() {
        _getserviceList(getAccessToken.access_token);
      });
    });
    order_qty.addListener(sopCalculation);
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool walletCheck = false;
  bool razorpayCheck = false;
  bool paytmCheck = false;
  bool stripeCheck = false;
  bool onePaymentSelected = false;

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
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Align(alignment: Alignment.topRight,child: Text("Add Applicant".toString().toUpperCase(),style: AllHeader)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: (){Navigator.pop(context);},
              icon: const Icon(Icons.arrow_back_rounded,color: Colors.white,size: 30,)
          ),
        ),
        body: Container(
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Clients details",style: TextStyle(fontFamily: Constants.OPEN_SANS),),
                      Text("Wallet balance :\n${walletBalance ?? ''}",style: TextStyle(fontFamily: Constants.OPEN_SANS),textAlign: TextAlign.right,),
                    ],
                  ),
                ),
                Divider(thickness: 1.5,color: PrimaryColorOne,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: Card(
                    elevation: 5,
                    color: PrimaryColorOne,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        IconButton(onPressed: (){}, icon: Icon(Icons.room_service_rounded),color: Colors.white,),
                        const Spacer(),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.25,
                          // height: MediaQuery.of(context).size.width / 7.5,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                          padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Service type',
                                hintStyle: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,)
                            ),
                            value: _selectedService,
                            isExpanded: true,
                            onTap: (){
                              setState(() {
                                _selectedService = null;
                                _selectedCountry = null;
                                _selectedLetter = null;
                                priceVisible = false;
                                getGSTAmount = null;
                                getTotalAmount = null;
                                _selectedLetterPrice = null;
                                _getCountryList(getAccessToken.access_token);
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                _selectedService = value as String?;
                                _selectedCountry = null;
                                _selectedLetter = null;
                                _getCountryList(getAccessToken.access_token);
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
                                value: item['id'].toString(),
                                child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13),),
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
                        IconButton(onPressed: (){}, icon: Icon(Icons.code_rounded),color: Colors.white,),
                        const Spacer(),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.25,
                          // height: MediaQuery.of(context).size.width / 7.5,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                          padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Country',
                                hintStyle: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,)
                            ),
                            value: _selectedCountry,
                            isExpanded: true,
                            onTap: (){
                              if(_selectedLetter == null){
                                setState(() {
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
                        IconButton(onPressed: (){}, icon: Icon(Icons.legend_toggle),color: Colors.white,),
                        const Spacer(),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.25,
                          // height: MediaQuery.of(context).size.width / 7.5,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                          padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                          child: DropdownButtonFormField(
                            style: TextStyle(height: 1,color: Colors.black),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Letter type',
                                hintStyle: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,)
                            ),
                            value: _selectedLetter,
                            isExpanded: true,
                            onChanged: (value) {
                              if(letterList != null){
                                setState(() {
                                  _selectedLetter = value as String?;
                                  sopCalculation();
                                  /*_selectedLetterPrice = double.parse(letterList.firstWhere((item) =>
                              item['id'].toString() == _selectedLetter)['price'].toString()).toString();
                              priceVisible = true;
                              getGSTAmount = double.parse(_selectedLetterPrice) * 0.18;
                              getTotalAmount = double.parse(_selectedLetterPrice) + getGSTAmount;
                              print('GST Amount: $getGSTAmount');
                              print('Total Amount including GST: $getTotalAmount');*/
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
                                child: Text("${item['name']} \n(Price :- "
                                    '${getAccessToken.countryId == '101' ? '\u{20B9}' : '\$'}'
                                    "${getAccessToken.countryId == '101'
                                    ? item['price'] == null ? 0 : item['price']
                                    : item['usd_price'] == null ? 0 : item['usd_price']})",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                                ),
                              );
                            }).toList() ?? [],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                formDataShow('First name', fNM),
                formDataShow('Middle name', mNM),
                formDataShow('last name', lNM),
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
                                controller: order_qty,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(5)
                                ],
                                decoration: InputDecoration(
                                  hintText: 'Add',
                                  hintStyle: TextStyle(
                                    fontFamily: Constants.OPEN_SANS,
                                    fontSize: 12,
                                  ),
                                ),
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    Future.delayed(const Duration(seconds: 1), () {
                                      setState(() {
                                        sopCalculation();
                                      });
                                    });
                                  }
                                },
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Order price",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.black),),
                                  Text("$_selectedLetterPrice",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.black),),
                                ],
                              ),
                              Divider(color: Colors.grey.withOpacity(0.5),thickness: 0.5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("GST 18%",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.black),),
                                  Text("$getGSTAmount",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.black),),
                                ],
                              ),
                              Divider(color: Colors.grey.withOpacity(0.5),thickness: 0.5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Total pay",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.black),),
                                  Text("$getTotalAmount",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.black),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                walletBalanceCheck == false
                 ? Visibility(
                  visible: paymentMethodVisible,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                    child: Card(
                      elevation: 5,
                      shadowColor: PrimaryColorOne.withOpacity(0.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                value: walletCheck,
                                onChanged: (bool? value) {
                                  setState(() {
                                    walletCheck = value!;
                                    onePaymentSelected = true;
                                  });
                                },
                              ),
                              const Text("Pay from wallet")
                            ],
                          ),
                          razorpayS == 1 ? Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                value: razorpayCheck,
                                onChanged: (bool? value) {
                                  if(paytmCheck == false){
                                    setState(() {
                                      razorpayCheck = value!;
                                      if(razorpayCheck){
                                        onePaymentSelected = true;
                                      }
                                      else{
                                        onePaymentSelected = false;
                                      }
                                    });
                                  }
                                  else{
                                    setState(() {
                                      paytmCheck = false;
                                    });
                                  }
                                },
                              ),
                              const Text("Rozar Pay")
                            ],
                          ) : Container(),
                          paytmS == 1 ? Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                value: paytmCheck,
                                onChanged: (bool? value) {
                                  if(razorpayCheck == false){
                                    setState(() {
                                      paytmCheck = value!;
                                      if(paytmCheck){
                                        onePaymentSelected = true;
                                      }
                                      else{
                                        onePaymentSelected = false;
                                      }
                                    });
                                  }
                                  else{
                                    setState(() {
                                      razorpayCheck = false;
                                    });
                                  }
                                },
                              ),
                              const Text("Paytm")
                            ],
                          ) : Container(),
                          stripS == 1 ? Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                value: stripeCheck,
                                onChanged: (bool? value) {
                                  if(razorpayCheck == false){
                                    setState(() {
                                      stripeCheck = value!;
                                      if(stripeCheck){
                                        onePaymentSelected = true;
                                      }
                                      else{
                                        onePaymentSelected = false;
                                      }
                                    });
                                  }
                                  else{
                                    setState(() {
                                      razorpayCheck = false;
                                    });
                                  }
                                },
                              ),
                              const Text("Stripe")
                            ],
                          ) : Container(),
                        ],
                      ),

                    ),
                  ),
                )
                 : Column(
                  children: [
                    const CenterLoading(),
                    const Text("Checking paymethod"),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
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
                          width: 120,
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),color: PrimaryColorOne
                          ),
                          child: Text("Discard",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white,),),
                        ),
                      ),
                      InkWell(
                        onTap: ()async{
                          log('service-$_selectedService');

                          if(fNM.text.isEmpty){
                            Fluttertoast.showToast(msg: 'Enter first name',textColor: Colors.white,backgroundColor: PrimaryColorOne);
                          }
                          else if(mNM.text.isEmpty){
                            Fluttertoast.showToast(msg: 'Enter middle name',textColor: Colors.white,backgroundColor: PrimaryColorOne);
                          }
                          else if(lNM.text.isEmpty){
                            Fluttertoast.showToast(msg: 'Enter last name',textColor: Colors.white,backgroundColor: PrimaryColorOne);
                          }
                          else{
                            if(_selectedService == null || _selectedCountry == null || _selectedLetter == null){
                              Fluttertoast.showToast(msg: 'Please Select Types',textColor: Colors.white,backgroundColor: PrimaryColorOne);
                            }
                            else{
                              if(onePaymentSelected == false){
                                Fluttertoast.showToast(msg: 'Please Select One Payment');
                              }
                              else{
                                  await addApplicant();
                              }
                            }
                          }
                        },
                        child: Container(
                          width: 120,
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),color: PrimaryColorOne
                          ),
                          child: Text("Send",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white,),textAlign: TextAlign.center,),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
            IconButton(onPressed: (){}, icon: Icon(Icons.person_pin),color: Colors.white),
            const Spacer(),
            Container(
              width: MediaQuery.of(context).size.width / 1.25,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
              padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
              child: TextField(
                controller: controller,
                style: TextStyle(fontFamily: Constants.OPEN_SANS,),
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
  List? serviceList;
  Future<String?> _getserviceList(var accessToken) async {
    print("calling");
    await http.get(
        Uri.parse(ApiUrls.getServiceType),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        }
    ).then((response) {
      print(response.body);
      var data = json.decode(response.body);
      setState(() {
        serviceList = data['data'];
      });
    });
  }

  String? _selectedCountry;
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

  String? _selectedLetter;
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
        letterList?.removeWhere((element) => element['allow_usd'] == 1);
      });
    });
  }

  var _selectedLetterPrice;
  var getGSTAmount;
  var getTotalAmount;
  Future<dynamic> sopCalculation() async {
    print("calling sop c");
    var response = await http.post(
      Uri.parse(ApiConstants.getSopCalculation),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${getAccessToken.access_token}',
      },
      body: jsonEncode({
        'service_type_id': _selectedService,
        'letter_type_id': _selectedLetter,
        'agent_id': getAccessToken.enc_agent_id,
        'order_qty': order_qty.text,
      }),
    );
    var status = jsonDecode(response.body)['status'];
    var data = jsonDecode(response.body)['data'];
    if(status == 200){
      setState(() {
        _selectedLetterPrice = data['price'];
        getGSTAmount = data['igst'];
        getTotalAmount = data['total_price'];
        //order_qty.text = data['show_quantity_tab'].toString();
        priceVisible = true;
      });
    }
    else{
      Fluttertoast.showToast(msg: "Try Again");
    }
  }

  String selectedPaymentMethod = '';
  var razorpayS;
  var stripS;
  var paytmS;
  var walletBalance;
  bool walletBalanceCheck = true;
  Future<dynamic> checkAvailablePaymentMethod() async {
    print("check calling");
    var response = await http.post(
      Uri.parse(ApiConstants.checkPaymentMethod),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${getAccessToken.access_token}',
      },
      body: jsonEncode({'agent_id': getAccessToken.enc_agent_id}),
    );
    var data = jsonDecode(response.body);
    setState((){
      walletBalanceCheck = true;
    });
    razorpayS = data['data']['payment_method']['Rozorpay'];
    paytmS = data['data']['payment_method']['Paytm'];
    stripS = data['data']['payment_method']['Stripe'];
    walletBalance = data['data']['agent']['total_wallet_amount'];
    setState((){
      walletBalanceCheck = false;
    });
    paymentMethodVisible = true;
  }

  Future addApplicant()async{
    var paymentMethod = razorpayCheck == true ? 1 : paytmCheck == true ? 2 : stripeCheck == true ? 3 : 0;
    Dio dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${getAccessToken.access_token}";
    dio.options.headers["Accept"] = "application/json";

    FormData formData = FormData.fromMap({
      'user_sop[service_type_id]' : _selectedService,
      'user_sop[country_id]': _selectedCountry,
      'user_sop[letter_type_id]': _selectedLetter,
      'user[first_name]': fNM.text,
      'user[middle_name]': mNM.text,
      'user[last_name]': lNM.text,
      'user_sop[order_qty]': order_qty.text.isEmpty ? 1 : order_qty.text,
      'order_price': getTotalAmount,
      'user_sop[wallet_payment_status]': walletCheck == true ? 1 : 0,
      'user_sop[payment_from]': paymentMethod,
    });
    var response = await dio.post(
        ApiConstants.getClientAdd,
        options: Options(validateStatus: (_)=> true),
        data: formData,
        onSendProgress: (int sent, int total) {
          print('$sent $total');
        }
    );

    if (response.statusCode == 200) {
      var jsonResponse = response.data;
      var status = jsonResponse['status'];
      var data = jsonResponse['data'];

      var link = data['link'];
      var amount = data['price_for_payment'];
      var uSId = data['user_sop_enc_id'];

      var payAmount = amount.toString().split('.').first;

      if (status == 200) {
        if(link == 1){
          RazorpayService.initialize();
          RazorpayService.openCheckout(payAmount).then((paymentId) async{
            var response = await http.post(
              Uri.parse(ApiConstants.checkRozarPayPayment),
              headers: {
                'Accept': 'application/json',
                'Authorization': 'Bearer ${getAccessToken.access_token}',
              },
              body: {
                'wallet_flag': walletCheck == true ? '1' : '0',
                'user_sop_id': uSId.toString(),
                'razorpay_payment_id': paymentId.toString()
              },
            );
            var data = jsonDecode(response.body);
            var dStatus = data['status'];
            var dMsg = data['message'];
            if(dStatus == 200){
              Fluttertoast.showToast(msg: "$dMsg");
              Navigator.pushNamed(context, DrawerMenusName.client);
            }else{
              Fluttertoast.showToast(msg: "$dMsg");
              Navigator.of(context).pop();
            }
          }).catchError((error) {
            log('catch Error: $error');
          }).onError((error, stackTrace){
            log('on Error: $error');
            log('on stacktrace: $stackTrace');
          });
        }else if(link == 2){
          Fluttertoast.showToast(msg: "Open for paytm payment");
          Navigator.pushNamed(context, DrawerMenusName.client);
        }
        else if(link == 3){
          PaymentController().makePayment(getTotalAmount.toString().split('.').first,uSId,getAccessToken.access_token,context);
          //stripeService.makePayment(amount: '$payAmount', currency: 'USD');
        }
        else if(link == ''){
          Fluttertoast.showToast(msg: 'Your Payment Successful Done Form Wallet');
        }
        else{
          Fluttertoast.showToast(msg: 'No Payment Selected');
          Navigator.pushNamed(context, DrawerMenusName.client);
        }
      } else {
        SnackBarMessageShow.errorMSG('Something Get Wrong', context);
        LoadingIndicater().onLoadExit(false, context);
        Navigator.pushNamed(context, DrawerMenusName.client);
      }
    }
    else{
      SnackBarMessageShow.errorMSG('Something went wrong', context);
      LoadingIndicater().onLoadExit(false, context);
      Navigator.pushNamed(context, DrawerMenusName.client);
    }
  }

}
