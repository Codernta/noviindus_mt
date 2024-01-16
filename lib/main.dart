import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noviindus/Providers/driver_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:noviindus/Providers/bus_list_provider.dart';
import 'package:noviindus/View/GetStarted/get_started_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (_) => BusProvider()),
        ChangeNotifierProvider(create: (_)=> DriverListProvider())
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const GetStarted(),
      ),
    );
  }
}

