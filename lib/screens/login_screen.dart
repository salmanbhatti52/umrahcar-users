// ignore_for_file: avoid_print

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umrahcar_user/utils/colors.dart';
import 'package:umrahcar_user/widgets/button.dart';
import 'package:umrahcar_user/widgets/navbar.dart';

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
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body:  Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: logInFormKey,
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.04),
                      Container(
                        width: size.width,
                        height: size.height * 0.36,
                        decoration: const BoxDecoration(),
                        child: SvgPicture.asset(
                          'assets/app-icon.svg',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      SizedBox(height: size.height * 0.0),
                      Container(
                        margin: const EdgeInsets.only(left: 20,right: 20),
                        child:  Text(
                          'Welcome to UmrahCar Passenger App',
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
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

                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            filled: false,
                            fillColor: Theme.of(context).colorScheme.surface,
                            errorStyle: const TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.15),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 1,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 20),
                            hintText: "Contact Number",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.6),
                            ),
                            prefixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CountryCodePicker(
                                  onChanged: (CountryCode code) {
                                    setState(() {
                                      countryCode = code;
                                    });
                                    print('countryCode: ${countryCode?.dialCode}');
                                    print('countryName: ${countryCode?.name}');
                                  },
                                  initialSelection: 'NG',
                                  favorite: ['+234', 'NG'],
                                  textStyle: TextStyle(
                                    color: Theme.of(context).colorScheme.onSurface,
                                    fontSize: 14,
                                  ),
                                  showFlag: true,
                                  showFlagDialog: true,
                                  dialogTextStyle: TextStyle(
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                  dialogBackgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                                  searchStyle: TextStyle(
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                  padding: const EdgeInsets.only(left: 10),
                                ),
                                Text(
                                  '|',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color:
                                    Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                SizedBox(width: size.width * 0.03),
                                SvgPicture.asset(
                                  'assets/images/contact-icon.svg',
                                  width: 25,
                                  height: 25,
                                  fit: BoxFit.scaleDown,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ],
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
                              ScaffoldMessenger.of(context).showSnackBar( SnackBar(backgroundColor: Theme.of(context).scaffoldBackgroundColor,content: Text("Country Code not selected")));

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
    );
  }
}
