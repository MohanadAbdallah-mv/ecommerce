import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerece/Stripe_Payment/stripe_keys.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

abstract class PaymentManager {
  static Future<String> makePayment(int amount, String currency) async {
    try {
      print("$amount");
      String clientSecret = await _getClientSecret((amount * 100).toString(), currency);
          await _initializePaymentSheet(clientSecret);
          await Stripe.instance.presentPaymentSheet();
          log("success payment");//await Stripe.instance.confirmPaymentSheetPayment();//testing what does this function do
          return "success payment";
    } catch (e) {

      log("failed payment");
      return "failed payment";
      throw Exception(e.toString());
    }
  }

  static Future<void> _initializePaymentSheet(String clientSecret) async{
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: clientSecret,merchantDisplayName: "Shoppie_Ecommerece"));
  }

  static Future<String> _getClientSecret(String amount, String currency) async {
    Dio dio = Dio();
    var response = await dio.post(
      'https://api.stripe.com/v1/payment_intents',
      options: Options(headers: {
        "Authorization": "Bearer ${ApiKeys.secretKey}",
        "Content-Type": "application/x-www-form-urlencoded"
      }),
      data: {
        'amount': amount,
        'currency': currency,
      },
    );
    return response.data["client_secret"];
  }
}
