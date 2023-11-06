import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:umrahcar_user/utils/colors.dart';
import 'package:umrahcar_user/widgets/button.dart';
import 'package:umrahcar_user/screens/tracking_process/tarcking/chat_screen.dart';
import 'package:umrahcar_user/screens/tracking_process/tarcking/dropoff_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/distance_calculate_model.dart';
import '../../../models/get_all_system_data_model.dart';
import '../../../models/get_booking_list_model.dart';
import 'dart:ui' as ui;

import '../../../models/get_driver_profile.dart';
import '../../../models/update_user_location.dart';
import '../../../service/rest_api_service.dart';
import '../../homepage_screen.dart';
class PickUpPage extends StatefulWidget {
  GetBookingData? getBookingData;
  PickUpPage({super.key, this.getBookingData});

  @override
  State<PickUpPage> createState() => _PickUpPageState();
}

class _PickUpPageState extends State<PickUpPage> {
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  GoogleMapController? _controller;
  Location _location = Location();

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(lat!, long!), zoom: 17),
        ),
      );
    });
  }

  double? lat;
  double? long;
  @override
  var icon;
  BitmapDescriptor? markerIcon;
  void addCustomIcon() async {
    icon = await getBitmapDescriptorFromAssetBytes(
        "assets/images/location.png", 50);
    setState(() {});
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(
      String path, int width) async {
    final Uint8List imageData = await getBytesFromAsset(path, width);
    return BitmapDescriptor.fromBytes(imageData);
  }

  Timer? timer;
  GetAllSystemData getAllSystemData = GetAllSystemData();

  getSystemAllData() async {
    getAllSystemData = await DioClient().getSystemAllData(context);
    if (getAllSystemData != null) {
      print("GETSystemAllData: ${getAllSystemData.data}");
      setState(() {
        getSettingsData();
      });
    }
  }

  late List<Setting> pickSettingsData = [];
  int timerCount=3;
  getSettingsData() {
    if (getAllSystemData!.data! != null) {
      for (int i = 0; i < getAllSystemData!.data!.settings!.length; i++) {
        pickSettingsData.add(getAllSystemData!.data!.settings![i]);
        print("Setting time= $pickSettingsData");
      }

      for (int i = 0; i < pickSettingsData.length; i++) {
        if (pickSettingsData[i].type == "map_refresh_time") {

          timerCount = int.parse(pickSettingsData[i].description!);
          if (widget.getBookingData!.vehicles![0].vehiclesDrivers != null) {
            print("timer refresh: ${timerCount}");
            getProfile();
            _getCurrentLocation();
            timer =
                Timer.periodic( Duration(seconds: timerCount*60), (timer) => getProfile());
            timer =
                Timer.periodic( Duration(seconds: timerCount*60), (timer) => _getCurrentLocation());

            setState(() {});

          }
        } else if (pickSettingsData[i].type == "lattitude" && widget.getBookingData!.vehicles![0].vehiclesDrivers == null) {
          lat = double.parse(pickSettingsData[i].description!);
          print("timer lat: ${timerCount}");
        } else if (pickSettingsData[i].type == "longitude"  && widget.getBookingData!.vehicles![0].vehiclesDrivers == null) {
          long = double.parse(pickSettingsData[i].description!);
          calculateDistance(widget.getBookingData!.vehicles![0].vehiclesDrivers!.longitude,widget.getBookingData!.vehicles![0].vehiclesDrivers!.lattitude);
          print("timer long: ${timerCount}");
        }
      }
    }
  }
  GetBookingListModel getBookingOngoingResponse=GetBookingListModel();
   String statuses="Assigned";
  getBookingListOngoing()async{
    print("phoneNmbr $phoneNmbr");
    var mapData={
      "contact": phoneNmbr.toString()
    };
    getBookingOngoingResponse= await DioClient().getBookingOngoing(mapData, context);
    print("response id: ${getBookingOngoingResponse.data}");
    for(int i=0;i<getBookingOngoingResponse.data!.length;i++){
      if(getBookingOngoingResponse.data![i].bookingsId==widget.getBookingData!.bookingsId){
        print("Driver Status: ${getBookingOngoingResponse.data![i].driverTripStatus!.name!}");
        String? latt=getBookingOngoingResponse.data![i].vehicles![0].vehiclesDrivers!.lattitude;
        String? longg=getBookingOngoingResponse.data![i].vehicles![0].vehiclesDrivers!.longitude;
        statuses=getBookingOngoingResponse.data![i].driverTripStatus!.name!;
        print("statusessss: ${statuses}");
        calculateDistance(longg,latt);

        if(statuses=="Reached"){
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => driverReached(),
          );
          setState(() {

          });
        }
        setState(() {

        });
      }
    }
    setState(() {

    });

  }
  DistanceCalculatorModel distanceCalculatorModel=DistanceCalculatorModel();

  String? distance="";
  calculateDistance(String? longg,String? latt)async{
    var jsonData={
      "from_lat":"${latt}",
      "from_long":"${longg}",
      "to_lat":"${lat}",
      "to_long":"${long}"
    };
    print("jsonjsonData: ${jsonData}");
    distanceCalculatorModel=await DioClient().distanceCalculate(jsonData, context);
    if(distanceCalculatorModel.data !=null){
      print("distanceeee: ${distanceCalculatorModel.data!.distance}");
      distance=distanceCalculatorModel.data!.distance;
      setState(() {

      });
    }
  }
  void initState() {
    getSystemAllData();

    addCustomIcon();
    if (widget.getBookingData!.vehicles![0].vehiclesDrivers != null) {

      print(
          "lat: ${widget.getBookingData!.vehicles![0].vehiclesDrivers!.lattitude}");
      print(
          "log: ${widget.getBookingData!.vehicles![0].vehiclesDrivers!.longitude}");
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  GetDriverProfile getProfileResponse = GetDriverProfile();
  getProfile() async {
    print("userIdId ${widget.getBookingData!.vehicles![0].usersDriversId}");

    getProfileResponse = await DioClient().getProfile(
        widget.getBookingData!.vehicles![0].usersDriversId, context);
    if (getProfileResponse.data != null) {
      print(
          "getProfileResponse name: ${getProfileResponse.data!.userData!.name}");
      long = double.parse(getProfileResponse.data!.userData!.longitude!);
      lat = double.parse(getProfileResponse.data!.userData!.lattitude!);
      getBookingListOngoing();
      setState(() {});
    }
    setState(() {});
  }

  Location location = Location();
  LatLng initialPosition = LatLng(0, 0);
  void _getCurrentLocation() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return;
      }
    }

    LocationData currentLocation = await location.getLocation();
    initialPosition = LatLng(currentLocation.latitude!, currentLocation.longitude!);
    print("latitude1: ${currentLocation.latitude}");
    print("longitude1: ${currentLocation.longitude}");
    var jsonData={
      "bookings_id":"${widget.getBookingData!.bookingsId}",
      "guest_lattitude":"${currentLocation.latitude}",
      "guest_longitude":"${currentLocation.longitude}"
    };
    print("jsonData: ${jsonData}");
    UpdateUserLocation response= await DioClient().updateUserLocation(jsonData, context);
    if(response!=null){
      print("message: ${response.message}");
    }
    setState(() {

    });
  }



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print("markerIcon: ${markerIcon}");
    return Scaffold(
      backgroundColor: mainColor,
      body: getProfileResponse.data !=null ?
      Container(
        color: Colors.transparent,
        width: size.width,
        height: size.height,
        child: Stack(
          children: [

            GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: _initialcameraposition),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: false,
              markers: {
                Marker(
                    markerId: MarkerId('Pakistan'),
                    position: LatLng(lat!, long!),
                    draggable: true,

                    icon: icon!=null ?  icon!: BitmapDescriptor.defaultMarker)
              },
            ),
            Positioned(
              bottom: 0,
              child: GestureDetector(
                onTap: () {

                },
                child: Container(
                  width: size.width,
                  height: size.height * 0.28,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    border: Border.all(
                      width: 1,
                      color: const Color(0xFF000000).withOpacity(0.15),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: size.height * 0.03),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                statuses,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                 fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                               Text(
                                '${distance} Away',
                                style:  TextStyle(
                                  color: secondaryColor,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.03),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    child: Image.asset(
                                      'assets/images/user-profile.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: size.width * 0.04),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${widget.getBookingData!.vehicles![0].vehiclesDrivers!.name}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                           fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: size.height * 0.003),
                                        Text(
                                          '${widget.getBookingData!.vehicles![0].vehiclesDrivers!.contact}',
                                          style: const TextStyle(
                                            color: Color(0xFF929292),
                                            fontSize: 12,
                                           fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        print(
                                            "iddddd ${widget.getBookingData!.vehicles![0].usersDriversId}");
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ChatPage(
                                                  bookingId: widget
                                                      .getBookingData!
                                                      .bookingsId,
                                                  usersDriverId: widget
                                                      .getBookingData!
                                                      .vehicles![0]
                                                      .usersDriversId,
                                                  guestName: widget
                                                      .getBookingData!.name,
                                                  driverName: widget
                                                      .getBookingData!
                                                      .vehicles![0]
                                                      .vehiclesDrivers!
                                                      .name),
                                            ));
                                      },
                                      child: SvgPicture.asset(
                                        'assets/images/chat-icon.svg',
                                      ),
                                    ),
                                    SizedBox(width: size.width * 0.06),
                                    SvgPicture.asset(
                                      'assets/images/contact-icon.svg',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.03),
                          Row(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/small-black-bookings-icon.svg',
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(width: size.width * 0.032),
                                  Text(
                                    '${widget.getBookingData!.pickupDate}',
                                    style: const TextStyle(
                                      color: Color(0xFF565656),
                                      fontSize: 12,
                                     fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: size.width * 0.14),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/clock-icon.svg',
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(width: size.width * 0.032),
                                  Text(
                                    '${widget.getBookingData!.pickupTime}',
                                    style: const TextStyle(
                                      color: Color(0xFF565656),
                                      fontSize: 12,
                                     fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.02),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/clock-icon.svg',
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(width: size.width * 0.032),
                              Text(
                                '${widget.getBookingData!.flightTime}',
                                style: const TextStyle(
                                  color: Color(0xFF565656),
                                  fontSize: 12,
                                 fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              // SizedBox(width: size.width * 0.05),
                              // const Text(
                              //   'Waiting',
                              //   style: TextStyle(
                              //     color: Color(0xFF79BF42),
                              //     fontSize: 12,
                              //     fontFamily: 'Montserrat-Regular',
                              //     fontWeight: FontWeight.w500,
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    height: 40,
                    width: 40,
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        SvgPicture.asset('assets/images/back-icon.svg'),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ): const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 175),
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          )
        ],
      ),
    );
  }

  Widget driverReached() {
    var size = MediaQuery.of(context).size;
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      insetPadding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        height: size.height * 0.65,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 250),
                child: IconButton(onPressed: (){
                  Navigator.pop(context);
                  setState(() {

                  });
                }, icon: Icon(Icons.cancel, size: 30),),
              ),
              SizedBox(height: size.height * 0.02),
              CircleAvatar(
                radius: 45,
                child: Image.asset(
                  'assets/images/profile.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: size.height * 0.02),
               Text(
                '${widget.getBookingData!.vehicles![0].vehiclesDrivers!.name}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF565656),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                 fontFamily: 'Poppins',
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/green-fast-car-icon.svg'),
                  SizedBox(width: size.width * 0.02),
                   Text(
                    '${widget.getBookingData!.vehicles![0].vehiclesName!.name}',
                    style:  TextStyle(
                      color: secondaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                     fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.04),
              const Text(
                'Your Driver has\nReached on your Spot',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(height: size.height * 0.08),
              GestureDetector(
                  onTap: () async {
                      Uri phoneno = Uri.parse('tel: ${widget.getBookingData!.vehicles![0].vehiclesDrivers!.contact}');
                      if (await launchUrl(phoneno)) {
                        //dialer opened
                      }else{
                        //dailer is not opened
                      }
                    print(
                        "iddddd ${widget.getBookingData!.vehicles![0].usersDriversId}");

                  },
                  child: dialogButtonTransparent('Contact', context)),

            ],
          ),
        ),
      ),
    );
  }
}
