import 'package:flutter/material.dart';
import 'package:flutter_splash/splash/index.dart';

class SplashPage extends StatelessWidget {
  static const String routeName = "/splash";

  @override
  Widget build(BuildContext context) {
    var _splashBloc = new SplashBloc();
    return new Scaffold(
      // appBar: new AppBar(
      //   title: new Text("Splash"),
      // ),
      body: new SplashScreen(splashBloc: _splashBloc),
    );
  }
}
