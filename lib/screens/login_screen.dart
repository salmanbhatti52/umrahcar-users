// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umrahcar_user/utils/colors.dart';
import 'package:umrahcar_user/widgets/button.dart';
import 'package:umrahcar_user/widgets/navbar.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';

import '../service/rest_api_service.dart';
import '../utils/const.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  String backImage = "assets/images/custom-car.png";
  TextEditingController contactNumberController = TextEditingController();
  final GlobalKey<FormState> logInFormKey = GlobalKey<FormState>();
  final countryPicker = const FlCountryCodePicker();
  CountryCode? countryCode;

  DateTime? currentBackPressTime;

  Future<bool> onExitApp() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: "Tap again to exit",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: const Color(0xFF222124),
        textColor: Colors.white,
        fontSize: 16,
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  void configOneSignel()
  {
    OneSignal.shared.setAppId(onesignalAppId);
  }
  @override
  void initState() {
    configOneSignel();
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: onExitApp,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          // appBar: AppBar(
          //   backgroundColor: mainColor,
          //   elevation: 0,
          // ),
          backgroundColor: mainColor,
          body:  Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backImage),
                alignment: Alignment.topCenter,
                fit: BoxFit.scaleDown
              ),
            ), child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: logInFormKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child:  SvgPicture.asset(
                            'assets/images/umrah-passenger-logo.svg'),
                      ),
                      SizedBox(height: size.height * 0.04),
                      Container(
                        margin: const EdgeInsets.only(left: 20,right: 20),
                        child: const Text(
                          'Welcome to UmrahCar Passenger App',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Montserrat-Regular',
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      // SizedBox(height: size.height * 0.02),
                      // const Text(
                      //   '(For Passengers)',
                      //   style: TextStyle(
                      //     fontSize: 18,
                      //     fontFamily: 'Montserrat-Regular',
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                      SizedBox(height: size.height * 0.08),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                          controller: contactNumberController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Contact Number field is required!';
                            }
                            return null;
                          },
          
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Montserrat-Regular',
                            fontSize: 16,
                            color: Color(0xFF6B7280),
                          ),
                          decoration: InputDecoration(
                            filled: false,
                            errorStyle: const TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              wordSpacing: 2,
                            ),
          
                            border: OutlineInputBorder(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: const Color(0xFF000000).withOpacity(0.15),
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(14)),
                              borderSide: BorderSide(
                                color: const Color(0xFF000000).withOpacity(0.15),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(
                                color: const Color(0xFF000000).withOpacity(0.15),
                                width: 1,
                              ),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 20),
                            hintText: "Contact Number",
                            hintStyle: const TextStyle(
                              color: Color(0xFF929292),
                              fontSize: 12,
                              fontFamily: 'Montserrat-Regular',
                              fontWeight: FontWeight.w500,
                            ),
                            prefixIcon: GestureDetector(
                              onTap: () async {
                                final code =
                                await countryPicker.showPicker(context: context);
                                setState(() {
                                  countryCode = code;
                                });
                                print('countryCode: ${countryCode!.dialCode}');
                                print('countryName: ${countryCode!.name}');
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      countryCode?.dialCode ?? "+234",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 12,
                                       fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: size.width * 0.03),
                                  const Text(
                                    '|',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 25,
                                     fontFamily: 'Poppins',
                                    ),
                                  ),
                                  SizedBox(width: size.width * 0.03),
                                  SvgPicture.asset(
                                    'assets/images/contact-icon.svg',
                                    width: 25,
                                    height: 25,
                                    fit: BoxFit.scaleDown,
                                  ),
          
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.08),
                      GestureDetector(
                        onTap: ()async {
                          final status =
                          await OneSignal.shared.getDeviceState();
                          String? onesignalId = status?.userId;
          
                          print("onesignalId: $onesignalId");
                          if(logInFormKey.currentState!.validate()) {
                            if(countryCode !=null){
                              var mapData={
                                "onesignal_id": "$onesignalId",
                                "contact":"${countryCode!.dialCode}${contactNumberController.text}"
                              };
                              var response = await DioClient().login(
                                  mapData,context
                              );
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              await prefs.setString("contact", "${countryCode!.dialCode}${contactNumberController.text}");
                              await prefs.setString("name", "${response.data!.guestData!.name}");
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const NavBar()));
        
                                      
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Country Code not selected")));
          
                            }
          
          
                          }
          
          
                          // Navigator.of(context).pushAndRemoveUntil(
                          //     MaterialPageRoute(
                          //         builder: (context) => const HomePage()),
                          //     (Route<dynamic> route) => false);
                        },
                        child: button('Login', context),
                      ),
                      SizedBox(height: size.height * 0.02),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
