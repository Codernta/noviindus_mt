

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:noviindus/View/Login/login_screen.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffc153b),
      body: getStartedBody()
    );
  }

  getStartedBody() {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Container(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            logo(),
            Expanded(
              child: Container(),
            ),
            getStartButton(),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  logo() {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.7, // Adjust the width of the logo as needed
      height: size.height * 0.87, // Adjust the height of the logo as needed
      child: Center(
        child: SvgPicture.asset(
          'assets/images/logo.svg', // You can change the color of the icon
        ),
      ),
    );
  }

  getStartButton() {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      child: ElevatedButton(
        onPressed: ()=> Get.offAll(LoginScreen()),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Get Started',
            style: TextStyle(
              fontFamily: 'Axiforma',
              fontSize: 24,
              color: Color(0xfffc153b),
            ),
          ),
        ),
      ),
    );
  }
}
