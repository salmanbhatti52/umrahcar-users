import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umrahcar_user/utils/colors.dart';
import 'package:umrahcar_user/screens/login_screen.dart';
import 'package:umrahcar_user/widgets/navbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }

  var contact;
  getLocalData()async{
    final _sharedPref = await SharedPreferences.getInstance();
     contact=_sharedPref.getString('contact');
    print("contact nmbr: $contact");
  }

  @override
  void initState() {
    super.initState();
    getLocalData();
    startTimer();
  }

  startTimer() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() {
    contact !=null? Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const NavBar()))
        : Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LogInPage()));
  }

  initScreen(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
          backgroundColor: mainColor,
          body: Center(
            child: SvgPicture.asset("assets/images/splash-icon.svg"),
          )),
    );
  }
}
