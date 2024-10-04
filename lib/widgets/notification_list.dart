import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:umrahcar_user/utils/colors.dart';

Widget notificationList(BuildContext context) {
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
                  Container(
                    color: Colors.transparent,
                    width: size.width * 0.45,
                    child: AutoSizeText(
                      myList[index].message,
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: 10,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                      minFontSize: 10,
                      maxFontSize: 10,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              if (myList[index].status == '11:30 AM')
                Container(
                  color: Colors.transparent,
                  width: size.width * 0.2,
                  height: size.height * 0.024,
                  child: Text(
                    myList[index].status,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      color: Color(0xFF565656),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              if (myList[index].status == '5')
                Container(
                  color: Colors.transparent,
                  width: size.width * 0.2,
                  height: size.height * 0.04,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF79BF42),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          myList[index].status,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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
  MyList("assets/images1/list-image-1.png", "Albert Flores",
      "Your Driver is on the Way so be Ready", "11:30 AM"),
  MyList("assets/images1/list-image-2.png", "Albert Flores",
      "Your Driver has Arrived on your Spot", "11:30 AM"),
  MyList("assets/images1/list-image-4.png", "Albert Flores",
      "Hi, I am waiting for you ", "5"),
];

class MyList {
  String? image;
  String? title;
  String? message;
  String? status;

  MyList(this.image, this.title, this.message, this.status);
}
