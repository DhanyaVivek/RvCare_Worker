import 'package:flutter/material.dart';
import 'package:rccare_workerapp/controller/changepassword.dart';
import 'package:rccare_workerapp/controller/resetPassword.dart';
import 'package:toast/toast.dart';
import '../ApiServices/profileApiServices.dart';
import '../Utils/AppConstants.dart';
import '../Utils/Connectivity.dart';
import '../Utils/PreferenceHelper.dart';
import '../common/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../loginScreen.dart';
import '../model/modelprofiledetails.dart';
import 'jobhistory.dart';
class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key,}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  String _name = '';
  String _mobile = "";

  late ProfileDetails profileDetails;
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCall();

  }
  apiCall() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        //await progressDialog.show();
        apiFun();
      } else {
        Toast.show("Please check your internet connection", duration: Toast.lengthShort, gravity:  Toast.bottom);
        return;
      }
    });
  }
  apiFun() {
    // print('abcd');
    MyProfileApiService.myProfileApiCall(context).then((profiledetls) async {
      try {
        print("jkjjkjjkjkjk " + profiledetls.toString());
        setState(() {
          _name = profiledetls!.name.toString();
          _mobile = profiledetls!.mobile.toString();
          print('dddd'+_name.toString());

        });
      }
      catch (e) {
        print(e);
        throw Exception('Failed');
      }

    });
  }


  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: themeColor,
      appBar: AppBar(

        elevation: 0,
        backgroundColor: Colors.white,

        title: const Text(
          "Profile",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
              fontFamily: "Poppins"),
        ),
      ),
      // bottomNavigationBar: bottomNav(),
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Positioned(
              top: 60,
              left: 120,
              child:  Image.asset(
                "assets/images/profileimg.png",
                height: size.height * 0.17,
                width: size.width * 0.35,
                fit: BoxFit.fill,
              ),),
            Positioned(
                top: 200,
                left: 160,
                child: Text(_name,style: TextStyle(fontFamily:"Roboto",
                    fontSize: 24,fontWeight: FontWeight.w500,color: textcolor),)),
            Positioned(
                top: 240,
                left: 120,
                child: Text( '+91 $_mobile',style: TextStyle(fontFamily:"Roboto",
                    fontSize: 15,fontWeight: FontWeight.w400,color: fontcolor),)),

            Positioned(top:270,
                left:15,
                child:  TextButton(
                  onPressed: (){
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) {
                    //       return  EditProfileScreen(userid:widget.userid);
                    //     },
                    //   ),
                    // );


                  },
                  child: Container(
                    height: 49,
                    width: size.width* 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 0.5,
                          color: Colors.black12
                      ),
                    ),
                    child:  Padding(
                      padding: const EdgeInsets.only(left: 18.0,right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:const [
                            Text(
                            "Edit Profile",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: "Roboto",
                              color: textcolor,
                              fontSize: 16,
                            ),

                          ),
                          SizedBox(width:8,),
                           Icon(
                            Icons.arrow_forward_ios,
                            size: 24,
                             color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
            Positioned(top:330,
                left:15,
                child:  TextButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return JobHistoryScreen();
                        },
                      ),
                    );


                  },
                  child: Container(
                    height: 49,
                    width: size.width* 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 0.5,
                          color: Colors.black12
                      ),
                    ),
                    child:  Padding(
                      padding: const EdgeInsets.only(left: 18.0,right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:const [
                          Text(
                            "Job History",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: "Roboto",
                              color: textcolor,
                              fontSize: 16,
                            ),

                          ),
                          SizedBox(width:8,),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 24,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
            Positioned(top:390,
                left:15,
                child:  TextButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return  ResetPassword();
                        },
                      ),
                    );


                  },
                  child: Container(
                    height: 49,
                    width: size.width* 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 0.5,
                          color: Colors.black12
                      ),
                    ),
                    child:  Padding(
                      padding: const EdgeInsets.only(left: 18.0,right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:const [
                          Text(
                            "Change Passwpord",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: "Roboto",
                              color: textcolor,
                              fontSize: 16,
                            ),

                          ),
                          SizedBox(width:8,),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 24,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
            Positioned(top:540,
                left:50,
                child:  TextButton(
                  onPressed: () async{


                    SharedPreferences pref = await SharedPreferences.getInstance();
                    await pref.clear();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) =>  LoginScreen()),
                          (Route<dynamic> route) => false,
                    );


                  },
                  child: Container(
                    height: 45,
                    width: size.width* 0.7,
                    decoration: BoxDecoration(
                      color: themeColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 0.9,
                          color: buttoncolor
                      ),
                    ),
                    child:  Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const  Text(
                            "Logout",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              color: messagecolor,
                              fontSize: 15,
                            ),

                          ),


                          SizedBox(width:8,),
                          Icon(
                            Icons.logout,
                            size: 20,
                            color: messagecolor,
                          ),
                          // Image.asset(
                          //   'assets/images/Edit.png',
                          //   fit: BoxFit.cover,width: 18,height: 23,
                          //   color: buttoncolor,
                          // ),
                        ],
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
