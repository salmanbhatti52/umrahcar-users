import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:umrahcar_user/utils/colors.dart';
import 'package:umrahcar_user/widgets/button.dart';
import 'package:umrahcar_user/screens/tracking_process/tarcking/pickup_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;
import '../../models/get_all_system_data_model.dart';
import '../../models/get_booking_list_model.dart';
import '../../models/get_driver_profile.dart';
import '../../models/update_user_location.dart';
import '../../service/rest_api_service.dart';

class TrackPage extends StatefulWidget {
  Datum? getBookingData;
  TrackPage({super.key, this.getBookingData});

  @override
  State<TrackPage> createState() => _TrackPageState();
}

class _TrackPageState extends State<TrackPage> {
  void _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  showSnackbar({error, context}) {
    final snackBar = SnackBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      content: Text(error, style: Theme.of(context).textTheme.bodyMedium),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  LatLng _initialCameraPosition = const LatLng(20.5937, 78.9629);
  GoogleMapController? _controller;
  final Location _location = Location();

  void _onMapCreated(GoogleMapController cntlr) {
    _controller = cntlr;
    _location.onLocationChanged.listen((l) {
      if (l.latitude != null && l.longitude != null) {
        _controller?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(lat!, long!), zoom: 17),
          ),
        );
      }
    });
  }

  double? lat;
  double? long;
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

  Future<void> getSystemAllData() async {
    getAllSystemData = await DioClient().getSystemAllData(context);
    print("GETSystemAllData: ${getAllSystemData.data}");
    setState(() {
      getSettingsData();
    });
  }

  late List<Setting> pickSettingsData = [];
  int timerCount = 3;

  void getSettingsData() {
    if (getAllSystemData.data != null) {
      pickSettingsData.addAll(getAllSystemData.data!.settings!);
      for (var setting in pickSettingsData) {
        switch (setting.type) {
          case "map_refresh_time":
            timerCount = int.parse(setting.description!);
            if (widget.getBookingData!.vehicles![0].vehiclesDrivers != null) {
              print("timer refresh: $timerCount");
              _startTimers();
            }
            break;
          case "lattitude":
            if (widget.getBookingData!.vehicles![0].vehiclesDrivers == null) {
              lat = double.parse(setting.description!);
              print("timer lat: $timerCount");
            }
            break;
          case "longitude":
            if (widget.getBookingData!.vehicles![0].vehiclesDrivers == null) {
              long = double.parse(setting.description!);
              print("timer long: $timerCount");
            }
            break;
        }
      }
    }
  }

  void _startTimers() {
    getProfile();
    _getCurrentLocation();
    timer = Timer.periodic(Duration(minutes: timerCount), (timer) {
      getProfile();
      _getCurrentLocation();
    });
  }

  @override
  void initState() {
    super.initState();
    getSystemAllData();
    _initialCameraPosition = const LatLng(20.5937, 78.9629);
    addCustomIcon();
    if (widget.getBookingData!.vehicles![0].vehiclesDrivers != null) {
      print(
          "lat: ${widget.getBookingData!.vehicles![0].vehiclesDrivers!.lattitude}");
      print(
          "log: ${widget.getBookingData!.vehicles![0].vehiclesDrivers!.longitude}");
    }
  }

  GetDriverProfile getProfileResponse = GetDriverProfile();

  Future<void> getProfile() async {
    print("userIdId ${widget.getBookingData!.vehicles![0].usersDriversId}");
    getProfileResponse = await DioClient().getProfile(
        widget.getBookingData!.vehicles![0].usersDriversId, context);
    if (getProfileResponse.data != null) {
      lat = double.parse(getProfileResponse.data!.userData!.lattitude!);
      long = double.parse(getProfileResponse.data!.userData!.longitude!);
      setState(() {});
    }
  }

  Future<Position> getUserCurrentLocation() async {
    try {
      await Geolocator.requestPermission();
    } catch (e) {
      print("ERROR: $e");
      await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition();
  }

  Location location = Location();
  LatLng initialPosition = const LatLng(0, 0);

  Future<void> _getCurrentLocation() async {
    if (!await location.serviceEnabled() && !await location.requestService()) {
      return;
    }
    if (await location.hasPermission() == PermissionStatus.denied &&
        await location.requestPermission() != PermissionStatus.granted) return;

    LocationData currentLocation = await location.getLocation();
    initialPosition =
        LatLng(currentLocation.latitude!, currentLocation.longitude!);
    print(
        "latitude1: ${currentLocation.latitude}, longitude1: ${currentLocation.longitude}");

    var jsonData = {
      "bookings_id": "${widget.getBookingData!.bookingsId}",
      "guest_lattitude": "${currentLocation.latitude}",
      "guest_longitude": "${currentLocation.longitude}"
    };

    UpdateUserLocation response =
        await DioClient().updateUserLocation(jsonData, context);
    print("message: ${response.message}");
    setState(() {});
  }

  Set<Marker> _buildMarkers() {
    return {
      Marker(
        markerId: const MarkerId('Pakistan'),
        position:
            LatLng(lat ?? 0.0, long ?? 0.0), // Default values to prevent null
        draggable: true,
        icon: icon ?? BitmapDescriptor.defaultMarker,
      ),
    };
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print("latlat: $lat");
    print("long: $long");
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: (getProfileResponse.data != null || (lat != null && long != null))
          ? Container(
              color: Colors.transparent,
              width: size.width,
              height: size.height,
              child: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2.28,
                    child: GoogleMap(
                      initialCameraPosition:
                          CameraPosition(target: _initialCameraPosition),
                      mapType: MapType.satellite,
                      onMapCreated: _onMapCreated,
                      myLocationEnabled: false,
                      markers: _buildMarkers(),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: size.width,
                      height: size.height * 0.56,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        border: Border.all(
                          width: 1,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15),
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
                                children: [
                                   Text(
                                    'Bookings Details',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    '(Booking Id ${widget.getBookingData!.bookingsId})',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.02),
                              Text(
                                'Pickup Location',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: ConstantColor.greyColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: size.height * 0.02),
                              Text(
                                '${widget.getBookingData!.routes!.pickup!.name} (${widget.getBookingData!.routes!.pickup!.type})',
                                style:  Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: ConstantColor.darkgreyColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: size.height * 0.02),
                               Text(
                                'Drop off Location',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: ConstantColor.greyColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: size.height * 0.02),
                              Text(
                                '${widget.getBookingData!.routes!.dropoff!.name} (${widget.getBookingData!.routes!.dropoff!.type})',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: ConstantColor.darkgreyColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: size.height * 0.025),
                              Row(
                                children: [
                                  for (int i = 0;
                                      i <
                                          widget
                                              .getBookingData!.vehicles!.length;
                                      i++)
                                    Padding(
                                      padding: const EdgeInsets.only(right: 7),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/fast-car-icon.svg',
                                            width: 10,
                                            height: 10,
                                            color: Theme.of(context).colorScheme.onSurface,
                                          ),
                                          SizedBox(width: size.width * 0.01),
                                          Text(
                                            '${widget.getBookingData!.vehicles![i].vehiclesName!.name}',
                                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              color: ConstantColor.darkgreyColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.02),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/small-black-bookings-icon.svg',
                                        width: 20,
                                        height: 20,
                                        color: Theme.of(context).colorScheme.onSurface,
                                      ),
                                      SizedBox(width: size.width * 0.032),
                                      Text(
                                        '${widget.getBookingData!.flightDate}',
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          color: ConstantColor.darkgreyColor,
                                          fontSize: 12,
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
                                        color: Theme.of(context).colorScheme.onSurface,
                                      ),
                                      SizedBox(width: size.width * 0.032),
                                      Text(
                                        '${widget.getBookingData!.pickupTime}',
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          color: ConstantColor.darkgreyColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              if (widget.getBookingData!.vehicles![0]
                                      .vehiclesDrivers !=
                                  null)
                                SizedBox(height: size.height * 0.02),
                              if (widget.getBookingData!.vehicles![0]
                                      .vehiclesDrivers !=
                                  null)
                                Divider(
                                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                                  thickness: 1,
                                ),
                              if (widget.getBookingData!.vehicles![0]
                                      .vehiclesDrivers !=
                                  null)
                                SizedBox(height: size.height * 0.01),
                              if (widget.getBookingData!.vehicles![0]
                                      .vehiclesDrivers !=
                                  null)
                                 Text(
                                  'Driver Details',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              if (widget.getBookingData!.vehicles![0]
                                      .vehiclesDrivers !=
                                  null)
                                SizedBox(height: size.height * 0.04),
                              if (widget.getBookingData!.vehicles![0]
                                      .vehiclesDrivers !=
                                  null)
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Theme.of(context).colorScheme.surface,
                                          child: Image.asset(
                                            'assets/images/user-profile.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(width: size.width * 0.032),
                                        SizedBox(
                                          width: size.width * 0.275,
                                          child: Text(
                                            '${widget.getBookingData!.vehicles![0].vehiclesDrivers!.name}',
                                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              color: ConstantColor.darkgreyColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: size.width * 0.115),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/location-icon.svg',
                                          width: 20,
                                          height: 20,
                                          color: Theme.of(context).colorScheme.onSurface,
                                        ),
                                        SizedBox(width: size.width * 0.045),
                                        SizedBox(
                                          width: size.width * 0.275,
                                          child: Text(
                                            '${widget.getBookingData!.vehicles![0].vehiclesDrivers!.city}',
                                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              color: ConstantColor.darkgreyColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              if (widget.getBookingData!.vehicles![0]
                                      .vehiclesDrivers !=
                                  null)
                                SizedBox(height: size.height * 0.02),
                              if (widget.getBookingData!.vehicles![0]
                                      .vehiclesDrivers !=
                                  null)
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        Uri phoneno = Uri.parse(
                                            'tel: ${widget.getBookingData!.vehicles![0].vehiclesDrivers!.contact}');
                                        if (await launchUrl(phoneno)) {
                                          //dialer opened
                                        } else {
                                          //dailer is not opened
                                        }
                                        print(
                                            "iddddd ${widget.getBookingData!.vehicles![0].usersDriversId}");
                                      },
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              color: Theme.of(context).colorScheme.onSurface,
                                              'assets/images/contact-icon.svg'),
                                          SizedBox(width: size.width * 0.032),
                                          SizedBox(
                                            width: size.width * 0.275,
                                            child: Text(
                                              '${widget.getBookingData!.vehicles![0].vehiclesDrivers!.contact}',
                                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                color: ConstantColor.darkgreyColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: size.width * 0.14),
                                    InkWell(
                                      onTap: () {
                                        print(
                                            "nmbr: ${widget.getBookingData!.vehicles![0].vehiclesDrivers!.whatsapp}");
                                        _launchURL(
                                            'https://wa.me/${widget.getBookingData!.vehicles![0].vehiclesDrivers!.whatsapp}/?text=hello');
                                        setState(() {});
                                      },
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              color: Theme.of(context).colorScheme.onSurface,
                                              'assets/images/whatsapp-icon.svg'),
                                          SizedBox(width: size.width * 0.032),
                                          SizedBox(
                                            width: size.width * 0.275,
                                            child: Text(
                                              '${widget.getBookingData!.vehicles![0].vehiclesDrivers!.whatsapp}',
                                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                color: ConstantColor.darkgreyColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              SizedBox(height: size.height * 0.02),
                              Divider(
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                                thickness: 1,
                              ),
                              // if (widget.getBookingData!.bookedFare != "0")
                              //   SizedBox(height: size.height * 0.01),
                              // if (widget.getBookingData!.bookedFare != "0")
                              //   Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       const Text(
                              //         'Booked Fare',
                              //         style: TextStyle(
                              //           color: Color(0xFF929292),
                              //           fontSize: 12,
                              //           fontFamily: 'Montserrat-Regular',
                              //           fontWeight: FontWeight.w400,
                              //         ),
                              //       ),
                              //       SizedBox(height: size.height * 0.03),
                              //       widget.getBookingData!.paymentType ==
                              //               "credit"
                              //           ? const Text(
                              //               'credit',
                              //               style: TextStyle(
                              //                 color: Color(0xFF565656),
                              //                 fontSize: 12,
                              //                 fontFamily: 'Montserrat-Regular',
                              //                 fontWeight: FontWeight.w500,
                              //               ),
                              //             )
                              //           : Text(
                              //               '${widget.getBookingData!.bookedFare}',
                              //               style: const TextStyle(
                              //                 color: Color(0xFF565656),
                              //                 fontSize: 12,
                              //                 fontFamily: 'Montserrat-Regular',
                              //                 fontWeight: FontWeight.w500,
                              //               ),
                              //             )
                              //     ],
                              //   ),
                              if (widget.getBookingData!
                                      .cashReceiveFromCustomer !=
                                  "0")
                                SizedBox(height: size.height * 0.02),
                              if (widget.getBookingData!
                                      .cashReceiveFromCustomer !=
                                  "0")
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                     Text(
                                      'Cash Receive From Customer',
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: ConstantColor.darkgreyColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.02),
                                    Text(
                                      'cash (${widget.getBookingData!.cashReceiveFromCustomer})',
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: ConstantColor.darkgreyColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              SizedBox(height: size.height * 0.03),
                              if (widget.getBookingData!.vehicles![0]
                                      .vehiclesDrivers !=
                                  null)
                                widget.getBookingData!.driverTripStatus !=
                                            null &&
                                        widget.getBookingData!.driverTripStatus!
                                                 ==
                                            "Ride End"
                                    ? GestureDetector(
                                        onTap: () {
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //       builder: (context) =>  PickUpPage(getBookingData: widget.getBookingData),
                                          //     ));
                                        },
                                        child: button('Completed', context),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PickUpPage(
                                                        getBookingData: widget
                                                            .getBookingData),
                                              ));
                                        },
                                        child: button('Track', context),
                                      ),
                              SizedBox(height: size.height * 0.02),
                            ],
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
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/images/back-icon.svg',
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 175, top: 30),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.onSurface),
            ),
          ),
        ],
      ),
    );
  }
}
