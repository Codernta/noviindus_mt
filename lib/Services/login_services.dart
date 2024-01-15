

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:noviindus/Utils/Commons/api.dart';

class LoginServices{
  static Future login({String? username, String? password, required BuildContext context}) async {
    print("||||||||||||||||Login|||||||||||||||");
    try {
      FormData formData = FormData.fromMap({
        "username":username,
        "password":password,
      });
      Response loginData = await Dio().post(Api.login, data: formData);
      if (loginData.data['status']) {
        print('|||||||||||||||Login Response Data||||||||||| ${loginData.data}');
        // return loginModel = LoginModel.fromJson(loginData.data);
        return loginData.data;
      } else {

        print('|||||||||||||||Login Response Data Not Success||||||||||| ${loginData.data}');

        return loginData.data;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        print('Error sending request!');
        print(e.message);
      }
      /*Fluttertoast.showToast(
          gravity: ToastGravity.BOTTOM,
          msg: '\u26A0 Error Response : ${e.error}',
          backgroundColor: Colors.black,
          textColor: Colors.white);*/
    }
  }
}