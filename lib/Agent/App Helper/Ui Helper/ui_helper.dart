// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';

Color logintoast = const Color(0xff5B59AA);
Color onBoardingDetails = const Color(0xff5E5E5E);

Color PrimaryColorOne = const Color(0xff0052D4);
Color PrimaryColorTwo = const Color(0xff4364F7);
Color PrimaryColorThree = const Color(0xff6FB1FC);

Color ScaffoldBackColor = const Color(0xff0052D4);
Color DrawerBackColor = const Color(0xff0052D4);

LinearGradient LoginPageGradient = const LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xff0052D4),
      Color(0xff4364F7),
      Color(0xff6FB1FC),
    ]);

BoxDecoration MainWhiteContainerDecoration = const BoxDecoration(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30),
      topRight: Radius.circular(30),
    ),
    color: Colors.white);
RoundedRectangleBorder CardShapeData = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)));

BoxDecoration SubContainerDecoration = BoxDecoration(
  borderRadius: const BorderRadius.all(Radius.circular(20)),
  gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomLeft,
      colors: [
        const Color(0xff0052D4),
        const Color(0xff0052D4).withOpacity(0.9),
      ]),
);

EdgeInsets MainWhiteContinerTopPadding = const EdgeInsets.fromLTRB(0, 15, 0, 0);
EdgeInsets CardLTRBPadding = const EdgeInsets.fromLTRB(15, 5, 15, 5);
EdgeInsets ContinerPaddingInside = const EdgeInsets.fromLTRB(2, 5, 2, 5);
EdgeInsets DividerPadding = const EdgeInsets.fromLTRB(8, 0, 8, 0);
Divider AllDivider = const Divider(
  color: Colors.white,
  thickness: 1,
);

EdgeInsets PaddingIDNM = const EdgeInsets.fromLTRB(8, 4, 8, 4);
EdgeInsets PaddingField = const EdgeInsets.fromLTRB(8, 5, 8, 5);

TextStyle AllHeader = TextStyle(fontFamily: Constants.OPEN_SANS);
TextStyle DrawerHeaderNm = TextStyle(
    fontFamily: Constants.OPEN_SANS,
    fontWeight: FontWeight.bold,
    color: Colors.white);
TextStyle DrawerMenuStyle = TextStyle(
    fontFamily: Constants.OPEN_SANS, color: Colors.white, fontSize: 15);

TextStyle FrontHeaderID = TextStyle(
    fontFamily: Constants.OPEN_SANS, color: Colors.white, fontSize: 14);
TextStyle FrontHeaderNM = TextStyle(
    fontFamily: Constants.OPEN_SANS, color: Colors.white, fontSize: 12);

TextStyle FrontFottorL = TextStyle(
    fontFamily: Constants.OPEN_SANS, color: Colors.black, fontSize: 11);
TextStyle FrontFottorR = TextStyle(
    fontFamily: Constants.OPEN_SANS, color: Colors.black87, fontSize: 11);

TextStyle BackHeaderTopL = TextStyle(
    fontFamily: Constants.OPEN_SANS, color: Colors.white, fontSize: 11);
TextStyle BackHeaderTopR = TextStyle(
    fontFamily: Constants.OPEN_SANS, color: Colors.white, fontSize: 11);

TextStyle FottorL = FrontFottorL;
TextStyle FottorR = FrontFottorR;

Text CardDots = const Text(":", style: TextStyle(color: Colors.white));
Text CardLine = const Text("|", style: TextStyle(color: Colors.white));

TextStyle GraphTextStyle =
    TextStyle(fontSize: 15, fontFamily: Constants.OPEN_SANS);

///////////////////////////////////   Side Menu UI Helper   ////////////////////////////////////////////

BoxDecoration SideMenuMainContainerDeco = BoxDecoration(
    borderRadius: const BorderRadius.only(
        topRight: Radius.circular(25),
        topLeft: Radius.circular(15),
        bottomRight: Radius.circular(25),
        bottomLeft: Radius.circular(15)),
    color: PrimaryColorOne,
    boxShadow: [
      BoxShadow(
          color: PrimaryColorOne.withOpacity(0.4),
          spreadRadius: 1,
          blurRadius: 2)
    ]);

BoxDecoration SideMenuSubContainerDeco = const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
        topRight: Radius.circular(25),
        topLeft: Radius.circular(15),
        bottomRight: Radius.circular(25),
        bottomLeft: Radius.circular(15)));

BoxDecoration SideMenuSubContainerFrontDeco = BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(
          color: PrimaryColorOne.withOpacity(0.4),
          spreadRadius: 1,
          blurRadius: 2)
    ],
    borderRadius: const BorderRadius.only(
        topRight: Radius.circular(25),
        topLeft: Radius.circular(15),
        bottomRight: Radius.circular(25),
        bottomLeft: Radius.circular(15)));

BoxDecoration SideMenuSubContainerBackDeco = BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(
          color: PrimaryColorOne.withOpacity(0.4),
          spreadRadius: 1,
          blurRadius: 2)
    ],
    borderRadius: const BorderRadius.only(
        topRight: Radius.circular(25),
        topLeft: Radius.circular(15),
        bottomRight: Radius.circular(25),
        bottomLeft: Radius.circular(15)));

TextStyle SideMenuCardHeaderIDFLNM = TextStyle(
    color: PrimaryColorOne,
    fontFamily: Constants.OPEN_SANS,
    fontWeight: FontWeight.bold);
TextStyle SideMenuCardFotterData =
    TextStyle(fontFamily: Constants.OPEN_SANS, fontSize: 10);

EdgeInsets SideMenuContainerPadding = const EdgeInsets.fromLTRB(15, 10, 15, 10);
Text SideMenuDots = Text(":", style: TextStyle(color: PrimaryColorOne));
Divider SideMenuDivider = Divider(
  color: PrimaryColorOne,
  thickness: 1,
);

InputDecoration editFormsInputDecoration(var labelName) {
  return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      labelText: "$labelName",
      labelStyle: TextStyle(fontFamily: Constants.OPEN_SANS, fontSize: 10),
      contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 5));
}
