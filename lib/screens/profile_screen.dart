import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umrahcar_user/main.dart';
import 'package:umrahcar_user/utils/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:umrahcar_user/widgets/button.dart';

import '../models/get_booking_list_model.dart';
import '../service/rest_api_service.dart';
import 'homepage_screen.dart';
import 'login_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          title:  Text(
            'Profile',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.03),
              Center(
                child: CircleAvatar(
                  radius: 55,
                  child: Image.asset(
                    'assets/images/profile.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                    color: Colors.transparent,
                    child: AutoSizeText(
                      '$guestName',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      minFontSize: 16,
                      maxFontSize: 16,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: '$guestName',
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: SvgPicture.asset(
                        'assets/images/name-icon.svg',
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide:  BorderSide(color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.5),)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:  BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: '$phoneNmbr',
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SvgPicture.asset(
                        'assets/images/contact-icon.svg',
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide:  BorderSide(color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.5),)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:  BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.17),
              // SizedBox(height: size.height * 0.05),
              // Padding(
              //   padding: const EdgeInsets.only(left: 40),
              //   child: Row(
              //     children: [
              //       SvgPicture.asset(
              //         'assets/images/email-icon.svg',
              //         width: 20,
              //         height: 20,
              //       ),
              //       SizedBox(width: size.width * 0.04),
              //        Text(
              //         '${getBookingOngoingResponse.data![0].usersAgentsData!.email}',
              //         style: const TextStyle(
              //           color: Colors.black,
              //           fontSize: 14,
              //           fontFamily: 'Montserrat-Regular',
              //           fontWeight: FontWeight.w500,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              // SizedBox(height: size.height * 0.1),
              // GestureDetector(
              //   onTap: () {
              //     showDialog(
              //       context: context,
              //       barrierDismissible: false,
              //       builder: (context) => deleteAccount(),
              //     );
              //   },
              //   child: buttonTransparent('Delete my Account', context),
              // ),
              Container(
                width: size.width * 0.8,
                height: size.height * 0.08,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    width: 1,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Provider.of<ThemeProvider>(context).isDarkMode
                          ? Icons.light_mode
                          : Icons.dark_mode,
                      size: 25,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    SizedBox(width: size.width * 0.04),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dark Mode',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            Provider.of<ThemeProvider>(context).isDarkMode
                                ? 'Switch to Light Mode'
                                : 'Switch to Dark Mode',
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: ConstantColor.darkgreyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FlutterSwitch(
                      width: 45,
                      height: 25,
                      activeColor: ConstantColor.primaryColor,
                      inactiveColor: ConstantColor.darkgreyColor.withOpacity(0.2),
                      activeToggleColor: primaryColor,
                      inactiveToggleColor: ConstantColor.darkgreyColor,
                      toggleSize: 25,
                      value: Provider.of<ThemeProvider>(context).isDarkMode,
                      borderRadius: 50,
                      padding: 2,
                      onToggle: (val) {
                        Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.03),
              InkWell(
                  onTap: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    await preferences.clear();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LogInPage()));
                  },
                  child: button('Logout', context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget deleteAccount() {
    var size = MediaQuery.of(context).size;
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      insetPadding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        height: size.height * 0.48,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.04),
              SvgPicture.asset('assets/images/big-delete-icon.svg'),
              SizedBox(height: size.height * 0.04),
              const Text(
                'Are you sure you want to\nDelete your Account?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF565656),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat-Regular',
                ),
              ),
              SizedBox(height: size.height * 0.06),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: dialogbuttonSmall('Sure', context),
                  ),
                  SizedBox(width: size.width * 0.04),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: dialogButtontransparentSmall('Cancel', context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
