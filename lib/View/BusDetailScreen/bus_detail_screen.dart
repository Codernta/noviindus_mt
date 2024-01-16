

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noviindus/View/HomeScreen/home_screen.dart';

class BusDetailScreen extends StatefulWidget {
  final String busName;
  final String driverName;
  final String licenseNumber;
  const BusDetailScreen({super.key, required this.busName,required this.driverName,required this.licenseNumber});

  @override
  State<BusDetailScreen> createState() => _BusDetailScreenState();
}

class _BusDetailScreenState extends State<BusDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBars(),
      body: busDetailBody(),
    );
  }

  appBars() {
    return AppBar(
      leading: IconButton(
        onPressed: () => Get.offAll(HomeScreen()),
        icon: Icon(Icons.arrow_back, color: Colors.white,),
      ),
      backgroundColor: Color(0xff2b2b2b),
      toolbarHeight: 90,
      centerTitle: true,
      title: Text('Driver List', style: TextStyle(color: Colors.white),),
    );
  }

  busDetailBody() {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: size.height * 0.95,
        width: size.width,
        child: Column(
          children: [
            driverCard(),
            seatingLayout()
          ],
        ),
      ),
    );
  }

  driverCard() {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          // height: size.height * 0.3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(0xff2b2b2b),
              // Adjust the height of the logo as needed
              image: DecorationImage(
                  alignment: Alignment.bottomRight,
                  image: AssetImage('assets/images/driver_image.png')
              )
          ),
          child: Stack(
            children: [
              // cardPicture(),
            driverName(widget.driverName, "License no: ${widget.licenseNumber}")
            ],
          ),
        ),
      ),
    );
  }
  driverName(String itemName, String description) {
    final size= MediaQuery.of(context).size;
    return Positioned(
      top: 10,
      left: 30,
      child: Container(
        height: size.height * 0.15,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(itemName,style: TextStyle(color: Colors.white,fontSize: 30,fontFamily: "Axiforma",fontWeight: FontWeight.w600),),
            Text(description,style: TextStyle(color: Colors.white,fontSize: 13,fontFamily: "Axiforma",fontWeight: FontWeight.w400),),
          ],
        ),
      ),
    );
  }

  seatingLayout() {
    return Expanded(
      flex: 4,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 20),
          child: Image.asset('assets/images/1by3.png',fit: BoxFit.contain,width: 200,height: 350,),
        ),
    );
  }
}
