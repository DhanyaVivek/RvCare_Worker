import 'package:flutter/material.dart';
import 'package:rccare_workerapp/controller/paymentConfirmSucess.dart';

import '../common/constant.dart';
class ConfirmPaymentAlert extends StatefulWidget {
  const ConfirmPaymentAlert({Key? key}) : super(key: key);

  @override
  State<ConfirmPaymentAlert> createState() => _ConfirmPaymentAlertState();
}

class _ConfirmPaymentAlertState extends State<ConfirmPaymentAlert> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: size.width * 0.8,
          height: size.height * 0.35,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Image.asset(
                  'assets/images/confirmimg.png',
                  fit: BoxFit.cover,width: 65,height: 65,
                ),
              ),
              SizedBox(height: 20),
              Material(
                color: Colors.white,
                child: Text(
                  'Confirm Payment',
                  style: TextStyle(fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: textcolor,
                      fontFamily: "Roboto"),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 30.0,right: 20),
                child: Material(
                  color: Colors.white,
                  child: const Text(
                      'Please review the payment details below.'
                          ' Ensure that the amount and all other information are correct before confirming.',
                    textAlign:TextAlign.center,
                    style: TextStyle(fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: fontcolor,
                        fontFamily: "Roboto",
                      height:1.5
                    ),


                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('No',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,fontFamily: "Roboto",
                        color: textcolor),),
                  ),
                  SizedBox(width: 50,),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return  PaymentConfirmSucess(

                            );
                          },
                        ),
                      );
                      // Handle decline action
                     // PaymentConfirmSucess()
                    },
                    child: Text('Confirm',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,fontFamily: "Roboto",
                        color: buttoncolor),
                    ),),
                ],

              )
            ],
          ),



        ),
      ),
    );
  }
}
