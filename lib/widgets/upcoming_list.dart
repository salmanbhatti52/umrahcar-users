import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:umrahcar_user/screens/tracking_process/track_upcoming_screen.dart';

import '../models/get_booking_list_model.dart';
import '../screens/tracking_process/track_screen.dart';
import '../utils/const.dart';

Widget upComingList(BuildContext context,GetBookingListModel getBookingUpcomingResponse) {
  var size = MediaQuery.of(context).size;
  return getBookingUpcomingResponse.data!=null ?
  ListView.builder(
    physics: const BouncingScrollPhysics(),
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    itemCount: getBookingUpcomingResponse.data!.length,
    itemBuilder: (BuildContext context, int index) {
      var getData=getBookingUpcomingResponse.data![index];

      return Material(
        color: Colors.transparent,

        child: InkWell(
          splashColor: Colors.grey.withOpacity(0.5),
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  TrackPage(getBookingData: getData),
                ));

          },
          child: Column(
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
                    child: Image.network("$imageUrl${getData.routes!.vehicles!.featureImage}"),
                  ),
                  SizedBox(width: size.width * 0.005),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getData.name!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Montserrat-Regular',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: size.height * 0.005),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "booking id: ${getData.bookingsId}",
                            style: const TextStyle(
                              color: Color(0xFF565656),
                              fontSize: 8,
                              fontFamily: 'Montserrat-Regular',
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          SizedBox(width: size.width * 0.05),
                          SvgPicture.asset(
                              'assets/images/small-black-location-icon.svg'),
                          SizedBox(width: size.width * 0.01),
                          Text(
                            "${getData.routes!.pickup!.name}",
                            style: const TextStyle(
                              color: Color(0xFF565656),
                              fontSize: 8,
                              fontFamily: 'Montserrat-Regular',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.005),
                      Container(
                        width: 180,

                        child: Row(
                          children: [
                            for(int i=0; i<getData.vehicles!.length; i++)

                              Padding(
                                padding: const EdgeInsets.only(right: 2),
                                child: getData.vehicles!.length <4?
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset('assets/images/small-black-car-icon.svg'),
                                    SizedBox(width: size.width * 0.01),
                                    Text(
                                      '${getData.vehicles![i].vehiclesName!.name}',
                                      style: const TextStyle(
                                        color: Color(0xFF565656),
                                        fontSize: 7,
                                        fontFamily: 'Montserrat-Regular',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ):
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Column(

                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 4),
                                        child: SvgPicture.asset('assets/images/small-black-car-icon.svg'),
                                      ),
                                      Text(
                                        '${getData.vehicles![i].vehiclesName!.name}',
                                        style: const TextStyle(
                                          color: Color(0xFF565656),
                                          fontSize: 7,
                                          fontFamily: 'Montserrat-Regular',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
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
                          Text(
                            '${getData.bookingTime} ${getData.bookingDate}',
                            style: const TextStyle(
                              color: Color(0xFF565656),
                              fontSize: 8,
                              fontFamily: 'Montserrat-Regular',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // SizedBox(width: size.width * 0.1),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  TrackPage(getBookingData: getData),
                          ));
                    },
                    child:  Text(
                      '${getData.status}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF0066FF),
                        fontSize: 12,
                        fontFamily: 'Montserrat-Regular',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),
            ],
          ),
        ),
      );
    },
  ):Container(
    margin: EdgeInsets.only(left: 30),
    height: 300,
    width: 300,
    child: Center(child: const Text("No upcoming Booking")),
  );
}

List myList = [
  MyList("assets/images/list-image-1.png", "Makkah Hottle Aziziz"),
  MyList("assets/images/list-image-2.png", "Madina Airport"),
  MyList("assets/images/list-image-3.png", "Makkah Airport"),
  MyList("assets/images/list-image-4.png", "Madina Airport"),
  MyList("assets/images/list-image-1.png", "Makkah Hottle Aziziz"),
  MyList("assets/images/list-image-2.png", "Madina Airport"),
  MyList("assets/images/list-image-3.png", "Makkah Airport"),
  MyList("assets/images/list-image-4.png", "Madina Airport"),
];

class MyList {
  String? image;
  String? title;

  MyList(this.image, this.title);
}
