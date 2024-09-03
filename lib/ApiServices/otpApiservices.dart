import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

import '../common/constant.dart';
import '../model/modelOtp.dart';




class OtpApiService {
  static const String url = baseURL+"api/verifyotp";

  static Future<ModelOtp> otpApiCall(
      BuildContext context, String mobile ,String otp) async {
    try {
      Map<String, String> params = {
        "mobile": mobile,
        "otp":otp,
      };
      final response =
      await http.post(Uri.parse(url), body: params).timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode == 200) {
        return ModelOtp.fromJson(json.decode(response.body));
      }
      else if (response.statusCode == 201) {
        final s = jsonDecode(response.body);
        //  print(s);
        return ModelOtp.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create user.');
      }

    } catch (e) {
      print("uuu+$e.toString()");
      Toast.show("Something went wrong",);
      throw Exception('Failed to load post');
    }

  }
}

