

import 'package:flutter/cupertino.dart';
import 'package:noviindus/Models/driver_list_model.dart';
import 'package:noviindus/Services/driver_list_services.dart';

class DriverListProvider with ChangeNotifier{
  DriverListModel? driverListModel;
  bool loading = false;


  Future getDriverListData({required BuildContext context}) async {
    loading = true;
    driverListModel = await DriverListServices.getDriverListDetails(context: context);
    loading = false;
    print("|||||||||||||||||||| user Home Page Details|||||||||||||||||");
    print(driverListModel);
    notifyListeners();
    return driverListModel;
  }


  Future deleteDriverData({required BuildContext context,  String? driverId}) async {
    loading = true;
    var result = await DriverListServices.deleteDriver(context: context,driverId: driverId);
    loading = false;
    print("|||||||||||||||||||| user Home Page Details|||||||||||||||||");
    print(result);
    notifyListeners();
    return result;
  }
}