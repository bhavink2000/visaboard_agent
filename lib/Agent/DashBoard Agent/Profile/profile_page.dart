//@dart=2.9
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../App Helper/Api Repository/api_urls.dart';
import '../../App Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Providers/Authentication Provider/user_data_auth_session.dart';
import '../../App Helper/Routes/App Routes/app_routes_name.dart';
import '../../App Helper/Ui Helper/snackbar_msg_show.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';

class ProfilePage extends StatefulWidget{
  const ProfilePage({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ProfilePage();
  }
}

class _ProfilePage extends State<ProfilePage>{

  GetAccessToken getAccessToken = GetAccessToken();

  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
  }

  @override
  Widget build(BuildContext context) {
    final userDataSession = Provider.of<UserDataSession>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            //height: MediaQuery.of(context).size.height / 2.8,
            decoration: BoxDecoration(
              color: PrimaryColorOne,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50)
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, AppRoutesName.dashboard);
                        },
                        child: const Icon(AntDesign.arrowleft, color: Colors.white,),
                      ),
                      InkWell(
                        onTap: (){
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                  child: AlertDialog(
                                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                    content: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          CircleAvatar(
                                            maxRadius: 40.0,
                                            backgroundColor: Colors.white,
                                            child: Image.asset("assets/image/icon.png",width: 50,),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                                onTap: (){},
                                                child: Text("VISABOARD", style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 18),)
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                              "Continue to LOGOUT",
                                              style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              TextButton(
                                                child: Text("Stay",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 2),),
                                                onPressed: () => Navigator.of(context).pop(),
                                              ),
                                              TextButton(
                                                child: Text("Logout",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 2),),
                                                onPressed: (){
                                                  userDataSession.removeUserData();
                                                  Navigator.pushNamed(context, AppRoutesName.login);
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                          );
                        },
                        child: const Icon(Icons.logout, color: Colors.white,),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Image.asset(
                        "assets/image/icon.png",
                        width: MediaQuery.of(context).size.width / 3.5,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'VisaBoard',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: Constants.OPEN_SANS,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Agent Id - ${getAccessToken.id}',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: Constants.OPEN_SANS,
                        fontSize: 16,
                        letterSpacing: 1
                    ),
                  ),
                ),
                const SizedBox(height: 10,)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
            child: InkWell(
              onTap: (){openChangePassword();},
              child: Card(
                elevation: 8,
                shadowColor: PrimaryColorOne.withOpacity(0.5),
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Container(
                  decoration: BoxDecoration(
                      color: PrimaryColorOne,
                      borderRadius: const BorderRadius.all(Radius.circular(30))
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(30))
                          ),
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(15),
                          child: Text("Change Password",style: TextStyle(fontSize: 13,fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),)
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(Icons.compare_arrows,color: Colors.white,),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
            child: InkWell(
              onTap: ()=>launch("https://api.whatsapp.com/send?phone=918347349543&text=Looking%20for%20%20SOP%20and%20%20other%20VISA%20document%20Services&source=website&data="),
              child: Card(
                elevation: 8,
                shadowColor: PrimaryColorOne.withOpacity(0.5),
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Container(
                  decoration: BoxDecoration(
                      color: PrimaryColorOne,
                      borderRadius: const BorderRadius.all(Radius.circular(30))
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(30))
                            ),
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(15),
                            child: Text("WhatsApp",style: TextStyle(fontSize: 13,fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),)
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(Icons.whatshot,color: Colors.white,),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
            child: InkWell(
              onTap: ()=>launch("tel://8980006120"),
              child: Card(
                elevation: 8,
                shadowColor: PrimaryColorOne.withOpacity(0.5),
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Container(
                  decoration: BoxDecoration(
                      color: PrimaryColorOne,
                      borderRadius: const BorderRadius.all(Radius.circular(30))
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(30))
                            ),
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(15),
                            child: Text("Contact",style: TextStyle(fontSize: 13,fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),)
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(Icons.phone_iphone,color: Colors.white,),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/image/icon.png",width: 30),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text("VISABOARD",style: TextStyle(fontSize: 25,fontFamily: Constants.OPEN_SANS,color: PrimaryColorOne)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text("Copyright © 2022 VisaBoard. All Rights Reserved.",style: TextStyle(fontSize: 8,fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold,color: Colors.black)),
          ),
        ],
      ),
    );
  }
  openChangePassword() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: AlertDialog(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
              contentPadding: const EdgeInsets.only(top: 10.0),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 0, 5),
                    child: Text("Change Password",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),),
                  ),
                  Divider(thickness: 1.5,color: PrimaryColorOne,),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width / 7,
                        child: TextField(
                          controller: currentPassword,
                          style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                          decoration: InputDecoration(
                              hintText: 'Current Password',
                              hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width / 7,
                        child: TextField(
                          controller: newPassword,
                          style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                          decoration: InputDecoration(
                              hintText: 'New Password',
                              hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width / 7,
                        child: TextField(
                          controller: confirmPassword,
                          style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                          decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(32),
                          bottomLeft: Radius.circular(32),
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
                                currentPassword.text = "";
                                newPassword.text = "";
                                confirmPassword.text = "";
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Discard",
                                style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,fontSize: 15),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          const VerticalDivider(thickness: 1.5,color: Colors.white,),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                            child: InkWell(
                              onTap: (){
                                if(currentPassword.text.isEmpty || newPassword.text.isEmpty || confirmPassword.text.isEmpty){
                                  SnackBarMessageShow.warningMSG('Fill All Field', context);
                                }
                                else{
                                  changePassword();
                                }
                              },
                              child: Text(
                                "Change",
                                style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,fontSize: 15),
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
            ),
          );
        }
    );
  }
  void changePassword() {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${getAccessToken.access_token}',
    };
    http.post(Uri.parse(ApiConstants.ChangePassword),
        headers: headers,
        body: {
          "current_password": currentPassword.text,
          "password": newPassword.text,
          "confirmed_password": confirmPassword.text,
        }).then((reponse){
          print("resposne->${reponse.statusCode}");
          print("resposne->${reponse.body}");
      if(reponse.statusCode == 200){
        SnackBarMessageShow.successsMSG('Update SuccessFully', context);
        Navigator.pushNamed(context, AppRoutesName.dashboard);
      }
      else{
        print(reponse.statusCode);
        SnackBarMessageShow.errorMSG('Something Get Wrong', context);
      }
    });
  }
}