
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

import 'constanst.dart';


class MakePayment {
  MakePayment(
      {required this.ctx,
        required this.price,
        required this.email,
        required this.ref,
        this.token,
        this.account,});

  BuildContext ctx;

  int price;

  String email;
  String ref;
  String? token;
  String? account;


  PaystackPlugin paystack = PaystackPlugin();

  //GetUi
  PaymentCard _getCardUI() {
    return PaymentCard(number: "", cvc: "", expiryMonth: 0, expiryYear: 0);
  }

  Future initializePlugin() async {
    await paystack.initialize(publicKey: testKey);
  }

  //Method Charging card
  Future<bool> chargeCardAndMakePayment(BuildContext context) async {
    bool isCharged = false;
    initializePlugin().then((_) async {
      Charge charge = Charge()
        ..amount = price * 100
        ..email = email
        ..reference = ref
        ..card = _getCardUI();
      CheckoutResponse response = await paystack.checkout(ctx,
          charge: charge,
          method: CheckoutMethod.card,
          fullscreen: false,
          logo: Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/a-1-plus-16517.appspot.com/o/logo.png?alt=media&token=fe2c3c62-95d5-46d4-8f96-4fd91080092f"))),
          ));
      // if (response.status == true) {
      //   isCharged = true;
      //   if (isAddCard) {
      //     boldVtuProvider!.saveCard(context, ref, token!, userId, false);
      //   } else {
      //   }
      //   // print("Full Response: $response");
      // } else {
      //   // print("Transaction failed: $response");
      // }
    });

    return isCharged;
  }
}
