import 'package:flutter/material.dart';
import 'package:rccare_workerapp/Utils/Global.dart';
import 'package:toast/toast.dart';
import 'package:intl/intl.dart';
import '../ApiServices/generateEstimateApi.dart';
import '../Utils/Connectivity.dart';
import '../common/constant.dart';
import '../homescreen.dart';
import 'generateEstimateSucess.dart';
class GenerateEstimate extends StatefulWidget {
  final String cid;
  const GenerateEstimate({Key? key, required this.cid}) : super(key: key);

  @override
  State<GenerateEstimate> createState() => _GenerateEstimateState();
}

class _GenerateEstimateState extends State<GenerateEstimate> {
  var servicedescrTextController = TextEditingController();
  var estimatedateTextController = TextEditingController();
  var estimatetimeTextController = TextEditingController();
  var servicecostTextController=TextEditingController();
  var  meterialcostTextController=TextEditingController();
   var meterialdescrTextController = TextEditingController();
    String dateFormat = '';
  TimeOfDay? _selectedTime;
  @override
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
        estimatetimeTextController.text = _selectedTime!.format(context); // Update the text field
      });
    }
  }
  generateEstimateApi(){
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult){
        apiFunc();
      } else {
        Toast.show("Please check your internet connection",
        );

        return;
      }
    });
  }
  apiFunc() {
    GenerateEstimateApiServices.GenerateEstimateApiCall(context,
      widget.cid,Global.shared.id,servicedescrTextController.text,
      servicecostTextController.text,
      estimatedateTextController.text,
      estimatetimeTextController.text,
      meterialdescrTextController.text,
      meterialcostTextController.text
       )
        .then((modelConfirmPayment) async {
      try {
           // print('hihi');
        if (modelConfirmPayment?.message != null) {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return EstimategenSucess();
            },
          ),
          );
        } else {
          Toast.show("Failed to add data, please check all fields are valid"); // Show an error toast
        }
      } catch (e) {
        Navigator.pop(context);
        print(e); // Print any caught exceptions for debugging
      }
    });
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themeColor,
      appBar: AppBar(
      //  centerTitle: true,
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
        title: const Text(
          "Generate Estimate",
          style: TextStyle(
              color: textcolor,
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
              fontFamily: "Poppins"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0,right: 15,top: 20),
        child: Container(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Service Description',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                       controller: servicedescrTextController,
                      minLines:
                      3, // any number you need (It works as the rows for the textarea)
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                       // hintText: _description,
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
                SizedBox(height: 15,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Service Cost',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        controller: servicecostTextController,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 25.0,top: 12), // padding to align the icon with text
                            child: Text(
                              '₹ |',
                              style: TextStyle(fontSize: 18.0,color: Colors.black54),
                            ),
                          ),
                          hintText: "Amount",
                          hintStyle: const TextStyle(
                              fontFamily: "Roboto",
                              color: Colors.black54,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w300),
                          //    errorText: _validate ? "Please enter location" : null,
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
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 30),

                  ],
                ),
                SizedBox(height: 15,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * 0.42 ,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Estimated Finishing Date',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10,),
                          SizedBox(
                            height: 53,
                            child: TextFormField(
                                controller: estimatedateTextController,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w300),
                                decoration: InputDecoration(
                                  hintText: "DD/MM/YYYY",
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
                                ),
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context, initialDate: DateTime.now(),
                                    firstDate: DateTime(1950), //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime.now().add(Duration(days: 365)),
                                  );

                                  if(pickedDate != null ){
                                    print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                                 //   print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                    //you can implemen t different kind of Date Format here according to your requirement

                                    setState(() {
                                      estimatedateTextController.text = formattedDate; //set output date to TextField value.
                                    });
                                  }else{
                                    print("Date is not selected");
                                  }
                                }
                            ),
                          ),

                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: size.width * 0.43,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Estimated Finishing Time',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              SizedBox(
                                width:size.width * 0.40,
                                height: 53,
                                child: TextFormField(
                                  controller: estimatetimeTextController,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w300),
                                  decoration: InputDecoration(
                                    hintText: "00:00 ",
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
                                  ),
                                  keyboardType: TextInputType.number,
                                  maxLength: 3,
                                  onTap: () {
                                    _selectTime(context);



                                  },

                                ),
                              ),

                            ],
                          ),


                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Meterial Description',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: meterialdescrTextController,
                      minLines:
                      3, // any number you need (It works as the rows for the textarea)
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                        // hintText: _description,
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
                SizedBox(height: 15,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Meterial Cost',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        controller: meterialcostTextController,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 25.0,top: 12), // padding to align the icon with text
                            child: Text(
                              '₹ |',
                              style: TextStyle(fontSize: 18.0,color: Colors.black54),
                            ),
                          ),
                          hintText: "Amount",
                          hintStyle: const TextStyle(
                              fontFamily: "Roboto",
                              color: Colors.black54,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w300),
                          //    errorText: _validate ? "Please enter location" : null,
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
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 30),

                  ],
                ),
                SizedBox(height: 15,),
                TextButton(
                  onPressed: (){
                       generateEstimateApi();

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
                        "Generate and send Estimate",
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
        ),
      ),

    );
  }
}
