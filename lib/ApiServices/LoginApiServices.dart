import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

import '../common/constant.dart';
import '../model/modelLogin.dart';



class LoginApiService {
  static const String url =  baseURL +"api/login-worker";

  static Future<ModelLogin> loginApiCall(
      BuildContext context, String mobile,String password, String deviceid) async {
    try {
      Map<String, String> params = {"mobile": mobile,"password":password,"device_id":deviceid};
      final response =
      await http.post(Uri.parse(url), body: params).timeout(const Duration(seconds: 30));

      print(response.body);
      print(response.statusCode.toString());
      if (response.statusCode == 200) {

        return ModelLogin.fromJson(json.decode(response.body));
      }

     else if (response.statusCode == 201) {
       final s = jsonDecode(response.body);
      //  print(s);
        return ModelLogin.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create user.');
      }
     // throw Exception('Failed to load post');
    } catch (e) {
      print("uuu+$e.toString()");
      Toast.show("Something went wrong", duration: Toast.lengthShort, gravity:  Toast.bottom);
      throw Exception('Failed to load post');
    }

  }
}
