

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:noviindus/Models/bus_list_model.dart';
import 'package:noviindus/Utils/Commons/api.dart';
import 'package:noviindus/Utils/Commons/commons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusListServices{
  static Future<BusListModel?> getBusListDetails({required BuildContext context}) async {
    BusListModel? busListModel;
    SharedPreferences mPref = await SharedPreferences.getInstance();
    String? token = mPref.getString(Common.token);
    print('|||||||||||||| Token ||||||||||||||||||');
    print(token);

    try {
      Response userData = await Dio().get(
          Api.busList,
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
            },
          ));
      if (userData.data['status']) {
        busListModel = BusListModel.fromJson(userData.data);
      }else{
        // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LandingScreen()), (route) => false);
      }
    }on DioError catch (e) {
      // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LandingScreen()), (route) => false);
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        print('Error sending request!');
        print(e.message);
        return busListModel;
      }
      return busListModel;
    }
    return busListModel;
  }

}