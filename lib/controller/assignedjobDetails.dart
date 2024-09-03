import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../ApiServices/AssignedJobDetailsApi.dart';
import '../ApiServices/ongoingStatusApi.dart';
import '../Utils/Connectivity.dart';
import '../Utils/Global.dart';
import '../common/constant.dart';
import '../homescreen.dart';
import 'confirmpayment.dart';
import 'generateEstimate.dart';

class AssignedJobDetails extends StatefulWidget {
  final String customerid;
  final String title;
  const AssignedJobDetails(
      {Key? key, required this.customerid, required this.title})
      : super(key: key);

  @override
  State<AssignedJobDetails> createState() => _AssignedJobDetailsState();
}

class _AssignedJobDetailsState extends State<AssignedJobDetails> {
  String? _selectedPaymentType = 'Yet to be started';

  String _typework = '';
  String _name = '';
  String _date = '';
  String _time = '';
  String _location = '';
  String _address = '';
  String _mobile = '';
  String _description = '';
  String _status = '';
  String _changestatus = '';

  @override
  void initState() {
    super.initState();
    ApiCall();
  }

  ApiCall() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        //await progressDialog.show();
        apiFunc();
      } else {
        Toast.show(
          "Please check your internet connection",
        );

        return;
      }
    });
  }

  apiFunc() {
    AssignedJobDetailsApiServices.AssignedJobDetailsApiCall(
            context, widget.customerid)
        .then((result) async {
      try {
        // print('object');
        setState(() {
          _name = result['name'].toString();
          _typework = result['type_work'].toString();
          _date = result['date'].toString();
          _time = result['time'].toString();
          _location = result['location'].toString();
          _address = result['address'].toString();
          _mobile = result['mobile'].toString();
          _description = result['description'].toString();
          _status = result['status'].toString();
          //  print('dddd'+_typework.toString());
          if (_status == '2') {
            _changestatus = "Yet to be started";
          } else if (_status == '3') {
            _changestatus = "On-going";
          } else {
            _changestatus = "Completed";
          }
        });

        // return _earnings;
      } catch (e) {
        //await progressDialog.hide();
      }
    });
  }

  ongoingStatusUpdateApi() {
    OngoingStatusApiServices.OngoingStatusApiCall(
            context, widget.customerid, Global.shared.id)
        .then((result) async {
      try {
        if (result['id'] != '') {
          Toast.show(result['message'].toString());
        }
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
                    return HomeScreen();
                  },
                ),
              );
            },
          ),
        ),
        title: Text(
          widget.title,
          style: TextStyle(
              color: textcolor,
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
              fontFamily: "Poppins"),
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        // color:Colors.greenAccent,

        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: size.width,
                  height: size.height,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 20, left: 10),
                            child: Row(
                              children: [
                                Container(
                                  width: 220, height: 20,
                                  // color: Colors.orange,

                                  child: Text(
                                    'Job Details',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: textcolor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                IconButton(
                                  icon: new Icon(
                                    Icons.keyboard_control,
                                    size: 26,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20),
                                        ),
                                      ),
                                      builder: (BuildContext context) {
                                        return SizedBox(
                                          height: 200,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 30.0,
                                                            left: 30),
                                                    child: Container(
                                                      width: 210,
                                                      height: 30,
                                                      child: Text(
                                                        'More Options',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                "Roboto",
                                                            color: textcolor),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 20),
                                                  IconButton(
                                                    icon: const Icon(
                                                      Icons.close_rounded,
                                                      size: 23,
                                                      color: Colors.black,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              ),
                                              // ListTile(
                                              //
                                              //   title: Text('More Options'),
                                              //   trailing: Icon(Icons.more_vert),
                                              // ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    showModalBottomSheet(
                                                      context: context,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .vertical(
                                                          top: Radius.circular(
                                                              20),
                                                        ),
                                                      ),
                                                      builder: (BuildContext
                                                          context) {
                                                        return SizedBox(
                                                          height: 250,
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            40.0,
                                                                        left:
                                                                            30),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          250,
                                                                      height:
                                                                          30,
                                                                      child:
                                                                          Text(
                                                                        'Select Job Status',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight: FontWeight
                                                                                .w500,
                                                                            fontFamily:
                                                                                "Roboto",
                                                                            color:
                                                                                textcolor),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          20),
                                                                  IconButton(
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .close_rounded,
                                                                      size: 23,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                              // ListTile(
                                                              //
                                                              //   title: Text('More Options'),
                                                              //   trailing: Icon(Icons.more_vert),
                                                              // ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10.0),
                                                                child: Column(
                                                                  children: [
                                                                    ListTile(
                                                                      title: Text(
                                                                          'Yet to be started'),
                                                                      leading:
                                                                          Radio<
                                                                              String>(
                                                                        value:
                                                                            'Yet to be started',
                                                                        groupValue:
                                                                            _selectedPaymentType,
                                                                        onChanged:
                                                                            (String?
                                                                                value) {
                                                                          setState(
                                                                              () {
                                                                            _selectedPaymentType =
                                                                                value;
                                                                          });
                                                                        },
                                                                      ),
                                                                    ),
                                                                    ListTile(
                                                                      title: Text(
                                                                          'On-going'),
                                                                      leading:
                                                                          Radio<
                                                                              String>(
                                                                        value:
                                                                            'On-going',
                                                                        groupValue:
                                                                            _selectedPaymentType,
                                                                        onChanged:
                                                                            (String?
                                                                                value) {
                                                                          setState(
                                                                              () {
                                                                            _selectedPaymentType =
                                                                                value;
                                                                          });
                                                                          ongoingStatusUpdateApi();
                                                                        },
                                                                      ),
                                                                    ),
                                                                    ListTile(
                                                                      title: Text(
                                                                          'Completed'),
                                                                      leading:
                                                                          Radio<
                                                                              String>(
                                                                        value:
                                                                            'Completed',
                                                                        groupValue:
                                                                            _selectedPaymentType,
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            _selectedPaymentType =
                                                                                value!;
                                                                          });
                                                                          Navigator
                                                                              .pushReplacement(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                              builder: (context) {
                                                                                return  ConfirmPaymentScreen(cid:widget.customerid);
                                                                              },
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: ListTile(
                                                    leading: Icon(
                                                      Icons.edit_outlined,
                                                      color: buttoncolor,
                                                    ),
                                                    title: Text(
                                                      'Change Job Status',
                                                      style: TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: textcolor),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) {
                                                          return GenerateEstimate(cid:widget.customerid);
                                                        },
                                                      ),
                                                    );
                                                  },
                                                  child: ListTile(
                                                    leading: Icon(
                                                      Icons
                                                          .text_snippet_outlined,
                                                      color: buttoncolor,
                                                    ),
                                                    title: Text(
                                                        'Generate Estimate',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Roboto",
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: textcolor)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10),
                            child: Divider(
                              height: 10,
                              color: fontcolor,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Customer Name',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(

                                  // controller: name,

                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400),
                                  decoration: InputDecoration(
                                    hintText: _name,
                                    hintStyle: const TextStyle(
                                        fontFamily: "Roboto",
                                        color: fontcolor,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400),
                                    //   fillColor: greyColor,
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
                                  keyboardType: TextInputType.text,
                                  maxLength: 30),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: size.width * 0.38,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Job Status',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: size.width * 0.38,
                                      child: TextFormField(
                                        // controller: _changestatus,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w300),
                                        decoration: InputDecoration(
                                          hintText: _changestatus,
                                          hintStyle: const TextStyle(
                                              fontFamily: "Roboto",
                                              color: fontcolor,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w300),
                                          // fillColor: greyColor,
                                          filled: true,
                                          counterText: "",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                        ),
                                        onTap: () async {},
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Estimate Status',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 45,
                                    width: size.width * 0.35,
                                    child: TextFormField(
                                        //controller: nomineeAgeTextController,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w300),
                                        decoration: InputDecoration(
                                          hintText: "Nil",
                                          hintStyle: const TextStyle(
                                              fontFamily: "Roboto",
                                              color: Colors.blue,
                                              fontSize: 14.0,
                                              letterSpacing: 0.5,
                                              fontWeight: FontWeight.w400),
                                          //  fillColor: greyColor,
                                          filled: true,
                                          counterText: "",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                        ),
                                        keyboardType: TextInputType.number,
                                        maxLength: 3),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Type of work',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(

                                  // controller: name,

                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400),
                                  decoration: InputDecoration(
                                    hintText: _typework,
                                    hintStyle: const TextStyle(
                                        fontFamily: "Roboto",
                                        color: fontcolor,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400),
                                    // fillColor: greyColor,
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
                                  keyboardType: TextInputType.text,
                                  maxLength: 30),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: size.width * 0.35,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Date',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 45,
                                      child: TextFormField(
                                        // controller: nomineeDobTextController,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w300),
                                        decoration: InputDecoration(
                                          hintText: _date,
                                          hintStyle: const TextStyle(
                                              fontFamily: "Roboto",
                                              color: fontcolor,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w400),
                                          //fillColor: greyColor,
                                          filled: true,
                                          counterText: "",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                        ),
                                        onTap: () async {},
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Time',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 45,
                                    width: size.width * 0.39,
                                    child: TextFormField(
                                        //controller: nomineeAgeTextController,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w300),
                                        decoration: InputDecoration(
                                          hintText: _time,
                                          hintStyle: const TextStyle(
                                              fontFamily: "Roboto",
                                              color: fontcolor,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w400),
                                          //  fillColor: greyColor,
                                          filled: true,
                                          counterText: "",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                        ),
                                        keyboardType: TextInputType.number,
                                        maxLength: 3),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Location',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(

                                  // controller: name,

                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400),
                                  decoration: InputDecoration(
                                    hintText: _location,
                                    hintStyle: const TextStyle(
                                        fontFamily: "Roboto",
                                        color: fontcolor,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400),
                                    // fillColor: greyColor,
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
                                  keyboardType: TextInputType.text,
                                  maxLength: 30),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Contact Number',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(

                                  // controller: name,

                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400),
                                  decoration: InputDecoration(
                                    hintText: "+91 | ${_mobile}",
                                    hintStyle: const TextStyle(
                                        fontFamily: "Roboto",
                                        color: fontcolor,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400),
                                    //fillColor: greyColor,
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
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Location/Address',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                // controller: name,
                                minLines:
                                    4, // any number you need (It works as the rows for the textarea)
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400),
                                decoration: InputDecoration(
                                  hintText: _location,
                                  hintStyle: const TextStyle(
                                      fontFamily: "Roboto",
                                      color: Colors.black54,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w300),
                                  //fillColor: greyColor,
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
                                //  keyboardType: TextInputType.text,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Description',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                // controller: name,
                                minLines:
                                    3, // any number you need (It works as the rows for the textarea)
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400),
                                decoration: InputDecoration(
                                  hintText: _description,
                                  hintStyle: const TextStyle(
                                      fontFamily: "Roboto",
                                      color: Colors.black54,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w300),
                                  //  fillColor: greyColor,
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
                                //  keyboardType: TextInputType.text,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Other widget properties like padding, alignment, etc.
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
