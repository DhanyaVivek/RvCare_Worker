import 'package:flutter/material.dart';

import '../Utils/Connectivity.dart';
import '../common/constant.dart';
import '../homescreen.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  @override
  bool validatePassword(String value) {
    if (value.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('The password field is mandatory')));
      return false;
      //exit(0);
    }
    return true;
  }


  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themeColor,
      appBar: AppBar(
        // centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 26,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return HomeScreen();
                  },
                ),
              );
            },
          ),
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: size.height * 0.05,
                  width: size.width * 0.9,
                //  color: messagebox,
                  child:Text('Change Password',
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,fontFamily: "Roboto",color: textcolor),)
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: size.height * 0.06,
                    width: size.width * 0.9,
                   // color: messagebox,
                    child: Text(
                      'Please provide your current password below'
                      ' to confirm your identity and ensure the security of your account.',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                        fontFamily: "Roboto",color: textcolor,height: 1.3
                      ),
                      textAlign: TextAlign.justify,
                    )),
                SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Current Password',style: TextStyle(fontSize:11,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Roboto",color: textcolor),),
                    SizedBox(height: 10,),

                    Container(
                      width:size.width * 0.9,
                      height: 50,
                      child: TextFormField(
                         // controller: passwordTextController,
                        //  obscureText: !_isPasswordVisible,
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
                  ],
                ),
                SizedBox(height: 15,),
                Divider(height: 1,thickness: 1,color: Colors.black26,),
                SizedBox(height: 15,),
                _isLoading
                    ? CircularProgressIndicator()
                    :
                TextButton(

                  onPressed: (){


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
                    width: size.width*0.9,
                    decoration: BoxDecoration(
                      color: buttoncolor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Continue",
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
                Center(
                  child: Container(height:30,width: 120,
                    child: Text('Forgot Password ?',style:
                    TextStyle(fontFamily: "Roboto",fontSize:12,fontWeight: FontWeight.w400,color: Colors.blue ),),),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
