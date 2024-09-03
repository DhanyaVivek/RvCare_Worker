import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import '../Utils/AppConstants.dart';
import '../common/constant.dart';

class OngoingJobscountApiServices{

  static const String url = baseURL+"api/ongoing-count";
  static Future OngoingJobscountApiCall(
      BuildContext context, String user_id) async {
    print(url);

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(AppConstants.token);
      final String? userId = prefs.getString(AppConstants.id);

      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/x-www-form-urlencoded',
      };


      Map<String, String> params = {"assign":userId.toString()};
      final response =
      await http.post(Uri.parse(url), body: params,headers: headers).timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode ==  200) {
        var responseJson = json.decode(response.body);
        return responseJson;
      }
    } catch (e) {
      print("uuu+$e.toString()");
      Toast.show("Something went wrong",  );
    }

  }
}


