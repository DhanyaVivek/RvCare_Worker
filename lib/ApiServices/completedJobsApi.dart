import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';
import '../Utils/AppConstants.dart';
import '../Utils/Global.dart';
import 'package:http/http.dart' as http;
import '../common/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompletejobdetailsApiServices{

  static const String url = baseURL+"api/detailupcoming";
  static Future CompletejobdetailsApiCall(
      BuildContext context, String cid) async {
    // print(userid);

    try {
      print(cid);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(AppConstants.token);
      final String? userId = prefs.getString(AppConstants.id);
      //   print(accessToken);
      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/x-www-form-urlencoded',
      };


      Map<String, String> params = {"id":cid.toString()};
      final response =
      await http.post(Uri.parse(url), body: params,headers: headers).timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        return responseJson;
      }
    } catch (e) {
      print("uuu+$e.toString()");
      Toast.show("Something went wrong",  );
    }

  }
}


