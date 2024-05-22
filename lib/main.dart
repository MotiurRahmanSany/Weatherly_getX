import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:weatherly/screens/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Weatherly',
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      
    );
  }
}
