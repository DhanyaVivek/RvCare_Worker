import 'package:flutter/material.dart';

import 'common/constant.dart';
import 'controller/homepage.dart';
import 'controller/notificationScreen.dart';
import 'controller/profileViewScreen.dart';
class HomeScreen extends StatefulWidget {
  var userid;

   HomeScreen({Key? key, }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int i = 0;
 // var assign='';
  @override
  void initState() {
    super.initState();

  }
  List<Widget> _widgetOptions = <Widget>[
      HomePage(),
   const NotificationScreen(),
    MyProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themeColor,

      bottomNavigationBar: bottomNav(),
      body: Center(child: _widgetOptions.elementAt(i)),


    );
  }
  Widget bottomNav() {
    return BottomNavigationBar(

        onTap: (index) {
          setState(() {
            i = index;
            print(i);
          });
        },

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
                i == 0 ? "assets/images/homeselect.png" : "assets/images/Homeimg.png",

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
                i == 1
                    ? "assets/images/notifiselect.png"
                    : "assets/images/Notification.png",

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
                i == 2
                    ? "assets/images/profileselect.png"
                    : "assets/images/Profile.png",

                //   color: themeColor,
                height: 22,
                width: 22,
              ),
            ),
            label: "My Profile",
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: i,
        backgroundColor: Colors.white,
        iconSize: 30,
        //onTap: _onItemTapped,
        selectedItemColor: selectColor,
        unselectedItemColor: Colors.grey[500],
        elevation: 20);
  }
}
