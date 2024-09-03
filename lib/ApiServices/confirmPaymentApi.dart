import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/AppConstants.dart';
import '../common/constant.dart';
import '../model/modelConfirmPayment.dart';


class ConfirmPaymentApiServices{
  static const String url = "${baseURL}api/status-complete";

  static Future<ModelConfirmPayment?> ConfirmPaymentApiCall(BuildContext context,
      String id, String assign, String paymentdate, String paymenttime, String remarks,
      String paymentmode, String amount, ) async {
    try {

      print('id $id');
      print('date $paymentdate');
      print('time $paymenttime');
      print('remarks $remarks');
      print('paymentmode $paymentmode');
      print('amount $amount');
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(AppConstants.token);
      final String? userId = prefs.getString(AppConstants.id);


      // print(reg_type + gender + experience + job_type + job_cat  );


      print("accessss==$accessToken");
      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
      print('token');
      var formData = FormData.fromMap({
        "id": id,
        "assign":userId,
        "payment_date":paymentdate,
        "payment_time":paymenttime,
        "remark":remarks,
        "payment_mode":paymentmode,
        "amnt":amount,



      });
      print(formData);
      Dio dio = Dio();
      final response = await dio.post(
        url,
        options: Options(
          headers: headers,),
        // options: RequestOptions(headers: headers, baseUrl: url),
        data: formData,
        onSendProgress: (received, total) {

        },
      );
      print(response.statusCode);
      var responseJson = response.data;
      print(responseJson);

      return responseJson;
    } catch (e) {
      if (e is DioError) {
        print('jiihihihihigugtdrtd${e.response}');
        print(' ${e.response?.statusCode}');
      }
    }


  }
}
