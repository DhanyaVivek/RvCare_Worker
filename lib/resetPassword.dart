import 'package:flutter/material.dart';

import 'ApiServices/resetpasswordApi.dart';
import 'Utils/AppConstants.dart';
import 'Utils/Connectivity.dart';
import 'Utils/Global.dart';
import 'common/constant.dart';
import 'model/modelforgotpassword.dart';
import 'otpScreen.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isObscure = false;
  var mobileTextController = TextEditingController();

  var deviceid="12345";
  @override
  late  ModelForgotpassword model;
  dynamic _mobile ='';
  String title = '';

  bool validateMobile(String value) {
    String pattern = r'^[6-9]\d{9}$';

    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return false;
    } else if (!regExp.hasMatch(value)) {
      return true;
    }
    return true;
  }

 FortpasswordApiCall() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        print('hhhhhhhh');
        //await progressDialog.show();
        apiFunc();
      } else {
        Toast.show("Please check your internet connection",
        );

        return;
      }
    });
  }

  apiFunc() {
    ResetPasswordApiService.ResetPasswordApiCall(
        context, mobileTextController.text)
        .then((modelForgotpassword) async {
      try {
        // print('dddd');

        // showToast(modelLogin.message.toString(),
        //     gravity: Toast.bottom, duration: 2);
        model = modelForgotpassword;

        // progressDialog.hide();
        if (modelForgotpassword.message =='success') {
          //    print(mobileTextController.text);
          print(modelForgotpassword.otp);
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(AppConstants.mobile,mobileTextController.text.toString());
          final String? mobile = prefs.getString(AppConstants.mobile);
          // print(mobile);
          setState(() {
            _mobile = mobile;
            // print(mobile);
            Global.shared.mobile = _mobile;

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return  OTPScreen(
                    otp: modelForgotpassword.otp,
                    // mobile: _mobile,
                  );
                },
              ),
            );
          });
        }
        // await progressDialog.hide();
        //Toast.show((modelLogin.status),
      } catch (e) {
        //await progressDialog.hide();
      }
    });
  }
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ToastContext().init(context);
    return Scaffold(
        backgroundColor: themeColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Container(
              height: size.height,
              width: size.width,
              color: themeColor,
              child: Stack(
                children: [
                  Positioned(
                    top: size.height * 0.1,
                    child: Container(
                      width: size.width,
                      color: themeColor,
                      child: Center(
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/logoimg.png",
                              height: size.height * 0.18,
                              width: size.width * 0.6,
                              fit: BoxFit.fill,
                            ),
                            const SizedBox(
                              height: 45.0,
                            ),
                            const Text(
                              "Reset Password ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.0),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: size.height * 0.4,
                    left: 70,
                    child: Text(
                      'Please enter your mobile number to continue.',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                          fontFamily: "Roboto"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18),
                    child: Divider(
                      height: 2,
                      color: Colors.black26,
                    ),
                  ),
                  Positioned(top: size.height * 0.48, child: ResetWidget())
                ],
              ),
            ),
          ),
        ));
  }

  Widget ResetWidget() {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Container(
        height: size.height * 0.45,
        width: size.width,
        // color: Colors.greenAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 30,
                width: 100,
                child: Text(
                  'Mobile Number',
                  style: TextStyle(fontSize: 11, fontFamily: "Roboto",fontWeight: FontWeight.w500),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 35,
          child: TextFormField(

                // controller: name,

                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                    // helperText: "+91 ",
                    hintText: "+91",
                    contentPadding: EdgeInsets.only(left: 6.0,top:30),
                    isDense: true,
                    hintStyle: const TextStyle(
                        fontFamily: "Roboto",
                        color: Colors.black87,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300),
                    fillColor: greyColor,
                    filled: true,
                    counterText: "",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  maxLength: 30),
        ),

      const SizedBox(
        width: 6,
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Image.asset(
                "assets/images/seperator.png",height: 52,width: 5,),
        ),
      ),
      const SizedBox(
        width: 6,
      ),
                Container(
                  width: 270,
                  height: 50,
                  color: textboxfillcolor,
                  child: TextFormField(
                      controller: mobileTextController,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                        hintText: "Mobile no",
                        hintStyle: const TextStyle(
                            fontFamily: "Roboto",
                            color: Colors.black54,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w300),
                        fillColor: greyColor,
                        filled: true,
                        counterText: "",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 10),
                ),
              ],
            ),
            const SizedBox(
              width: 6,
            ),

            // Text(isError?"Enter valid number":""),

            SizedBox(
              height: size.height * 0.05,
            ),
            TextButton(
              onPressed: () {
                FortpasswordApiCall();
              },
              child: Container(
                height: 45,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  color: buttoncolor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Reset Password",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto",
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
