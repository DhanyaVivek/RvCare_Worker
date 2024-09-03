import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';
import '../Utils/AppConstants.dart';
import '../Utils/Global.dart';
import 'package:http/http.dart' as http;
import '../common/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
class NotificationApiServices{

  static const String url = baseURL+"api/worker-notifications";
  static Future NotificationApiCall(
      BuildContext context, String user_id) async {
    //  print(url);

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(AppConstants.token);
      final String? userId = prefs.getString(AppConstants.id);


      // print(reg_type + gender + experience + job_type + job_cat  );


      print("accessss==$accessToken");
      // print(accessToken);
      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/x-www-form-urlencoded',
      };


      Map<String, String> params = {"customer_id":userId.toString()};
      final response =
      await http.post(Uri.parse(url), body: params,headers: headers).timeout(const Duration(seconds: 30));
      print(response.body);
      var responseJson = json.decode(response.body);
      if (response.statusCode == 200) {

        return responseJson;
      }
    } catch (e) {
      print("uuu+$e.toString()");
      Toast.show("Something went wrong",  );
    }

  }
}


