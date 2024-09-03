import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rccare_workerapp/controller/paymentConfirmSucess.dart';
import '../ApiServices/confirmPaymentApi.dart';
import '../Utils/Connectivity.dart';
import '../Utils/Global.dart';
import '../common/constant.dart';
import '../homescreen.dart';
import 'package:toast/toast.dart';
import '../model/modelConfirmPayment.dart';
import 'confirPaymentAlert.dart';
class ConfirmPaymentScreen extends StatefulWidget {
  final String cid;
  const ConfirmPaymentScreen({Key? key, required this.cid}) : super(key: key);

  @override
  State<ConfirmPaymentScreen> createState() => _ConfirmPaymentScreenState();
}

class _ConfirmPaymentScreenState extends State<ConfirmPaymentScreen> {
  @override
  var nameTextController = TextEditingController();
  var paymentdateTextController = TextEditingController();
  var paymenttimeTextController = TextEditingController();
  var remarksTextController=TextEditingController();
 // var paymenttype = TextEditingController();
  var paidamount = TextEditingController();
  TimeOfDay? _selectedTime;
  String dateFormat = '';

  String? payment_mode = 'UPI';

  late ModelConfirmPayment modelConfirmPayment;
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
        paymenttimeTextController.text = _selectedTime!.format(context); // Update the text field
      });
    }
  }
  ConfirmPaymentApi(){
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult){
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
    ConfirmPaymentApiServices.ConfirmPaymentApiCall(context,
       widget.cid, nameTextController.text,
        paymentdateTextController.text,
        paymenttimeTextController.text,
        remarksTextController.text,

        payment_mode!, paidamount.text,
      )
        .then((modelConfirmPayment) async {
      try {
        // modelRequestservice = model!;
        print('hihi');
        // print(modelRequestservice!.message);
        if (modelConfirmPayment?.message !='') {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return PaymentConfirmSucess();
            },
          ),
          );
        } else {
          // Navigator.pop(context);
          Toast.show( "Failed to add data,plese check all field are valid");
        }
      } catch (e) {
        Navigator.pop(context);
        // Toast(model.message.toString(),);
        print(e);
      }
    });
  }

  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themeColor,
      appBar: AppBar(
       // centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.close_rounded,
              size: 26,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
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
          "Confirm Payment",
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0,right: 5,top: 10,bottom: 10),
                  child: Container(
                    height: size.height * 0.1,
                    width: size.width,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: messagebox,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: size.height * 0.04,
                          width: size.width * 0.06,

                          padding: EdgeInsets.only(left: 5),
                          //color: Colors.green,
                          child: Icon(
                            Icons.info_outlined,
                            size: 25,
                            color: Colors.orange,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: EdgeInsets.only(left: 10, right: 20),
                            child: const Center(
                              child: Text(
                                'To mark this job as Completed, please enter'
                                    ' the payment details below. The job status will '
                                    'only be updated to Completed once the payment information is confirmed. ',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Color(0xfffFF7A00),
                                    height: 1.3,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.justify,
                                maxLines: 4, // Limit the text to 2 lines
                                //   overflow: TextOverflow.ellipsis, // Use ellipsis (...) for overflow
                                softWrap: true,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Customer Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(

                       controller: nameTextController,

                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          hintText: "Name",
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
                        keyboardType: TextInputType.text,
                        maxLength: 30),
                  ],
                ),
                SizedBox(height: 15,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * 0.42,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Payment Date',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10,),
                          SizedBox(
                            height: 53,
                            child: TextFormField(
                               controller: paymentdateTextController,
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
                                    print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                    //you can implemen t different kind of Date Format here according to your requirement

                                    setState(() {
                                    paymentdateTextController.text = formattedDate; //set output date to TextField value.
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment Time',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            SizedBox(
                              width:size.width * 0.42,
                              height: 53,
                              child: TextFormField(
                                controller: paymenttimeTextController,
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
                  ],
                ),
                SizedBox(height: 30,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Remarks(Optional)',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: remarksTextController,
                      minLines:
                      3, // any number you need (It works as the rows for the textarea)
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                        hintText: "Description",
                        hintStyle: const TextStyle(
                            fontFamily: "Roboto",
                            color: Colors.black54,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w300),
                        //errorText: _validate ? "Value Can't Be Empty" : null,
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
                      //  keyboardType: TextInputType.text,
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Type of Payment',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Radio<String>(
                          value: 'UPI',
                          groupValue: payment_mode,
                          onChanged: (String? value) {
                            setState(() {
                              payment_mode = value;
                            });
                          },
                        ),
                        Text('UPI'),
                        SizedBox(width: 20),
                        Radio<String>(
                          value: 'Cash',
                          groupValue: payment_mode,
                          onChanged: (String? value) {
                            setState(() {
                              payment_mode = value;
                            });
                          },
                        ),
                        Text('Cash'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Amount Paid',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        controller: paidamount,
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
                SizedBox(height: 30,),
                TextButton(
                  onPressed: (){

                      Future.delayed(
                        const Duration(seconds: 0),
                            () =>  CustomAlert(),);

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
                        "Confirm Payment",
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

CustomAlert() {
  showDialog(context: context,
      builder: (context)
      {
        Size size =MediaQuery.of(context).size;
        //return  ConfirmPaymentAlert();

      return  Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: size.width * 0.8,
              height: size.height * 0.35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Image.asset(
                      'assets/images/confirmimg.png',
                      fit: BoxFit.cover,width: 65,height: 65,
                    ),
                  ),
                  SizedBox(height: 20),
                  Material(
                    color: Colors.white,
                    child: Text(
                      'Confirm Payment',
                      style: TextStyle(fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: textcolor,
                          fontFamily: "Roboto"),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0,right: 20),
                    child: Material(
                      color: Colors.white,
                      child: const Text(
                        'Please review the payment details below.'
                            ' Ensure that the amount and all other information are correct before confirming.',
                        textAlign:TextAlign.center,
                        style: TextStyle(fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: fontcolor,
                            fontFamily: "Roboto",
                            height:1.5
                        ),


                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('No',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,fontFamily: "Roboto",
                            color: textcolor),),
                      ),
                      SizedBox(width: 50,),
                      TextButton(
                        onPressed: () {
                          ConfirmPaymentApi();
                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) {
                          //       return  PaymentConfirmSucess();
                          //     },
                          //   ),
                          // );
                          // Handle decline action
                          // PaymentConfirmSucess()
                        },
                        child: Text('Confirm',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,fontFamily: "Roboto",
                            color: buttoncolor),
                        ),),
                    ],

                  )
                ],
              ),



            ),
          ),
        );
      });
}
}