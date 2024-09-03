import 'package:flutter/material.dart';
import 'package:rccare_workerapp/Utils/Global.dart';
import 'package:rccare_workerapp/common/constant.dart';
import 'package:rccare_workerapp/model/modelprofiledetails.dart';

import '../ApiServices/TotaljobcontApi.dart';
import '../ApiServices/latestScheduleApi.dart';
import '../ApiServices/ongoingJobCountApi.dart';
import '../ApiServices/profileApiServices.dart';
import '../ApiServices/todaysJobContApi.dart';
import '../Utils/Connectivity.dart';
import '../model/modelAssignedjobsTwolist.dart';
import 'AllupcomingJobs.dart';
import 'assignedjobDetails.dart';
import 'assignedjobScreen.dart';
import 'package:toast/toast.dart';

import 'ongoingjobs.dart';

class HomePage extends StatefulWidget {
// final String token;
// final String  userid;

   HomePage({Key? key,}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _id = '';
  String _name = '';
  String _mobile = "";
  String _totalcount='';
  String _todayscount='';
 String  _ongoingjobcount='';
  late ProfileDetails profileDetails;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   apiCall();
    totaljoncountapiFunc();
    todaysjobcountapiFunc();
    jobscheduleapiFunc();
    ongoingJobCountApiFun();
    }
  List<Latestschedules> latestschedules =[];
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
          _id = profiledetls!.userid.toString();
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
  //total job count assigned for worker
  totaljoncountapiFunc() {
    TotalJobCountApi.TotalJobCountApiCall(context,Global.shared.userId)
        .then((result) async {
      try {
        setState(() {
          _totalcount = result['count'].toString();
                  });

            } catch (e) {
        //await progressDialog.hide();
      }
    });
  }
  //today job count
  todaysjobcountapiFunc() {
    TodaysjobcountApiService.TodaysjobCountApiCall(context, Global.shared.id)
        .then((result) async {
      try {
        setState(() {
          _todayscount = result['count'].toString();
                });
      } catch (e) {
        //await progressDialog.hide();
      }
    });
  }
  jobscheduleapiFunc() {
    LatestScheduleApiServices.LatestScheduleApiCall(context, Global.shared.id)
        .then((result) async {
      try {

        if (result['id'] != '') {
          setState(() {
            print('hiihh');
            latestschedules = ((result[ 'latestschedules'] ?? []) as List)
                .map((li) => Latestschedules.fromJson(li))
                .toList();
          //  print(latestschedules.length);

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
  ongoingJobCountApiFun() {
    // print('abcd');
    OngoingJobscountApiServices.OngoingJobscountApiCall(context,Global.shared.id).then((result) async {
      try {
        setState(() {
          _ongoingjobcount = result['count'].toString();
        });
      } catch (e) {
        //await progressDialog.hide();
      }
    });
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container (
        width: size.width,
        height: size.height,
        child:SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.only(top: 50.0,left: 15,right: 15),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
      height: size.height * 0.15,
      width: size.width,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: buttoncolor,
        ),

        child: Padding(
    padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children:  [
                  Text(
                    'Hi,$_name !',
                    style: TextStyle(color: textcolor,fontFamily: "Roboto",fontSize: 18,fontWeight:FontWeight.w700),

                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    width:150,
                    child: Divider(
                      color: textboxfillcolor,
                      thickness:0.5,
                    ),
                  ),

                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return AllUpcommingJobs(userid:_id.toString());
                          },
                        ),
                      );
                    },
                    child: Text(
                      'Upcoming Jobs',
                      style: TextStyle(color: Colors.white,fontFamily: "Roboto",fontSize: 13,fontWeight:FontWeight.w500),
                    ),
                  ),
                ],
              ),
            SizedBox(width:30,),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              color: Colors.white,
              width: 0.5,
            ),
              SizedBox(width: 30,),
              Text(
                _totalcount,
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20.0,left: 5),
                child: Text('Jobs', style: TextStyle(color: Colors.white, fontSize: 13,fontWeight: FontWeight.w400,fontFamily: "Roboto"),),
              )
            ],
          ),
        ),
      ),
      SizedBox(height: 10,),
      Container(
        height: size.height * 0.08,
        width: size.width,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xffFF9533),
        ),

        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'On-going Jobs',
                style: TextStyle(color: Colors.white,fontFamily: "Roboto",fontSize: 13,fontWeight:FontWeight.w500),
              ),
              SizedBox(width:30,),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                color: Colors.white,
                width: 0.5,
              ),
              SizedBox(width: 30,),
              Text(
                _ongoingjobcount,
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 6.0,left: 5),
                child: Text('Jobs(s)', style: TextStyle(color: Colors.white, fontSize: 13,fontWeight: FontWeight.w400,fontFamily: "Roboto"),),
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 24,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return OngoingJobs();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
       SizedBox(height: 20,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Assigned Jobs Today ($_todayscount)',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(width: 10),
          OutlinedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const AssignedJobScreen();
                  },
                ),
              );

            },
            child: Text('View All'),
            style: OutlinedButton.styleFrom(
              shape: StadiumBorder(),
            ),
          )
        ],

      ),

      SizedBox(height: 8),
      Column(
        children: [
          SizedBox(height: size.height*0.8,
            child:  FutureBuilder(builder: (BuildContext context, snapshot) {
            return ListView.separated(

    itemCount: latestschedules.length,
    padding: const EdgeInsets.only(top: 20,bottom: 5,),
    itemBuilder: (BuildContext context, int index) {
      return   Card(
            margin: EdgeInsets.only(top: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.person,color: Color(0xffFF7474),),SizedBox(width: 5,),
                Text(latestschedules[index].name.toString()),
              ],
            ),
            Row(
              children: [
                Icon(Icons.phone,color: Color(0xffFF7474),),SizedBox(width: 5,),
                Text('+91 ${latestschedules[index].mobile.toString()}'),
        SizedBox(width: 60,),
            ElevatedButton(

                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.phone,color: Colors.white),
                      SizedBox(width: 8,),
                      Text('Call')
                    ],
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: StadiumBorder(),
                    backgroundColor: Colors.green
                  ),
                )
              ],
            ),
            Row(
              children: [
                Icon(Icons.location_on,color: Color(0xffFF7474),),SizedBox(width: 5,),
                Text(latestschedules[index].location.toString()),
              ],
            ),
            SizedBox(height: 20),
            Divider(height: 2,thickness: 1,color: textboxfillcolor,),
            SizedBox(height: 20),Text(latestschedules[index].typeWork.toString(),
            style: TextStyle(fontWeight: FontWeight.w600,fontFamily: "Roboto",fontSize: 14),),
            SizedBox(height: 10,),
            Row(
              children: [
                Text('Scediuled on : ',
                    style: TextStyle(fontWeight: FontWeight.w400,fontFamily: "Roboto",fontSize: 13,color: Colors.black45)),
                Text('Today',style: TextStyle(fontWeight: FontWeight.w500,fontFamily: "Roboto",fontSize: 13,color: buttoncolor))

              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Text('Time : ',
                    style: TextStyle(fontWeight: FontWeight.w400,fontFamily: "Roboto",fontSize: 13,color: Colors.black45)),
                Text(latestschedules[index].time.toString(),style: TextStyle(fontWeight: FontWeight.w500,fontFamily: "Roboto",fontSize: 13,color: Colors.black87))

              ],
            ),
             SizedBox(height: 10,),
             TextButton(
              onPressed: (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return  AssignedJobDetails(customerid: latestschedules[index].id.toString(),title: latestschedules[index].typeWork.toString(),);
                    },
                  ),
                );
              },
              child: Container(
                height: 45,
                width: size.width* 0.75,
                decoration: BoxDecoration(
                  color: themeColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      width: 0.8,
                      color: buttoncolor
                  ),
                ),
                child:  Center(
                  child: Text('View Details',
                    style: TextStyle(fontFamily: "Roboto",fontSize: 14,fontWeight: FontWeight.w400,color: buttoncolor),),          ),



                ),
              ),



        ],
        ),
      ));

    },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10,);
              },
            );
          })
          )
        ],
      )

      ])),
    )));
  }
}
