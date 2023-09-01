//@dart=2.9
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
class StripePaymentService{
  Map<String, dynamic> paymentIntent;

  Future<void> makePayment()async{
    try{
      paymentIntent = await createPaymentIntent('10', 'USD');
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: 'Visaboard'
        )
      ).then((value){
        displayPaymentSheet();
      });
    }catch(mError){
      print("mError -> $mError");
    }
  }
  displayPaymentSheet()async{
    try{
      await Stripe.instance.presentPaymentSheet().then((value){
        paymentIntent = null;
      }).onError((error, stackTrace){
        print("D Error -> $error / $stackTrace");
      });
    }
    on StripeException catch (sError) {
      print('sError -> $sError');
    }
    catch(dError){
      print("dError -> $dError");
    }
  }
  createPaymentIntent(String amount, String currency) async{
    try{
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer pk_test_51N3y6LSGBFj8XvSGVRvWqzB15ZobglkDwEHEdd6tVhYCdq7p4q7P9TDfVh7Zq68PEmL29Q4rRFWHHtoj3mgHb6Nl00r9aQ1rBp',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    }
    catch(cError){
      print("cError -> $cError");
    }
  }
  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}