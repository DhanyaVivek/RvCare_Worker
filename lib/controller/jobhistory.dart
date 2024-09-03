import 'package:flutter/material.dart';
import 'package:rccare_workerapp/controller/profileViewScreen.dart';

import '../ApiServices/JobhistoryApi.dart';
import '../Utils/Connectivity.dart';
import '../Utils/Global.dart';
import '../common/constant.dart';
import 'package:toast/toast.dart';
import '../model/modelJobHistory.dart';
import 'completedjobPaymentStatus.dart';
class JobHistoryScreen extends StatefulWidget {
  const JobHistoryScreen({Key? key}) : super(key: key);

  @override
  State<JobHistoryScreen> createState() => _JobHistoryScreenState();
}

class _JobHistoryScreenState extends State<JobHistoryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCall();
  }

  List<Services>? services = [];
  apiCall() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        //await progressDialog.show();
        apiFunc();
      } else {
        Toast.show("Please check your internet connection",
            duration: Toast.lengthShort, gravity: Toast.bottom);
        return;
      }
    });
  }

  apiFunc() {
    JobHistoryApiServices.JobHistoryApiCall(context, Global.shared.id)
        .then((result) async {
      try {
        if (result['id'] != '') {
          setState(() {
            print('hiihh');
            services = ((result['services'] ?? []) as List)
                .map((li) => Services.fromJson(li))
                .toList();
            print(services!.length);
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
        centerTitle: true,
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const MyProfileScreen();
                  },
                ),
              );
            },
          ),
        ),
        title: const Text(
          "Completed Jobs",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
              fontFamily: "Poppins"),
        ),
      ),

      body: Container(
        height: size.height,
        width: size.width,

        child: SingleChildScrollView(
          child: Column(
            children: [
             // (completedservices.length!=0) ?
              SizedBox(
                height: size.height*0.8,
                child:  FutureBuilder(builder: (BuildContext context, snapshot) {
                  return ListView.separated(

                      itemCount:services!.length,
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
                              height: 200,
                              child: Stack(
                                children: [



                                  Positioned(
                                      top: 15,
                                      left: 20,
                                      child: Row(
                                        children:  [
                                          Text(services![index].typeWork.toString(), style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "segoe_ui_semibold",
                                          ),
                                          ),

                                        ],
                                      )
                                  ),
                                  Positioned(
                                      top: 45,
                                      left: 20,
                                      child: Row(
                                        children:  [
                                          Text('Completed on:${services![index].date.toString()}', style: const TextStyle(
                                            color: fontcolor,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "SegoeUI",
                                          ),
                                          ),

                                        ],
                                      )
                                  ),

                                  Positioned(
                                      top: 70,
                                      left: 20,
                                      child: Row(
                                        children:  [
                                          Text('Time :${services![index].time.toString()}', style: const TextStyle(
                                            color: fontcolor,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "SegoeUI",
                                          ),
                                          ),

                                        ],
                                      )
                                  ),
                                  Positioned(
                                      top: 95,
                                      left: 20,
                                      child: Row(
                                        children:  [

                                          Text('Status : ', style:  TextStyle(
                                            color:fontcolor,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "SegoeUI",
                                          ),
                                          ),
                                          Text('Completed',style:  TextStyle(
                                            color:Colors.green,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "SegoeUI",
                                          ))

                                        ],
                                      )
                                  ),

                                  Positioned(
                                    top: 130,
                                    left: 15,
                                    child: Container(
                                      height: 10,width: 300,
                                      //   color: Colors.greenAccent,
                                      child: Divider(
                                        height: 2,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: 150,
                                      left: 20,
                                      child: Row(
                                        children:  [
                                          Text('Payment :  ', style:  TextStyle(
                                            color: fontcolor,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "SegoeUI",
                                          ),
                                          ),
                                          Text('\u{20B9} ', style:  TextStyle(
                                            color: Colors.black87,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "SegoeUI",
                                          ),
                                          ),

                                        ],
                                      )
                                  ),
                                  Positioned(
                                    // top: 20,
                                    left: 270,
                                    child: TextButton(
                                      onPressed: (){
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return  CompltedJobPayStatus(title:services![index].typeWork.toString(),
                                                  cid:services![index].id.toString());
                                            },
                                          ),
                                        );
                                      },
                                      child: const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 26,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),],),));},
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 10,);
                      });
                }
                ),
              )
                  //:
              // Padding(
              //   padding: const EdgeInsets.only(top:300.0),
              //   child: Container(
              //     height:size.height * 1.5 ,
              //
              //     child: Text('Currently there is no completed jobs to show',
              //       style: TextStyle(fontFamily: "Roboto",fontWeight: FontWeight.w400,color: textcolor),
              //
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
