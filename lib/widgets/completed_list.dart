import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:umrahcar_user/screens/tracking_process/track_completed_screen.dart';
import 'package:umrahcar_user/utils/colors.dart';

import '../models/get_booking_list_model.dart';
import '../utils/const.dart';

Future<void> generateSingleBookingPDF(booking) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Container(
        padding: const pw.EdgeInsets.all(16),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Booking Details', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 12),
            pw.Text("Name: ${booking.name}", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Text("Booking ID: ${booking.bookingsId}"),
            pw.Text("Pickup: ${booking.routes?.pickup?.name ?? 'N/A'}"),
            pw.Text("Date & Time: ${_formatDate(booking.pickupDate!.toString())} ${_formatTime(booking.pickupTime!)}"),
            if (booking.vehicles != null)
              pw.Text("Vehicles: ${booking.vehicles!.map((v) => v.vehiclesName?.name ?? '').join(', ')}"),
            if (booking.paymentType == "credit") pw.Text("Payment: Credit"),
            if (booking.cashReceiveFromCustomer != "0")
              pw.Text("Cash Received: ${booking.cashReceiveFromCustomer}"),
          ],
        ),
      ),
    ),
  );

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}


Widget completedList(BuildContext context,GetBookingListModel getBookingCompletedResponse) {
  var size = MediaQuery.of(context).size;
  return getBookingCompletedResponse.data !=null ?
  ListView.builder(
    physics: const AlwaysScrollableScrollPhysics(),
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    itemCount: getBookingCompletedResponse.data!.length,
    itemBuilder: (BuildContext context, int index) {
      var getData=getBookingCompletedResponse.data![index];

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
                child: Image.network("$imageUrl${getData.routes!.vehicles!.featureImage}"),
              ),
              SizedBox(width: size.width * 0.005),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getData.name!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.005),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "booking id: ${getData.bookingsId}",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ConstantColor.darkgreyColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      SizedBox(width: size.width * 0.05),
                      SvgPicture.asset(
                        'assets/images1/small-black-location-icon.svg',
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      SizedBox(width: size.width * 0.01),
                      Text(
                        "${getData.routes!.pickup!.name}",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ConstantColor.darkgreyColor,
                          fontSize: 10,
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
                                SvgPicture.asset(
                                  'assets/images1/small-black-car-icon.svg',
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                                SizedBox(width: size.width * 0.01),
                                Text(
                                  '${getData.vehicles![i].vehiclesName!.name}',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: ConstantColor.darkgreyColor,
                                    fontSize: 10,
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
                                    child: SvgPicture.asset(
                                      'assets/images1/small-black-car-icon.svg',
                                      color: Theme.of(context).colorScheme.onSurface,
                                    ),
                                  ),
                                  Text(
                                    '${getData.vehicles![i].vehiclesName!.name}',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: ConstantColor.darkgreyColor,
                                      fontSize: 10,
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
                        'assets/images1/small-black-bookings-icon.svg',
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      SizedBox(width: size.width * 0.01),
                      Text(
                        '${_formatDate(getData.pickupDate!.toString())} ${_formatTime(getData.pickupTime!)}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ConstantColor.darkgreyColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                      ),
                    ],
                  ),
                ],
              ),
              // SizedBox(width: size.width * 0.10),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) =>  TrackPage(getBookingData: getData),
                      //     ));
                    },
                    child: Text(
                      'Completed',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ConstantColor.secondaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  GestureDetector(
                    onTap: () => generateSingleBookingPDF(getData),
                    child: Text(
                      'Download PDF',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ConstantColor.secondaryColor.withOpacity(0.7),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: size.height * 0.02),
        ],
      );
    },
  ):Container(
    height: 300,
    width: 300,
    child: Center(
      child: Text(
        "No Completed Booking",
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

String _formatDate(String date) {
  final DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);
  return DateFormat('d MMM yyyy').format(parsedDate);
}

String _formatTime(String time) {
  final DateTime parsedTime = DateFormat('HH:mm:ss').parse(time);
  return DateFormat('h:mm a').format(parsedTime);
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
