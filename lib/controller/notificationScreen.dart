import 'package:flutter/material.dart';
import 'package:rccare_workerapp/Utils/Global.dart';

import '../ApiServices/nofiticationApi.dart';
import '../Utils/Connectivity.dart';
import '../common/constant.dart';
import 'package:toast/toast.dart';

import '../model/modelNotification.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    NotifictApiCall();
  }
  List<Notificationlist> notificationlist =[];
  NotifictApiCall() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
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
    NotificationApiServices.NotificationApiCall(context,Global.shared.id)
        .then((result) async {
      try {
          if (result['id'] != '') {
          setState(() {

            notificationlist = ((result[ 'notificationlist'] ?? []) as List)
                .map((li) => Notificationlist.fromJson(li))
                .toList();
          //  print(notificationlist.length);
          });
        } else {
          // Toast.show((value['message'].toString()),
          //     duration: Toast.lengthShort, gravity: Toast.bottom);
        }
        // return _earnings;
      } catch (e) {
        //await progressDialog.hide();
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
          "Notifications",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
              fontFamily: "Poppins"),
        ),
      ),
      // bottomNavigationBar: bottomNav(),
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            const Divider(height: 1,thickness: 0.5,color: Colors.white,),
            SizedBox(
              height: size.height*0.8,

              child:  FutureBuilder(builder: (BuildContext context, snapshot) {
                return ListView.separated(

                    itemCount: notificationlist.length,
                    padding: const EdgeInsets.only(top: 20,bottom: 20,left: 10,right: 10),
                    itemBuilder: (BuildContext context, int index) {
                      return   Card(
                          color: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                              color: Color(0xffe0e0e0),
                            ),
                          ),
                          child: SizedBox(
                            height: 90,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 15,
                                  left: 15,
                                  child: Image(image:AssetImage(
                                    "assets/images/bellimg.png",
                                  ),width:30,height: 30,),

                                ),


                                Positioned(
                                    top: 15,
                                    left: 60,
                                    child: Row(
                                      children:  [
                                        Text(notificationlist[index].title.toString(), style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Roboto",
                                        ),
                                        ),
                                        Text('1 min ago ', style: const TextStyle(
                                          color: fontcolor,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Roboto",
                                        ),
                                        ),

                                      ],
                                    )
                                ),
                                Positioned(
                                    top: 40,
                                    left: 60,
                                    child: Row(
                                      children:  [
                                        Container(
                                          width:size.width* 0.7,
                                          child: Text(notificationlist[index].body.toString(), style: const TextStyle(
                                              color: Color(0xff868ca0),
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Roboto",height: 1.5
                                          ),
                                          ),
                                        ),

                                      ],
                                    )
                                ),

                              ],),));},
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10,);
                    });
              }
              ),),
          ],
        ),
      ),
    );
  }

Widget bottomNav() {
  return BottomNavigationBar(

      // onTap: (index) {
      //   setState(() {
      //     i = index;
      //     print(i);
      //   });
      // },

      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      selectedLabelStyle: const TextStyle(color: selectColor),
      unselectedLabelStyle: const TextStyle(color: selectColor),

      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 5.0),

            child: Image.asset(
             "assets/images/Homeimg.png",

              // color: themeColor,
              height: 22,
              width: 22,
            ),
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Image.asset(

              "assets/images/notifiselect.png",

              //  color: themeColor,
              height: 22,
              width: 22,
            ),
          ),
          label: "Notification",
        ),

        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Image.asset(
              "assets/images/Profile.png",

              //   color: themeColor,
              height: 22,
              width: 22,
            ),
          ),
          label: "My Profile",
        ),
      ],
      type: BottomNavigationBarType.fixed,
      //currentIndex: i,
      backgroundColor: Colors.white,
      iconSize: 30,
      //onTap: _onItemTapped,
      selectedItemColor: selectColor,
      unselectedItemColor: Colors.grey[500],
      elevation: 20);
}}