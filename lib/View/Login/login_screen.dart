


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:noviindus/Controllers/login_controller.dart';
import 'package:noviindus/View/HomeScreen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final LoginController logController = Get.put(LoginController());


  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: null,
      body: loginBody(),
    );
  }


  loginBody() {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
     physics: NeverScrollableScrollPhysics(),
      child: Container(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            welcomeContainer(),
            textFields(),
            loginButton(),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  welcomeContainer() {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width, // Adjust the width of the logo as needed
      height: size.height * 0.35,
      decoration: BoxDecoration(
        color: Colors.black,// Adjust the height of the logo as needed
        image: DecorationImage(image: AssetImage('assets/images/login_page_template.png')
        )
      ),
      child: Stack(
        children: [
          welcomeText(),
          welcome()
        ],
      ),
    );
  }

  loginButton() {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      child: ElevatedButton(
        onPressed: () => loginFunc(),
        style: ElevatedButton.styleFrom(
          primary: Color(0xfffc153b),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: _isLoading ? loader():  Text(
            'Login',
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

  welcomeText() {
    final size= MediaQuery.of(context).size;
    return Positioned(
      top: 0,
      child: Container(
        width: size.width, // Adjust the width of the logo as needed
        height: size.height * 0.35,
        decoration: BoxDecoration(
            color: Colors.black,// Adjust the height of the logo as needed
            image: DecorationImage(
                fit: BoxFit.fill  ,
                image: AssetImage('assets/images/login_page_template.png',)
            )
        ),

      ),
    );
  }

  welcome() {
    final size= MediaQuery.of(context).size;
    return Positioned(
      top: 120,
      left: 30,
      child: Container(
        height: size.height * 0.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome',style: TextStyle(color: Colors.white,fontSize: 50,fontFamily: "Axiforma",fontWeight: FontWeight.w600),),
            Text('Manage your Bus and Drivers',style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: "Axiforma",fontWeight: FontWeight.w400),),
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
              textforms('Enter Username',_userNameController),textforms('Enter Password',_passwordController)],
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


loginFunc() async {
  bool hasInternetConnection =
      await InternetConnectionChecker().hasConnection;
  if (hasInternetConnection) {
    setState(() {
      _isLoading = true;
    });
    var result = await logController.logIn(
        username: _userNameController.text,
        password: _passwordController.text,
        context: context);
    setState(() {
      _isLoading = false;
    });
    if (result["status"] == true) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(result['message']),
      ));
       Get.offAll(HomeScreen());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(result['message']),
      ));
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("\u26A0   Please connect to internet and try again"),
    ));
  }
}

  loader() {
    return SizedBox(
      height: 16,
      width: 16,
      child: CircularProgressIndicator(color: Colors.white,),
    );
  }}




