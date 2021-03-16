
import 'package:flutter/material.dart';
import 'package:flutter_app_finaltest/screens/splash_screen/splash_screen.dart';


class SplashPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage>{
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SplashScreenPage(),
    );
  }

}