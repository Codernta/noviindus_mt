

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:noviindus/View/Driver/driver_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBars(),
      body: homePageBody(),
    );
  }

  appBars() {
    return AppBar(
      backgroundColor: Color(0xff2b2b2b),
      toolbarHeight: 90,
      centerTitle: true,
      title: SvgPicture.asset('assets/images/appbar_logo.svg'),
    );
  }

  homePageBody() {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Container(
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            toggleSwitches(),
            busListTitle(),
            busNameList()
          ],
        ),
      ),
    );
  }

  toggleSwitches() {
      return Expanded(
        flex: 2,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              busCard(Color(0xfffc153b)),
              driverCard()
            ],
          ),
        ),
      );
    }

  busNameList() {
    return Expanded(
        flex: 6,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context,index){
            return busTile();
          }),
        ));
  }

  /*cardPicture() {
    final size= MediaQuery.of(context).size;
    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black,// Adjust the height of the logo as needed
            image: DecorationImage(
                fit: BoxFit.fill ,
                image: AssetImage('assets/images/bus_image.png',)
            )
        ),

      ),
    );
  }*/

  itemName(String itemName, String description) {
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



  busCard(Color cardColor) {
    final size= MediaQuery.of(context).size;
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: (){},
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            // height: size.height * 0.3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: cardColor,
                // Adjust the height of the logo as needed
                image: DecorationImage(
                    alignment: Alignment.bottomRight,
                    image: AssetImage('assets/images/bus_image.png')
                )
            ),
            child: Stack(
              children: [
                // cardPicture(),
                itemName('Bus','Manage your Bus'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  driverCard() {
    final size= MediaQuery.of(context).size;
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: ()=> Get.offAll(DriverListScreen()),
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
                itemName('Driver','Manage your Driver'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  busListTitle() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Text('21 Buses Found',style: TextStyle(color: Color(0xff6b6b6b),fontSize: 16),),
    );
  }

  busTile() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Color(0xffc1c1c1),
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        leading: Container(
          width: 80,
          height: 80,
          child: Image.network(
              'https://media.istockphoto.com/id/135327019/photo/white-passenger-bus.jpg?s=612x612&w=0&k=20&c=sRU5BpOsY6fyYj9pMiAxz0dLML--uoNl7rIXelRbFnc=', // Replace with your image URL
            fit: BoxFit.cover,),
        ),

        title: Text(
          'KSRTC',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Swift Scania P-Series',
          style: TextStyle(
            fontSize: 13,
          ),
        ),
        trailing: Container(
          decoration: BoxDecoration(
            color: Color(0xfffc153b),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
              child: Text(
                'Manage',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
