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
  String backImage = "assets/images/custom-car.png";
  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }

  var contact;
  getLocalData()async{
    final sharedPref = await SharedPreferences.getInstance();
     contact=sharedPref.getString('contact');
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
      // child: Scaffold(
      // backgroundColor: secondaryColor,
      //   body: Container(
      //       decoration: BoxDecoration(
      //         // color: secondaryColor,
      //         image: DecorationImage(
      //           image: AssetImage(backImage),
      //           fit: BoxFit.fill,
      //
      //         ),
      //       ),
      //       child: SvgPicture.asset(
      //         'assets/images/umrah-logo.svg',
      //        height: double.infinity,
      //        width: double.infinity,
      //        fit: BoxFit.scaleDown,
      //       //   colorBlendMode: BlendMode.darken,
      //       )),
      // ),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Center(
          child: SizedBox(
              height: 250,
              width: 250,
              child: Center(
                child: SvgPicture.asset(
                  'assets/app-icon.svg',
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.scaleDown,
                  //   colorBlendMode: BlendMode.darken,
                ),
              )),
        ),
      ),
    );
  }
}
