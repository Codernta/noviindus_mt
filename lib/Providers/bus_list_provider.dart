

import 'package:flutter/cupertino.dart';
import 'package:noviindus/Models/bus_list_model.dart';
import 'package:noviindus/Services/bus_list_services.dart';

class BusProvider with ChangeNotifier{
  BusListModel? busListModel;
  bool loading = false;

  Future getBusListData({required BuildContext context}) async {
    loading = true;
    busListModel = await BusListServices.getBusListDetails(context: context);
    loading = false;
    print("|||||||||||||||||||| Bus List Details|||||||||||||||||");
    print(busListModel);
    notifyListeners();
    return busListModel;
  }
}