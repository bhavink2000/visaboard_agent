//@dart=2.9
// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../App Helper/Models/App Model/login_model.dart';
import '../../App Helper/Providers/Authentication Provider/user_data_auth_session.dart';
import '../../App Helper/Routes/App Routes/app_routes_name.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import '../OnBoarding/constants/constants.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> with TickerProviderStateMixin{

  Future<UserLogin> getUserData() => UserDataSession().getUserData();

  @override
  void initState() {
    super.initState();
    checkAuthentication(context);
  }

  void checkAuthentication(BuildContext context)async{

    getUserData().then((value)async{
      print("Access Token => ${value.accessToken}");
      print("Id => ${value.id}");
      print("enc_agent_id => ${value.encAgentId}");

      if(value.accessToken == "null" || value.accessToken == ""){
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(context, AppRoutesName.landingpage);
      }
      else{
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(context, AppRoutesName.dashboard);
      }
    }).onError((error, stackTrace){
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: AnimationLimiter(
                child: AnimationConfiguration.staggeredList(
                  position: 2,
                  duration: const Duration(milliseconds: 1000),
                  child: SlideAnimation(
                      horizontalOffset: 50.0,
                      child: FadeInAnimation(child: Image.asset("assets/image/icon.png",width: 50))
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: AnimationLimiter(
              child: AnimationConfiguration.staggeredList(
                position: 2,
                duration: const Duration(milliseconds: 1000),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 60, 50, 60),
                        child: FadeInAnimation(
                          child: DefaultTextStyle(
                            style: TextStyle(
                              fontFamily: Constants.OPEN_SANS,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              
                              color: PrimaryColorOne,
                            ),
                            child: const Text('VISABOARD'),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: FadeInAnimation(
                          child: DefaultTextStyle(
                              style: TextStyle(fontSize: 10,fontFamily: Constants.OPEN_SANS,letterSpacing: 0.5,color: Colors.black),
                              child: const Text("Copyright © 2022 VisaBoard. All Rights Reserved.",)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}