import 'package:flutter/material.dart';

import '../common/constant.dart';
import '../homescreen.dart';
class EstimategenSucess extends StatelessWidget {
  const EstimategenSucess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,

      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: themeColor,
          actions: [
            IconButton(
              icon: const Icon(Icons.close_rounded,color: Colors.black87,),
              tooltip: 'Open shopping cart',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return  HomeScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
        body: Container(
          color: themeColor,
          height: size.height,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset(
                    "assets/images/success.png",

                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox( height: 15,),
                Text('Yay!',
                  style: TextStyle(
                    fontSize: 30,
                    color: textcolor,

                  ),),
                SizedBox( height: 20,),
                Center(
                  child: Text('Your estinmate has been generated and sent\n successfully.',
                      style: TextStyle(
                          fontSize: 14,
                          color: textcolor,
                          height:1.5
                      ), textAlign: TextAlign.center),
                ),



              ],
            ),
          ),
        ),

      ),
    );
  }
}
