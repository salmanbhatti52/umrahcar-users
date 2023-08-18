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

  GetBookingListModel getBookingOngoingResponse=GetBookingListModel();

  getBookingListOngoing()async{
    print("phoneNmbr $phoneNmbr");
    var mapData={
      "contact": phoneNmbr.toString()
    };
    getBookingOngoingResponse= await DioClient().getBookingOngoing(mapData, context);
    print("response id: ${getBookingOngoingResponse.data}");
    setState(() {

    });

  }

  @override
  void initState() {
    getBookingListOngoing();
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
                fontFamily: 'Montserrat-Regular',
                fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: getBookingOngoingResponse.data!=null?
        SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 60, left: 20),
                          child: CircleAvatar(
                            radius: 35,
                            child: Image.asset(
                              'assets/images/profile.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: size.width * 0.03),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 22),
                          child: Container(
                            color: Colors.transparent,
                            width: size.width * 0.4,
                            child:  AutoSizeText(
                              '${getBookingOngoingResponse.data![0].name}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Montserrat-Regular',
                                fontWeight: FontWeight.w600,
                              ),
                              minFontSize: 16,
                              maxFontSize: 16,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.06),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/name-icon.svg',
                      width: 25,
                      height: 25,
                    ),
                    SizedBox(width: size.width * 0.04),
                     Text(
                      '${getBookingOngoingResponse.data![0].name}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Montserrat-Regular',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/email-icon.svg',
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(width: size.width * 0.04),
                     Text(
                      '${getBookingOngoingResponse.data![0].usersAgentsData!.email}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Montserrat-Regular',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/contact-icon.svg',
                      width: 25,
                      height: 25,
                    ),
                    SizedBox(width: size.width * 0.04),
                     Text(
                      '${getBookingOngoingResponse.data![0].usersAgentsData!.contact}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Montserrat-Regular',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
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
              SizedBox(height: size.height * 0.10),
              InkWell(
                  onTap: ()async {
                    SharedPreferences preferences = await SharedPreferences.getInstance();
                    await preferences.clear();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LogInPage()));
                  },
                  child: button('Logout', context)),
            ],
          ),
        ):
         const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 175),
              child: CircularProgressIndicator(),
            )
          ],
        )
        ,
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
