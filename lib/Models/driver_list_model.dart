
// To parse this JSON data, do
//
//     final driverListModel = driverListModelFromJson(jsonString);

import 'dart:convert';

DriverListModel driverListModelFromJson(String str) => DriverListModel.fromJson(json.decode(str));

String driverListModelToJson(DriverListModel data) => json.encode(data.toJson());

class DriverListModel {
  List<Driver> drivers;
  bool status;

  DriverListModel({
    required this.drivers,
    required this.status,
  });

  factory DriverListModel.fromJson(Map<String, dynamic> json) => DriverListModel(
    drivers: json.containsKey('drivers') ?List<Driver>.from(json["drivers"].map((x) => Driver.fromJson(x))):[],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "drivers": List<dynamic>.from(drivers.map((x) => x.toJson())),
    "status": status,
  };
}

class Driver {
  int id;
  String name;
  String mobile;
  String licenseNo;

  Driver({
    required this.id,
    required this.name,
    required this.mobile,
    required this.licenseNo,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    mobile: json["mobile"] ?? '',
    licenseNo: json["license_no"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mobile": mobile,
    "license_no": licenseNo,
  };
}
