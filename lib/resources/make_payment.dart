
import 'package:abshia/providers/authentication_provider.dart';
import 'package:abshia/resources/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../app/hive_impl/hive_models/offline_enrollee_data.dart';
import '../constants/constants.dart';
import '../models/plans_model.dart';
import '../providers/helper_provider.dart';
import 'constanst.dart';


class MakePayment {
  MakePayment(
      {required this.ctx,
        required this.email,
        required this.ref,
        this.token,
        this.account,
        this.isSelfEnrollee = false,
      required this.helperProvider,
      required this.authenticationProvider,
      required this.offlineEnrolleeData,
      required this.isfromOffline,
      required this.selectedSubPlan});

  BuildContext ctx;
  String email;
  String ref;
  String? token;
  String? account;
  HelperProvider helperProvider;
  final AuthenticationProvider authenticationProvider;
  final OfflineEnrolleeData offlineEnrolleeData;
  final bool isfromOffline;
  final SubscriptionPlan selectedSubPlan;
  final isSelfEnrollee;


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
        ..amount = selectedSubPlan.cost * 100
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
                    image: NetworkImage(logoUrl))),
          ));
      if (response.status == true) {
        if(isSelfEnrollee){
          final enrolled =  await helperProvider.updateEnrollmentDetail(context, offlineEnrolleeData, authenticationProvider.enrolleeUser.token!, "",
              selectedSubPlan);
          if(enrolled){
            Navigator.pushNamed(context, Routes.enrolleePaymentSuccessful);
          }
        }else{
          final enrolled =  await helperProvider.enrollUser(
              context, offlineEnrolleeData, authenticationProvider.userData.token!,
              authenticationProvider.userData.user!.details!.code!,
              selectedSubPlan
          );
          if(enrolled){
            print("Enrolled!");
            await authenticationProvider.getAgentProfile(context);

            if(isfromOffline){
              Hive.box<OfflineEnrolleeData>(offlineEnrollee)
                  .delete(offlineEnrolleeData.id);
            }
            Navigator.pushNamed(context, Routes.paymentSuccessful);
          }
        }

      } else {
        // print("Transaction failed: $response");
      }
    });

    return isCharged;
  }
}
