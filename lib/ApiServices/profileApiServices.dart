import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:toast/toast.dart';
import '../Utils/AppConstants.dart';
import '../Utils/Global.dart';
import 'package:http/http.dart' as http;

import '../common/constant.dart';
import '../model/modelprofiledetails.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyProfileApiService{


  static const String url = "${baseURL}api/worker-profile";

  static Future<ProfileDetails?> myProfileApiCall(BuildContext context) async {
    try {

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(AppConstants.token);
    final String? userId = prefs.getString(AppConstants.userid);
     print("accessss==$accessToken");
     print("user id ==$userId");
      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
      Map<String?, String?> params = {"assign": userId};

      final response =
      await http.post(Uri.parse(url), headers:headers,body: params).timeout(const Duration(seconds: 30));
      print('profile details    ${response.body}');
     // var responseJson = json.decode(response.body);
      if (response.statusCode == 200) {
        return ProfileDetails.fromJson(json.decode(response.body));
      }
    } catch (e) {
      print("uuu+$e.toString()");
      Toast.show("Something went wrong", );
      throw Exception('Failed to load post');
    }

  }
}