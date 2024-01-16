

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noviindus/Services/login_services.dart';
import 'package:noviindus/Utils/Commons/commons.dart';
import 'package:noviindus/View/HomeScreen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var loginProcess = false.obs;

  var error = "";
  var loginData;
  var loginResp;

  RxBool get isLoading => loginProcess;

  Future logIn({String? username,
    String? password,
    required BuildContext context}) async {
    FocusScope.of(context).unfocus();
    loginData = "";
    try {
      loginProcess(true);
      loginData = await LoginServices.login(
        username: username,
        password: password,
        context: context,
      );
      print(
          "|||||||||||||||||||||login response data 565656|||||||||||||||||||||");
      print(loginData);
      loginProcess(false);
      if (loginData['status']) {
        SharedPreferences mPref = await SharedPreferences.getInstance();
        mPref.setString(Common.token, loginData['access_token']);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(loginData['message']),
        ));
        mPref.setBool('isLogged', true);
        saveUserDataFromLoginResponse(loginData);
        Get.offAll(HomeScreen());
        return loginData;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(loginData['message']),
        ));
        return loginData;
      }
    } finally {
      loginProcess(false);
    }
  }


  saveUserDataFromLoginResponse(loginData) async {
    SharedPreferences mPref = await SharedPreferences.getInstance();
    mPref.setString(Common.token, loginData['access_token']);
  }
}