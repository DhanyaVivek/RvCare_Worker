
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/AppConstants.dart';
import '../common/constant.dart';
import '../model/modelConfirmPayment.dart';


class GenerateEstimateApiServices{
  static const String url = "${baseURL}api/status-detailupcoming";

  static Future<ModelConfirmPayment?> GenerateEstimateApiCall(BuildContext context,
      String id, String assign, String servicedescr, String servicecost, String estimatedate,
      String estimatetime, String meterialdescr,String meterialcost ) async {
    try {

      print('id $id');
      print('servicedescription $servicedescr');
      print('servicecost $servicecost');
      print('estdate $estimatedate');
      print('estTime $estimatetime');
      print('mneterailDescription $meterialdescr');
      print('mneterailcost $meterialcost');

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(AppConstants.token);
      final String? userId = prefs.getString(AppConstants.id);


      print(userId);


      print("accessss==$accessToken");
      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/x-www-form-urlencoded'
      };

      print('token');
      var formData = FormData.fromMap({
        "id": id,
        "assign":userId,
        "service_offered":servicedescr,
        "service_price":servicecost,
        "estimate_date":estimatedate,
        "est_time":estimatetime,
        "material":meterialdescr,
        "material_price":meterialcost,



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
