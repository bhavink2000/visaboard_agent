import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

import '../../Api Repository/api_urls.dart';
import '../../Routes/App Routes/drawer_menus_routes_names.dart';

class PaymentController {
  Map<String, dynamic>? paymentIntentData;

  Future<void> makePayment(var amount, var uSId, var accessToken,context) async {
    try {
      paymentIntentData = await createPaymentIntent('$amount', 'INR');

      if (paymentIntentData != null) {
        await initPaymentSheet(paymentIntentData!);
        await displayPaymentSheet(uSId,accessToken,context);
      }
    } catch (e, s) {
      print('Exception: $e $s');
    }
  }

  Future<void> initPaymentSheet(Map<String, dynamic> paymentIntentData) async {
    try {

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: 'Visaboard',
          customerId: paymentIntentData['customer'],
          paymentIntentClientSecret: paymentIntentData['client_secret'],
        ),
      );
    } catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: $e");
      }
    }
  }

  Future<void> displayPaymentSheet(var uSId, var accessToken, BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet();

      var intentId = paymentIntentData!['id'];
      print('payment intent${paymentIntentData!['id']}');
      print('payment intent${paymentIntentData!['client_secret']}');
      print('payment intent${paymentIntentData!['amount']}');
      print('payment intent$paymentIntentData');

      print("Payment sheet completed successfully.");
      insertPaymentRecord(accessToken,uSId,intentId,context);
      paymentIntentData = null;
    } on Exception catch (e) {
      if (e is StripeException) {
        print("e -> $e");
      } else {
        print("e e ->$e");
      }
    } catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: $e");
      }
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: Uri(queryParameters: body).query,
        headers: {
          'Authorization': 'Bearer sk_test_51JNBMlSFCvuwyJp8ZcRSn1Mf7O15cUvfgdUF7hUb5cCtNR48Iz0v3Thi2NTxrdWxNE6lRDYHwR1uBnsZruJz0aOx004hgefXin',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      final responseBody = jsonDecode(response.body);
      return responseBody;
    } catch (error) {
      print('Error charging user: $error');
      throw error;
    }
  }

  String calculateAmount(String amount) {
    final a = int.parse(amount) * 100;
    return a.toString();
  }

  void insertPaymentRecord(var access_token, var usID, var intentId, BuildContext context)async{

    print("calling");
    print("i Id-> $intentId");
    print("token-> $access_token");
    print("u id-> $usID");

    var response = await http.post(
      Uri.parse(ApiConstants.checkStripePayment),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${access_token}',
      },
      body: {
        'intent_id': intentId.toString(),
        'user_sop_id': usID.toString(),
      },
    );
    print("respose -> $response");
    var data = jsonDecode(response.body);
    print("data =>$data");

    var dStatus = data['status'];
    var dMsg = data['message'];

    if(dStatus == 200){
      print("in if");
      Fluttertoast.showToast(msg: "$dMsg");
      Navigator.pushNamed(context, DrawerMenusName.client);
    }else{
      Fluttertoast.showToast(msg: "$dMsg");
    }
  }
}