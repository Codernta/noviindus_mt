

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noviindus/Models/driver_list_model.dart';
import 'package:noviindus/Providers/bus_list_provider.dart';
import 'package:noviindus/Providers/driver_list_provider.dart';
import 'package:noviindus/View/Driver/add_driver_screen.dart';
import 'package:noviindus/View/HomeScreen/home_screen.dart';
import 'package:provider/provider.dart';

class DriverListScreen extends StatefulWidget {
  const DriverListScreen({super.key});

  @override
  State<DriverListScreen> createState() => _DriverListScreenState();
}

class _DriverListScreenState extends State<DriverListScreen> {
   late int driverNumber= 0;

  
  
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<DriverListProvider>(context,listen: false).getDriverListData(context: context).then((value){
      print('********* value *************');
      print(value);
      setState(() {
        driverNumber= value.drivers.length;
      });
    print(driverNumber);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBars(),
      body: driverListBody(),
    );
  }

  appBars() {
    return AppBar(
      leading: IconButton(
        onPressed: ()=> Get.offAll(HomeScreen()),
        icon: Icon(Icons.arrow_back,color: Colors.white,),
      ),
      backgroundColor: Color(0xff2b2b2b),
      toolbarHeight: 90,
      centerTitle: true,
      title: Text('Driver List',style: TextStyle(color: Colors.white),),
    );
  }

  driverListBody() {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Container(
        height: size.height * 0.83,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            driverListTitle(),
            driverList(),
            addDriverButton(),
          ],
        ),
      ),
    );
  }

  driverListTitle() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Text('$driverNumber Drivers Found',style: TextStyle(color: Color(0xff6b6b6b),fontSize: 16),)),
    );
  }

  driverList() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5),
        child: Consumer<DriverListProvider>(
          builder: (context, provider, child) {
            return provider.loading? loader(): ListView.builder(
                itemCount: provider.driverListModel!.drivers.length,
                itemBuilder: (context,index){
              return driverCard(provider,index);
            });
          }
        ),
      ),
    );
  }

  addDriverButton() {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
    width: size.width * 0.9,
    child: ElevatedButton(
      onPressed: () => Get.offAll(AddDriverScreen()),
      style: ElevatedButton.styleFrom(
        primary: Color(0xfffc153b),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          'Add Driver',
          style: TextStyle(
            fontFamily: 'Axiforma',
            fontSize: 23,
            color: Colors.white,
          ),
        ),
      ),
    ),
    );
  }

  driverCard(DriverListProvider provider, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Color(0xffc1c1c1),
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(13.0),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              'https://example.com/your_image_url.jpg', // Replace with your image URL
            ),
          ),
          title: Text(
            provider.driverListModel!.drivers[index].name,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'License no: ${provider.driverListModel!.drivers[index].licenseNo}',
            style: TextStyle(
              fontSize: 13,
            ),
          ),
          trailing: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: InkWell(
              onTap: (){
                Provider.of<DriverListProvider>(context,listen: false).deleteDriverData(context: context,driverId: provider.driverListModel!.drivers[index].id.toString()).then((value) => Get.offAll(DriverListScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  loader() {
    return SizedBox(
      height: 300,
      child: Center(
        child: CircularProgressIndicator(color: Color(0xfffc153b),),
      ),
    );
  }
}
