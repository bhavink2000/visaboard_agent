import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../Api Repository/api_urls.dart';

class RazorpayService {
  static Razorpay? _razorpay;

  static void initialize() {
    log('in initialize in razorpayservice');
    _razorpay = Razorpay();
    log('in initialize in razorpayservice');
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  static void handlePaymentError(PaymentFailureResponse response) {
    print('Payment Error: ${response.message}');
    print('Payment code: ${response.code}');
    print('Payment hacode: ${response.hashCode}');
  }

  static void handleExternalWallet(ExternalWalletResponse response) {
    print('External Wallet: ${response.walletName}');
  }

  static void handlePaymentSuccess(PaymentSuccessResponse response) {


    var paymentId = response.paymentId;
    print('Payment Successful. Payment ID: $paymentId');
  }
  static Future<String> openCheckout(var amount) async {
    log('======================$_razorpay');
    log("amount -------------> ${amount.toString()}");
    var finalAmount = (double.parse(amount) * 100).toInt();

    log("final amount -------------> ${finalAmount.toString()}");
    Completer<String> completer = Completer<String>();

    if (_razorpay != null) {
      log('in if with Razorpay');
      var options = {
        'key': 'rzp_test_KcPuwl0Kuwboir',
        //'key': 'rzp_live_ILgsfZCZoFIKMb',
        'amount': finalAmount,
        'name': 'Visaboard',
        'description': 'Payment for your order',
        //'prefill': {'contact': mobile, 'email': emailId},
        'external': {'wallets': ['paytm']}
      };

      _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, (PaymentSuccessResponse response) {
        print("on caliing");
        var paymentId = response.paymentId;
        completer.complete(paymentId);
        print('Payment Successful. Payment ID: $paymentId');
      });

      try {
        log('in try block');
        _razorpay!.open(options);
        log('after in try');
      } catch (e) {
        log('Error: ()()()()()()()()()( ${e.toString()}');
        completer.completeError(e);
      }
    } else {
      print('Razorpay is not initialized');
      completer.completeError('Razorpay is not initialized');
    }

    return completer.future;
  }

  static void dispose() {
    _razorpay!.clear();
  }

}
