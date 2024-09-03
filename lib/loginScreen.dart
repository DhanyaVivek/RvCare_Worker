import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:rccare_workerapp/homescreen.dart';
import 'package:rccare_workerapp/resetPassword.dart';
import 'package:toast/toast.dart';
import 'ApiServices/LoginApiServices.dart';
import 'Utils/AppConstants.dart';
import 'Utils/Connectivity.dart';
import 'Utils/Global.dart';
import 'Utils/PreferenceHelper.dart';
import 'common/constant.dart';

import 'model/modelLogin.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isObscure = false;
  bool _isPasswordVisible = false;
  var mobileTextController = TextEditingController();
  var passwordTextController=TextEditingController();
  //var deviceid="12345";
  @override 
  late  ModelLogin model;
  dynamic _mobile ='';
  dynamic _userid ='';
  String title = '';
  bool _isLoading = false;

  Future<String?> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? deviceId;

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      deviceId = androidInfo.androidId; // Unique ID on Android
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor; // Unique ID on iOS
    } else {
      deviceId = 'Unknown';
    }

    return deviceId;
  }

  bool validateMobile(String value) {
    String pattern = r'^[6-9]\d{9}$';

    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('The mobile field is mandatory')));
      return false;
     // exit(0);
    }
    return true;
  }

  bool validatePassword(String value) {
    if (value.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('The password field is mandatory')));
      return false;
      //exit(0);
    }
    return true;
  }

  void setPreferenceValues(ModelLogin response) async {
    print('hhhhhiiiiiii');
    SharedPreferences logindata = await SharedPreferences.getInstance();
    setState(() {
      logindata.setBool('alreadyLogged', true);
      logindata.setString('accessToken', response.token.toString());
      logindata.setString('userId', response.id.toString());
      print('accessToken');


    });
  }
  loginApiCall() {
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

  apiFunc()  async{
    String? deviceId = await getDeviceId();
    LoginApiService.loginApiCall(
        context, mobileTextController.text,passwordTextController.text,deviceId!)
        .then((modelLogin) async {
      try {
        // print('dddd');

        // showToast(modelLogin.message.toString(),
        //     gravity: Toast.bottom, duration: 2);
        model = modelLogin;

        // progressDialog.hide();
        if (modelLogin.status!='') {
          //    print(mobileTextController.text);
          print(modelLogin.otp);

          final SharedPreferences prefs = await SharedPreferences.getInstance();

        //  prefs.setString(AppConstants.id,modelLogin.id.toString());
          prefs.setString(AppConstants.token,modelLogin.token.toString());
          prefs.setString(AppConstants.id,modelLogin.id.toString());
          final String? access_token = prefs.getString(AppConstants.token);
          // print(mobile);
          setState(() {
            _mobile = modelLogin.mobile;
            _userid=modelLogin.id;
             Global.shared.mobile = _mobile;
         //  Global.shared.id = _userid;
          //  print(_userid);
//print(Global.shared.mobile);
         //  print(Global.shared.id);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return HomeScreen();
                 // return  ResetPasswordScreen(

                 // );
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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor:themeColor,
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            color: themeColor,

            child: Stack(
              children: [
                Positioned(
                  top: size.height*0.1,
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
                            "Login ",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w700,
                                fontSize: 18.0),
                          ),
                          SizedBox(height: 20,),

                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top:  size.height * 0.4,
                  left: 30,
                  child: Text('Please enter your mobile number and password to continue.',

                    style: TextStyle(fontWeight: FontWeight.w400,
                      fontSize:11,fontFamily: "Roboto"),
                  ),),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0,right: 18),
                  child: Divider(
                    height: 2,
                    color: Colors.black26,
                  ),
                ),
                Positioned(top: size.height * 0.48, child: loginWidget())

              ],
            ),
          ),
        )
    );
  }
  Widget loginWidget() {
    Size size = MediaQuery.of(context).size;
    return Form(
      key:
      _formKey,
      child: Container(
        height: size.height * 0.45,
        width: size.width,
        // color: Colors.greenAccent,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                Container(
                  width: 35,
                 // color: Colors.transparent,
                  child:
                  // TextFormField(
                  //   enabled: false,
                  //   maxLength: 10,
                  //   decoration: const InputDecoration(
                  //     helperText: "+91 ",
                  //     hintText: "+91",
                  //     hintStyle: TextStyle(
                  //       fontSize: 16.0,
                  //       fontFamily: "Roboto",
                  //       fontWeight: FontWeight.w500,
                  //       color: Colors.black,
                  //
                  //     ),
                  //     fillColor: textboxfillcolor,
                  //     contentPadding: EdgeInsets.all(0.0),
                  //     isDense: true,
                  //     enabledBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(color: fontcolor),
                  //     ),
                  //     // enabledBorder: UnderlineInputBorder(
                  //     //   borderSide: BorderSide(color:fontcolor),
                  //     // ),
                  //     focusedBorder: UnderlineInputBorder(
                  //       borderSide: BorderSide(color: fontcolor),
                  //     ),
                  //     disabledBorder:  UnderlineInputBorder(
                  //       borderSide: BorderSide(color: fontcolor),
                  //     ),
                  //     errorBorder: UnderlineInputBorder(
                  //       borderSide: BorderSide(color: fontcolor),
                  //     ),
                  //
                  //   ),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return "error";
                  //     }
                  //     return null;
                  //   },
                  // ),
                  TextFormField(

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
                  width:220,
                  height: 50,
                  color: textboxfillcolor,
                  child:TextFormField(
                     controller: mobileTextController,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                        hintText: "Phone no",
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
                )
              ],
            ),

            // Text(isError?"Enter valid number":""),
            SizedBox(height: 20),
            Container(
              width:280,
              height: 50,
              child: TextFormField(
                controller: passwordTextController,
                  obscureText: !_isPasswordVisible,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                      hintText: "Password",
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
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible; // Toggle password visibility
                          });
                        },
                      )
                  ),
                  keyboardType: TextInputType.text,
                  maxLength: 30),
            ),

            SizedBox(height:size.height*0.05 ,),
            _isLoading
                ? CircularProgressIndicator()
                : TextButton(

              onPressed: (){
    if(validateMobile(mobileTextController.text))
    {
    if(validatePassword(passwordTextController.text))
    {
    loginApiCall();
    }

    }

                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return const ResetPasswordScreen();
                //     },
                //   ),
                // );

              },
              child: Container(
                height: 45,
                width: size.width*0.8,
                decoration: BoxDecoration(
                  color: buttoncolor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Login",
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
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Container(height:30,width: 120,
              child: Text('Forgot Password ?',style:
              TextStyle(fontFamily: "Roboto",fontSize:12,fontWeight: FontWeight.w400,color: buttoncolor ),),),
            )
          ],
        ),
      ),
    );
  }


}
