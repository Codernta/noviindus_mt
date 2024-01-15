

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noviindus/View/Driver/driver_list_screen.dart';

class AddDriverScreen extends StatefulWidget {
  const AddDriverScreen({super.key});

  @override
  State<AddDriverScreen> createState() => _AddDriverScreenState();
}

class _AddDriverScreenState extends State<AddDriverScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _licenseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: appBars(),
      body: addDriverBody(),
    );
  }

  appBars() {
    return AppBar(
      leading: IconButton(
        onPressed: ()=> Get.offAll(DriverListScreen()),
        icon: Icon(Icons.arrow_back,color: Colors.white,),
      ),
      backgroundColor: Color(0xff2b2b2b),
      toolbarHeight: 90,
      centerTitle: true,
      title: Text('Driver List',style: TextStyle(color: Colors.white),),
    );
  }

  addDriverBody() {

      final size = MediaQuery.of(context).size;
      return SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: size.height *0.86,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textFields(),
              saveDriverButton(),
              SizedBox(height: 40),
            ],
          ),
        ),
      );
    }


  textFields() {
    return Expanded(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 40,),
              textforms('Enter Name',_nameController),textforms('Enter License Number',_licenseController)],
          ),
        ));
  }

  textforms(String hintText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color(0xff707070),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Color(0xff2a2a2a).withOpacity(0.1),
        ),
      ),
    );
  }

  saveDriverButton() {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      child: ElevatedButton(
        onPressed: () {
          // Get.offAll(HomeScreen());
        },
        style: ElevatedButton.styleFrom(
          primary: Color(0xfffc153b),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Save',
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

}
