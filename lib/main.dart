import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste2/newApp/ui/home_ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        defaultTransition: Transition.fade,
        home: HomeUi());
  }
}
