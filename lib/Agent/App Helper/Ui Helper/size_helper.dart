import 'package:flutter/material.dart';

class SizeHelper {
  getSize (context, length) {
    if(length == 1){
    return SizedBox(height: MediaQuery.of(context).size.height / 1.6);
    }
    if(length == 2){
      return SizedBox(height: MediaQuery.of(context).size.height / 1.4);
    }
    if(length == 3){
      return SizedBox(height: MediaQuery.of(context).size.height / 3);
    }
    if(length == 4){
      return SizedBox(height: MediaQuery.of(context).size.height  / 5);
    }
    if(length == 5) {
      return SizedBox(height: MediaQuery.of(context).size.height / 14);
    }
    if(length == 6){
      return SizedBox(height: MediaQuery.of(context).size.height / 16);
    }
    if(length == 7){
      return SizedBox(height: MediaQuery.of(context).size.height / 18);
    }
    if(length == 8){
      return SizedBox(height: MediaQuery.of(context).size.height / 20);
    }
    if(length == 9){
      return SizedBox(height: MediaQuery.of(context).size.height / 22);
    }
  }
}