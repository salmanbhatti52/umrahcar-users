import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
        backgroundColor: mainColor,
        appBar: AppBar(
          backgroundColor: mainColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text(
            'Profile',
            style: TextStyle(
                color: Colors.black,
                fontSize: 26,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700),
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
                    'assets/images1/profile.png',
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
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Poppins',
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
                padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20), // Added more vertical padding for spacing
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18), // Added padding for better spacing
                    hintText: '$guestName',
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(
                          0.6), // Increased opacity for better visibility
                      fontSize: 16, // Slightly increased font size
                      fontWeight: FontWeight
                          .w500, // Added weight for better readability
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(18.0), // Consistent padding
                      child: SvgPicture.asset(
                        'assets/images1/name-icon.svg',
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          30), // More rounded corners for a modern look
                      borderSide: BorderSide(
                          color: Colors.grey[400]!,
                          width: 1.5), // Thicker border
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(30), // Consistent border radius
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 21, 21, 22),
                        width: 2.0, // Thicker border on focus
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 20), // Consistent padding
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18), // Consistent content padding
                    hintText: '$phoneNmbr',
                    hintStyle: TextStyle(
                      color: Colors.black
                          .withOpacity(0.6), // Consistent text style
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: SvgPicture.asset(
                        'assets/images1/contact-icon.svg',
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(30), // Consistent border radius
                      borderSide:
                          BorderSide(color: Colors.grey[400]!, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          30), // Consistent focused border
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 21, 21, 22),
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.02),
              // SizedBox(height: size.height * 0.05),
              // Padding(
              //   padding: const EdgeInsets.only(left: 40),
              //   child: Row(
              //     children: [
              //       SvgPicture.asset(
              //         'assets/images1/email-icon.svg',
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
              SizedBox(height: size.height * 0.20),
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
              SvgPicture.asset('assets/images1/big-delete-icon.svg'),
              SizedBox(height: size.height * 0.04),
              const Text(
                'Are you sure you want to\nDelete your Account?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF565656),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
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
