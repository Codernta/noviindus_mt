

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:noviindus/Providers/bus_list_provider.dart';
import 'package:noviindus/View/BusDetailScreen/bus_detail_screen.dart';
import 'package:noviindus/View/Driver/driver_list_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

 late int? busNumbers = 0;
  @override
  void initState() {
    Provider.of<BusProvider>(context,listen: false).getBusListData(context: context).then((value) {
      setState(() {
        busNumbers = value!.bus.length;
      });
    } );
  }
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
    var checkBoolValue = Provider.of<BusProvider>(context);
    return Expanded(
        flex: 6,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Consumer<BusProvider>(
            builder: (context, provider, child) {
              return checkBoolValue.loading ? loader(): checkBoolValue!.busListModel == null
                  ? _noData() : ListView.builder(
                  itemCount: provider.busListModel!.bus.length,
                  itemBuilder: (context,index){
                return busTile(provider,index);
              });
            }
          ),
        ));
  }


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
      child: Text('$busNumbers Buses Found',style: TextStyle(color: Color(0xff6b6b6b),fontSize: 16),),
    );
  }

  busTile(BusProvider provider, int index) {
    print("******** deails for bus detail screen *******");
    print(provider.busListModel!.bus[index].name);
    print(provider.busListModel!.bus[index].driverName);
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
          provider.busListModel!.bus[index].name,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          provider.busListModel!.bus[index].type,
          style: TextStyle(
            fontSize: 13,
          ),
        ),
        trailing: Container(
          decoration: BoxDecoration(
            color: Color(0xfffc153b),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: InkWell(
            onTap: ()=> Get.offAll(BusDetailScreen(busName: provider.busListModel!.bus[index].name, driverName: provider.busListModel!.bus[index].driverName, licenseNumber: provider.busListModel!.bus[index].driverLicenseNo)),
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

  _noData() {
    return Transform(
      transform: Matrix4.translationValues(0, -100, 0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.dangerous_outlined, size: 100,color: Colors.red,),
            Text('Api Error Occured !')
          ],
        ),
      ),
    );
  }
}
