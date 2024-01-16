

import 'dart:convert';

BusListModel busListModelFromJson(String str) => BusListModel.fromJson(json.decode(str));

String busListModelToJson(BusListModel data) => json.encode(data.toJson());

class BusListModel {
  List<Bus> bus;
  bool status;

  BusListModel({
    required this.bus,
    required this.status,
  });

  factory BusListModel.fromJson(Map<String, dynamic> json) => BusListModel(
    bus:  json.containsKey('bus')? List<Bus>.from(json["bus"].map((x) => Bus.fromJson(x))):[],
    status: json["status"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "bus": List<dynamic>.from(bus.map((x) => x.toJson())),
    "status": status,
  };
}

class Bus {
  int id;
  String image;
  String name;
  String type;
  String driverName;
  String driverLicenseNo;

  Bus({
    required this.id,
    required this.image,
    required this.name,
    required this.type,
    required this.driverName,
    required this.driverLicenseNo,
  });

  factory Bus.fromJson(Map<String, dynamic> json) => Bus(
    id: json["id"] ?? 0,
    image: json["image"] ?? '',
    name: json["name"] ?? '',
    type: json["type"] ?? '',
    driverName: json["driver_name"] ?? '',
    driverLicenseNo: json["driver_license_no"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "name": name,
    "type": type,
    "driver_name": driverName,
    "driver_license_no": driverLicenseNo,
  };
}
