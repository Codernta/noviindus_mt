


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noviindus/Services/driver_list_services.dart';
import 'package:noviindus/Utils/Commons/commons.dart';
import 'package:noviindus/View/Driver/driver_list_screen.dart';
import 'package:noviindus/View/HomeScreen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddDriverController extends GetxController {
  var addProcess = false.obs;

  var error = "";
  var addData;
  var addResp;

  RxBool get isLoading => addProcess;

  Future addDriver({String? username,
    String? password,
    required BuildContext context, required String? name, required String? licenseNo}) async {
    FocusScope.of(context).unfocus();
    addData = "";
    try {
      addProcess(true);
      addData = await DriverListServices.addDriver(context: context,name: name,licenseNo: licenseNo);
      print(
          "|||||||||||||||||||||login response data 565656|||||||||||||||||||||");
      print(addData);
      addProcess(false);
      if (addData['status']) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(addData['message']),
        ));
        Get.offAll(DriverListScreen());
        return addData;
      } else {
        return addData;
      }
    } finally {
      addProcess(false);
    }
  }


}