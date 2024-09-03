import 'package:flutter/material.dart';

import 'common/constant.dart';
import 'homescreen.dart';
class NewPasswordReset extends StatefulWidget {
  const NewPasswordReset({Key? key}) : super(key: key);

  @override
  State<NewPasswordReset> createState() => _NewPasswordResetState();
}

class _NewPasswordResetState extends State<NewPasswordReset> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isObscure = false;
  dynamic _mob = '';
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
                            "One more Final Step! ",
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
                  left: 100,
                  child: Text('Please enter your new password.',

                    style: TextStyle(fontWeight: FontWeight.w400,
                      fontSize:11,),
                  ),),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0,right: 18),
                  child: Divider(
                    height: 2,
                    color: Colors.black26,
                  ),
                ),
                Positioned(
                  top:  size.height * 0.45,
                  left: 35,
                  child: Container(
                      height: 30,
                      width: 100,
                      child: Text(
                        'New Password',
                        style: TextStyle(fontSize: 11, fontFamily: "Roboto",fontWeight: FontWeight.w500),
                      )),
                ),
                Positioned(top: size.height * 0.48, child: ResetWidget())

              ],
            ),
          ),
        )
    );
  }
  Widget ResetWidget() {
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
            Container(
              width:280,
              height: 50,
              child: TextFormField(
                // controller: name,
                  obscureText: _isObscure,
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
                          icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          }
                      )
                  ),
                  keyboardType: TextInputType.text,
                  maxLength: 30),
            ),

            // Text(isError?"Enter valid number":""),

            SizedBox(height:size.height*0.05 ,),
            TextButton(
              onPressed: (){
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return const HomeScreen();
                //     },
                //   ),
                // );

              },
              child: Container(
                height: 45,
                width: size.width*0.9,
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
