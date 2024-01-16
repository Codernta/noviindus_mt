import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:noviindus/Models/driver_list_model.dart';
import 'package:noviindus/Utils/Commons/api.dart';
import 'package:noviindus/Utils/Commons/commons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverListServices {
  static Future<DriverListModel?> getDriverListDetails(
      {required BuildContext context}) async {
    DriverListModel? driverListModel;
    SharedPreferences mPref = await SharedPreferences.getInstance();
    String? token = mPref.getString(Common.token);
    print('|||||||||||||| Token ||||||||||||||||||');
    print(token);

    try {
      Response userData = await Dio().get(Api.driverList,
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
            },
          ));
      print('User HomePage Info: ${userData.data}');

      if (userData.data['status']) {
        driverListModel = DriverListModel.fromJson(userData.data);
      } else {
        // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LandingScreen()), (route) => false);
      }
    } on DioError catch (e) {
      // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LandingScreen()), (route) => false);
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        print('Error sending request!');
        print(e.message);
        return driverListModel;
      }
      return driverListModel;
    }
    return driverListModel;
  }

  static Future addDriver(
      {String? name,
      String? licenseNo,
      required BuildContext context}) async {
    print("|||||||||||||||| add driver|||||||||||||||");

    SharedPreferences mPref = await SharedPreferences.getInstance();
    String? token = mPref.getString(Common.token);
    print('|||||||||||||| Token ||||||||||||||||||');
    print(token);
    try {
      FormData formData = FormData.fromMap(
          {"name": name, "mobile": '98987564', "license_no": licenseNo});
      Response loginData = await Dio().post(Api.driverList,
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
            },
          ),
          data: formData);
      if (loginData.data['status']) {
        print(
            '|||||||||||||||Login Response Data||||||||||| ${loginData.data}');
        // return loginModel = LoginModel.fromJson(loginData.data);
        return loginData.data;
      } else {
        print(
            '|||||||||||||||Login Response Data Not Success||||||||||| ${loginData.data}');

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
    }
  }

  static Future deleteDriver(
      {String? driverId,
        required BuildContext context}) async {
    print("|||||||||||||||| add driver|||||||||||||||");

    SharedPreferences mPref = await SharedPreferences.getInstance();
    String? token = mPref.getString(Common.token);
    print('|||||||||||||| Token ||||||||||||||||||');
    print(token);
    try {
      FormData formData = FormData.fromMap(
          {"driver_id": driverId});
      Response loginData = await Dio().delete(Api.driverList,
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
            },
          ),
          data: formData);
      if (loginData.data['status']) {
        print(
            '|||||||||||||||Login Response Data||||||||||| ${loginData.data}');
        // return loginModel = LoginModel.fromJson(loginData.data);
        return loginData.data;
      } else {
        print(
            '|||||||||||||||Login Response Data Not Success||||||||||| ${loginData.data}');

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
    }
  }
}
