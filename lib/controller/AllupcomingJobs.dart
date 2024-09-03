import 'package:flutter/material.dart';

import '../ApiServices/allUpcomingJobApi.dart';
import '../Utils/Connectivity.dart';
import '../Utils/Global.dart';
import '../common/constant.dart';
import '../homescreen.dart';
import '../model/modelUpcomingJobs.dart';
import 'package:toast/toast.dart';

import 'assignedjobDetails.dart';
class AllUpcommingJobs extends StatefulWidget {
  final String userid;
  const AllUpcommingJobs({Key? key, required this.userid}) : super(key: key);

  @override
  State<AllUpcommingJobs> createState() => _AllUpcommingJobsState();
}

class _AllUpcommingJobsState extends State<AllUpcommingJobs> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCall();
  }

  List<Upcomingservices> upcomingservices = [];
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
    AllUpcomingjobsApiServices.AllUpcomingjobsApiCall(context, Global.shared.id)
        .then((result) async {
      try {
        if (result['id'] != '') {
          setState(() {
            print('hiihh');
            upcomingservices = ((result['upcomingservices'] ?? []) as List)
                .map((li) => Upcomingservices.fromJson(li))
                .toList();
            print(upcomingservices.length);
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
    Size size =MediaQuery.of(context).size;
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
              return  HomeScreen();
            },
          ),
        );
      },
    ),
    ),
    title: const Text(
    "All Upcoming Jobs",
    style: TextStyle(
    color: textcolor,
    fontWeight: FontWeight.w700,
    fontSize: 16.0,
    fontFamily: "Poppins"),
    ),
    ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: size.height,
          width: size.width,
          child:  SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height*0.9,
    child: FutureBuilder(
    builder: (BuildContext context, snapshot) {
      return ListView.separated(

        itemCount: upcomingservices.length,
        padding: const EdgeInsets.only(top: 20, bottom: 20,),
        itemBuilder: (BuildContext context, int index) {
          return Card(
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
                        Icon(Icons.person, color: Color(0xffFF7474),),
                        SizedBox(width: 5,),
                        Text(upcomingservices[index].name.toString()),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.phone, color: Color(0xffFF7474),),
                        SizedBox(width: 5,),
                        Text('+91 ${upcomingservices[index].name}'),
                        SizedBox(width: 60,),
                        ElevatedButton(

                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.phone, color: Colors.white),
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
                        Icon(Icons.location_on, color: Color(0xffFF7474),),
                        SizedBox(width: 5,),
                        Text(upcomingservices[index].location.toString()),
                      ],
                    ),
                    SizedBox(height: 20),
                    Divider(height: 2, thickness: 1, color: textboxfillcolor,),
                    SizedBox(height: 20),
                    Text(upcomingservices[index].typeWork.toString(),
                      style: TextStyle(fontWeight: FontWeight.w600,
                          fontFamily: "Roboto",
                          fontSize: 14),),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text('Scediuled on : ',
                            style: TextStyle(fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                                fontSize: 13,
                                color: Colors.black45)),
                        Text('Tomorrow', style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: "Roboto",
                            fontSize: 13,
                            color: buttoncolor))

                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text('Time : ',
                            style: TextStyle(fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                                fontSize: 13,
                                color: Colors.black45)),
                        Text(upcomingservices[index].time.toString(), style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: "Roboto",
                            fontSize: 13,
                            color: Colors.black87))

                      ],
                    ),
                    SizedBox(height: 10,),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return  AssignedJobDetails(title: upcomingservices[index].typeWork.toString(),
                                customerid: widget.userid,);
                            },
                          ),
                        );
                      },
                      child: Container(
                        height: 45,
                        width: size.width * 0.75,
                        decoration: BoxDecoration(
                          color: themeColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              width: 0.8,
                              color: buttoncolor
                          ),
                        ),
                        child: Center(
                          child: Text('View Details',
                            style: TextStyle(fontFamily: "Roboto",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: buttoncolor),),),


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
            ),
          ),
        ),
      ),
    );
  }
}
