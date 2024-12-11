import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:umrahcar_user/screens/tracking_process/track_upcoming_screen.dart';
import 'package:umrahcar_user/screens/tracking_process/track_completed_screen.dart';
import 'package:umrahcar_user/utils/colors.dart';

Widget homeList(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return ListView.builder(
    physics: const BouncingScrollPhysics(),
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    itemCount: myList.length,
    itemBuilder: (BuildContext context, int index) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(myList[index].image),
              ),
              SizedBox(width: size.width * 0.005),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.transparent,
                    width: size.width * 0.45,
                    child: AutoSizeText(
                      myList[index].title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                       fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                      minFontSize: 16,
                      maxFontSize: 16,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: size.height * 0.005),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                          'assets/images/small-black-bookings-icon.svg'),
                      SizedBox(width: size.width * 0.01),
                      const Text(
                        '12:00 am on 2-12-2022',
                        style: TextStyle(
                          color: Color(0xFF565656),
                          fontSize: 8,
                        fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.005),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                          'assets/images/small-black-car-icon.svg'),
                      SizedBox(width: size.width * 0.01),
                      const Text(
                        'Sedan',
                        style: TextStyle(
                          color: Color(0xFF565656),
                          fontSize: 8,
                        fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (myList[index].status == 'Upcoming')
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TrackUpcomingPage(),
                        ));
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: size.width * 0.2,
                    height: size.height * 0.024,
                    child: Text(
                      myList[index].status,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        color: Color(0xFFCAAA00),
                        fontSize: 12,
                       fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              if (myList[index].status == 'Completed')
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TrackCompletedPage(),
                        ));
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: size.width * 0.2,
                    height: size.height * 0.024,
                    child: Text(
                      myList[index].status,
                      textAlign: TextAlign.end,
                      style:  TextStyle(
                        color: buttonColor,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: size.height * 0.02),
        ],
      );
    },
  );
}

List myList = [
  MyList("assets/images/list-image-1.png", "Makkah Hottle Aziziz", "Upcoming"),
  MyList("assets/images/list-image-2.png", "Madina Airport", "Upcoming"),
  MyList("assets/images/list-image-3.png", "Makkah Airport", "Upcoming"),
  MyList("assets/images/list-image-4.png", "Madina Airport", "Completed"),
  MyList("assets/images/list-image-1.png", "Makkah Hottle Aziziz", "Upcoming"),
  MyList("assets/images/list-image-2.png", "Madina Airport", "Upcoming"),
  MyList("assets/images/list-image-3.png", "Makkah Airport", "Upcoming"),
  MyList("assets/images/list-image-4.png", "Madina Airport", "Completed"),
  MyList("assets/images/list-image-1.png", "Makkah Hottle Aziziz", "Upcoming"),
  MyList("assets/images/list-image-2.png", "Madina Airport", "Upcoming"),
  MyList("assets/images/list-image-3.png", "Makkah Airport", "Upcoming"),
  MyList("assets/images/list-image-4.png", "Madina Airport", "Completed"),
];

class MyList {
  String? image;
  String? title;
  String? status;

  MyList(this.image, this.title, this.status);
}
