//@dart=2.9
// ignore_for_file: library_private_types_in_public_api, missing_return, non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:visaboard_agent/Agent/Authentication%20Pages/OnBoarding/constants/constants.dart';

import '../../App Helper/Api Repository/api_urls.dart';
import '../../App Helper/Routes/App Routes/app_routes_name.dart';
import '../../App Helper/Ui Helper/snackbar_msg_show.dart';
import '../Login Screen/login_screen.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final first_nm = TextEditingController();
  final last_nm = TextEditingController();
  final company_nm = TextEditingController();
  final gst_no = TextEditingController();
  final address = TextEditingController();
  final post_code = TextEditingController();
  final code = TextEditingController();
  final email = TextEditingController();
  final mobile = TextEditingController();
  final referral_code = TextEditingController();
  final password = TextEditingController();
  final cPassword = TextEditingController();
  final cpassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCountryList();
  }

  bool obScured = true;
  void _togglePasswordView() {
    setState(() {
      obScured = !obScured;
    });
  }
  bool obCScured = true;
  void _toggleCPasswordView() {
    setState(() {
      obCScured = !obCScured;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xff0052D4),
                Color(0xff4364F7),
                Color(0xff6FB1FC),
              ]
          ),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 9,
                child: Row(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(top: 0, left: 10),
                        child: AnimationLimiter(
                          child: AnimationConfiguration.staggeredList(
                            position: 1,
                            duration: Duration(milliseconds: 1000),
                            child: RotatedBox(
                                quarterTurns: -1,
                                child: SlideAnimation(
                                  verticalOffset: 30.0,
                                  child: FadeInAnimation(
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                )
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0, left: 10.0),
                        child: SizedBox(
                          //height: 200,
                          width: 200,
                          child: Column(
                            children: <Widget>[
                              Container(height: 10),
                              Center(
                                child: AnimationLimiter(
                                  child: AnimationConfiguration.staggeredList(
                                    position: 2,
                                    duration: const Duration(milliseconds: 1000),
                                    child: SlideAnimation(
                                      horizontalOffset: 30.0,
                                      child: FadeInAnimation(
                                        child: Text(
                                          'VisaBoard Mobile Application',
                                          style: TextStyle(fontSize: 16, color: Colors.white,fontFamily: Constants.OPEN_SANS,letterSpacing: 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]
                ),
              ),

              AnimatedTextField(
                  position: 3,
                  labelText: 'First name',
                  controller: first_nm,
              ),
              AnimatedTextField(position: 4, labelText: 'Last name', controller: last_nm),
              AnimatedTextField(position: 5, labelText: 'Company name', controller: company_nm),
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 30, right: 30),
                child: AnimationLimiter(
                  child: AnimationConfiguration.staggeredList(
                    position: 6,
                    duration: const Duration(milliseconds: 1000),
                    child: SlideAnimation(
                      verticalOffset: 30.0,
                      child: FadeInAnimation(
                        child: TextFormField(
                          controller: mobile,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS),
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
                            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                            fillColor: Colors.lightBlueAccent,
                            labelText: 'Mobile number',
                            labelStyle: const TextStyle(color: Colors.white70,),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              //AnimatedTextField(position: 6, labelText: 'Mobile no', controller: mobile),
              AnimatedTextField(position: 7, labelText: 'Email id', controller: email),
              //AnimatedTextField(position: 6, labelText: 'GST No (optional)', controller: gst_no),
              //AnimatedTextField(position: 7, labelText: 'Address', controller: address),

              Padding(
                padding: const EdgeInsets.only(top: 0, left: 30, right: 30),
                child: AnimationLimiter(
                  child: AnimationConfiguration.staggeredList(
                    position: 8,
                    duration: const Duration(milliseconds: 1000),
                    child: SlideAnimation(
                      verticalOffset: 30.0,
                      child: FadeInAnimation(
                        child: SizedBox(
                          //width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.width / 7,
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              //border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                                hintText: 'Country',
                                hintStyle: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,letterSpacing: 1,color: Colors.white)
                            ),
                            value: _selectedCountry,
                            isExpanded: true,
                            onTap: (){
                              if(_selectedState == null && _selectedCity == null){
                                setState(() {
                                  _getStateList(_selectedCountry);
                                });
                              }
                              else{
                                setState(() {
                                  _selectedCity = null;
                                  _selectedState = null;
                                  _getCountryList();
                                });
                              }
                            },
                            onChanged: (country) {
                              if(_selectedState == null && _selectedCity == null){
                                setState(() {
                                  _selectedCountry = country;
                                  _getStateList(_selectedCountry);
                                });
                              }
                              else{
                                setState(() {
                                  _selectedCity = null;
                                  _selectedState = null;
                                  _getCountryList();
                                });
                              }
                            },
                            items: countryList?.map((item) {
                              return DropdownMenuItem(
                                value: item['id'].toString(),
                                child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.black87,letterSpacing: 1),),
                              );
                            })?.toList() ?? [],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 0, left: 30, right: 30),
              //   child: AnimationLimiter(
              //     child: AnimationConfiguration.staggeredList(
              //       position: 9,
              //       duration: const Duration(milliseconds: 1000),
              //       child: SlideAnimation(
              //         verticalOffset: 30.0,
              //         child: FadeInAnimation(
              //           child: SizedBox(
              //             width: MediaQuery.of(context).size.width,
              //             height: MediaQuery.of(context).size.width / 6.5,
              //             child: DropdownButtonFormField(
              //               decoration: InputDecoration(
              //                 //border: InputBorder.none,
              //                   hintText: 'State',
              //                   hintStyle: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,letterSpacing: 1,color: Colors.white)
              //               ),
              //               value: _selectedState,
              //               isExpanded: true,
              //               onTap: (){
              //                 if(_selectedCity == null){
              //                   setState(() {
              //                     _getCityList(_selectedCountry,_selectedState);
              //                   });
              //                 }
              //                 else{
              //                   setState(() {
              //                     _selectedCity = null;
              //                     _getStateList(_selectedCountry);
              //                   });
              //                 }
              //               },
              //               onChanged: (state) {
              //                 if(_selectedCity == null){
              //
              //                   setState(() {
              //                     _selectedState = state;
              //                     _getCityList(_selectedCountry,_selectedState);
              //                   });
              //                 }
              //                 else{
              //                   setState(() {
              //                     _selectedCity = null;
              //                     _getStateList(_selectedCountry);
              //                   });
              //                 }
              //               },
              //               items: stateList?.map((item) {
              //                 return DropdownMenuItem(
              //                   value: item['id'].toString(),
              //                   child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.black87, letterSpacing: 1)),
              //                 );
              //               })?.toList() ?? [],
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 0, left: 30, right: 30),
              //   child: AnimationLimiter(
              //     child: AnimationConfiguration.staggeredList(
              //       position: 10,
              //       duration: const Duration(milliseconds: 1000),
              //       child: SlideAnimation(
              //         verticalOffset: 30.0,
              //         child: FadeInAnimation(
              //           child: SizedBox(
              //             width: MediaQuery.of(context).size.width,
              //             height: MediaQuery.of(context).size.width / 6.5,
              //             child: DropdownButtonFormField(
              //               decoration: InputDecoration(
              //                 //border: InputBorder.none,
              //                   hintText: 'City',
              //                   hintStyle: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,letterSpacing: 1,color: Colors.white)
              //               ),
              //               value: _selectedCity,
              //               isExpanded: true,
              //               onChanged: (city) {
              //                 setState(() {
              //                   _selectedCity = city;
              //                 });
              //               },
              //               items: cityList?.map((item) {
              //                 return DropdownMenuItem(
              //                   value: item['id'].toString(),
              //                   child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS, color: Colors.black,letterSpacing: 1),),
              //                 );
              //               })?.toList() ?? [],
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              //AnimatedTextField(position: 11, labelText: 'Post Code', controller: post_code),
              //AnimatedTextField(position: 12, labelText: 'Referral Code', controller: referral_code),
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 30, right: 30),
                child: AnimationLimiter(
                  child: AnimationConfiguration.staggeredList(
                    position: 9,
                    duration: const Duration(milliseconds: 1000),
                    child: SlideAnimation(
                      verticalOffset: 30.0,
                      child: FadeInAnimation(
                        child: TextFormField(
                          controller: password,
                          obscureText: obScured,
                          style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS),
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
                            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                            fillColor: Colors.lightBlueAccent,
                            labelText: 'Password',
                            labelStyle: const TextStyle(color: Colors.white70,),
                            suffixIcon: InkWell(
                              onTap: _togglePasswordView,
                              child: Icon(
                                obScured
                                    ?
                                Icons.visibility_off_rounded
                                    :
                                Icons.visibility_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 30, right: 30),
                child: AnimationLimiter(
                  child: AnimationConfiguration.staggeredList(
                    position: 10,
                    duration: const Duration(milliseconds: 1000),
                    child: SlideAnimation(
                      verticalOffset: 30.0,
                      child: FadeInAnimation(
                        child: TextFormField(
                          controller: cPassword,
                          obscureText: obCScured,
                          style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS),
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
                            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                            fillColor: Colors.lightBlueAccent,
                            labelText: 'Confirm password',
                            labelStyle: const TextStyle(color: Colors.white70,),
                            suffixIcon: InkWell(
                              onTap: _toggleCPasswordView,
                              child: Icon(
                                obCScured
                                    ?
                                Icons.visibility_off_rounded
                                    :
                                Icons.visibility_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //AnimatedTextField(position: 16, labelText: 'Confirm password', controller: cPassword),
              //AnimatedTextField(position: 16, labelText: 'Confirm Password', controller: cpassword),

              Padding(
                padding: const EdgeInsets.only(top: 40, right: 30, left: 200),
                child: AnimationLimiter(
                  child: AnimationConfiguration.staggeredList(
                    position: 11,
                    duration: const Duration(milliseconds: 1000),
                    child: SlideAnimation(
                      horizontalOffset: 30.0,
                      child: FadeInAnimation(
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xff0052D4),
                                blurRadius: 10.0,
                                spreadRadius: 1.0,
                                offset: Offset(
                                  5.0,
                                  5.0,
                                ),
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextButton(
                            onPressed: () {
                              if(first_nm.text.isEmpty || last_nm.text.isEmpty || company_nm.text.isEmpty
                              || _selectedCountry == ''
                              || mobile.text.isEmpty || email.text.isEmpty || password.text.isEmpty
                              ){
                                SnackBarMessageShow.warningMSG('Please fill required filed', context);
                              }
                              else{
                                if(first_nm.text.isEmpty){
                                  SnackBarMessageShow.warningMSG('Enter first name', context);
                                }
                                else if(last_nm.text.isEmpty){
                                  SnackBarMessageShow.warningMSG('Enter last name', context);
                                }
                                else if(company_nm.text.isEmpty){
                                  SnackBarMessageShow.warningMSG('Enter company name', context);
                                }
                                else if(_selectedCountry == ''){
                                  SnackBarMessageShow.warningMSG('Select Country', context);
                                }
                                else if(mobile.text.isEmpty){
                                  SnackBarMessageShow.warningMSG('Enter mobile number', context);
                                }
                                else if(email.text.isEmpty){
                                  SnackBarMessageShow.warningMSG('Enter email id', context);
                                }
                                else if(password.text.isEmpty){
                                  SnackBarMessageShow.warningMSG('Enter password', context);
                                }
                                else{
                                  signUpData();
                                }
                              }
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: Color(0xff0052D4),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 2
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 30),
                child: AnimationLimiter(
                  child: AnimationConfiguration.staggeredList(
                    position: 12,
                    duration: const Duration(milliseconds: 1000),
                    child: SlideAnimation(
                      verticalOffset: 30.0,
                      child: FadeInAnimation(
                        child: Container(
                          alignment: Alignment.topRight,
                          //color: Colors.red,
                          //height: 20,
                          child: Row(
                            children: <Widget>[
                              const Text(
                                'Have we met before?',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white70,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                                },
                                child: const Text(
                                  'Sign in',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signUpData() async {
    var url = ApiConstants.SignUp;
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          "first_name": first_nm.text ?? "",
          "last_name": last_nm.text ?? "",
          "company_name": company_nm.text ?? "",
          "gst_no": gst_no.text ?? "",
          "address": address.text ?? "",
          "country_id": _selectedCountry.toString() ?? "",
          "state_id": _selectedState.toString() ?? "",
          'city_id': _selectedCity.toString() ?? "",
          'post_code': post_code.text ?? "",
          'code': code.text ?? "",
          'mobile_no': mobile.text ?? "",
          'referral_code': referral_code.text ?? "",
          'email_id': email.text ?? "",
          'password': password.text ?? "",
        },
      );
      print("sign Response->${response.body}");
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        var bodyStatus = jsonData['status'];
        var bodyMSG = jsonData['message'];
        if (bodyStatus == 200) {
          SnackBarMessageShow.successsMSG('$bodyMSG', context);
          Navigator.pushNamed(context, AppRoutesName.login);
        } else {
          SnackBarMessageShow.warningMSG('$bodyMSG', context);
        }
      }else if(response.statusCode == 401){
        final jsonData = json.decode(response.body);
        var bodyStatus = jsonData['status'];
        if(bodyStatus == 400){
          var bodyMSG = jsonData['error']['email_id'][0];
          SnackBarMessageShow.warningMSG('$bodyMSG', context);
        }
      }

      else if(response.statusCode == 500){
        SnackBarMessageShow.warningMSG('Internal server error ${response.statusCode}', context);
      }
      else{
        SnackBarMessageShow.warningMSG('Failed to load data', context);
      }
    } catch (e) {
      print(e.toString());
      SnackBarMessageShow.warningMSG('Something wrong', context);
    }
  }

  String _selectedCountry;
  List countryList;
  Future<String> _getCountryList() async {
    await http.get(
        Uri.parse(ApiUrls.getCountry),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }
    ).then((response) {
      print(response.body);
      var data = json.decode(response.body);
      setState(() {
        countryList = data['data'];
      });
    });
  }

  String _selectedState;
  List stateList;
  Future<String> _getStateList(var selectCountry) async {
    await http.post(
        Uri.parse(ApiUrls.getState),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
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

  String _selectedCity;
  List cityList;
  Future<String> _getCityList(var selectCountry,var selectState) async {
    await http.post(
        Uri.parse(ApiUrls.getCity),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
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

class AnimatedTextField extends StatelessWidget {
  final int position;
  final String labelText;
  final TextEditingController controller;
  final String Function(String) validator;
  final IconData icons;

  const AnimatedTextField({Key key,
    this.position,
    this.labelText,
    this.controller,
    this.validator,
    this.icons
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 30, right: 30),
      child: AnimationLimiter(
        child: AnimationConfiguration.staggeredList(
          position: position,
          duration: const Duration(milliseconds: 1000),
          child: SlideAnimation(
            verticalOffset: 30.0,
            child: FadeInAnimation(
              child: TextFormField(
                controller: controller,
                style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS),
                decoration: InputDecoration(
                  enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
                  focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  fillColor: Colors.lightBlueAccent,
                  labelText: labelText,
                  labelStyle: const TextStyle(color: Colors.white70,),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}