// To parse this JSON data, do
//
//     final getBookingListModel = getBookingListModelFromJson(jsonString);

import 'dart:convert';

GetBookingListModel getBookingListModelFromJson(String str) => GetBookingListModel.fromJson(json.decode(str));

String getBookingListModelToJson(GetBookingListModel data) => json.encode(data.toJson());

class GetBookingListModel {
  String? status;
  List<Datum>? data;

  GetBookingListModel({
    this.status,
    this.data,
  });

  factory GetBookingListModel.fromJson(Map<String, dynamic> json) => GetBookingListModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? bookingsId;
  String? parentId;
  String? usersAgentsId;
  String? name;
  String? contact;
  String? whatsapp;
  String? onesignalId;
  dynamic guestLattitude;
  dynamic guestLongitude;
  String? bookedBy;
  DateTime? bookingDate;
  String? bookingTime;
  String? routesId;
  String? routesDetails;
  dynamic pickupHotel;
  DropoffHotel? dropoffHotel;
  String? noOfPassengers;
  String? noOfAdults;
  String? noOfChilds;
  String? noOfInfants;
  String? pickupLocation;
  String? dropoffLocation;
  DateTime? pickupDate;
  String? pickupTime;
  String? flightCompaniesId;
  String? flightNumber;
  String? flightDetails;
  DateTime? flightDate;
  String? flightTime;
  String? actualFare;
  String? agentFare;
  String? bookedFare;
  String? cashReceiveFromCustomer;
  String? extraInformation;
  String? visaTypesId;
  String? serviceType;
  String? paymentType;
  DateTime? dateAdded;
  DateTime? dateModified;
  FinalStatus? finalStatus;
  String? finalStatusOther;
  String? paymentStatus;
  String? completedStatus;
  String? status;
  dynamic cancelReason;
  DriverTripStatus? driverTripStatus;
  DateTime? pickupDatetime;
  String? source;
  Routes? routes;
  UsersAgentsData? usersAgentsData;
  FlightCompanies? flightCompanies;
  VisaTypes? visaTypes;
  List<Vehicle>? vehicles;
  String? pendingUpdate;

  Datum({
    this.bookingsId,
    this.parentId,
    this.usersAgentsId,
    this.name,
    this.contact,
    this.whatsapp,
    this.onesignalId,
    this.guestLattitude,
    this.guestLongitude,
    this.bookedBy,
    this.bookingDate,
    this.bookingTime,
    this.routesId,
    this.routesDetails,
    this.pickupHotel,
    this.dropoffHotel,
    this.noOfPassengers,
    this.noOfAdults,
    this.noOfChilds,
    this.noOfInfants,
    this.pickupLocation,
    this.dropoffLocation,
    this.pickupDate,
    this.pickupTime,
    this.flightCompaniesId,
    this.flightNumber,
    this.flightDetails,
    this.flightDate,
    this.flightTime,
    this.actualFare,
    this.agentFare,
    this.bookedFare,
    this.cashReceiveFromCustomer,
    this.extraInformation,
    this.visaTypesId,
    this.serviceType,
    this.paymentType,
    this.dateAdded,
    this.dateModified,
    this.finalStatus,
    this.finalStatusOther,
    this.paymentStatus,
    this.completedStatus,
    this.status,
    this.cancelReason,
    this.driverTripStatus,
    this.pickupDatetime,
    this.source,
    this.routes,
    this.usersAgentsData,
    this.flightCompanies,
    this.visaTypes,
    this.vehicles,
    this.pendingUpdate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    bookingsId: json["bookings_id"],
    parentId: json["parent_id"],
    usersAgentsId: json["users_agents_id"],
    name: json["name"],
    contact: json["contact"],
    whatsapp: json["whatsapp"],
    onesignalId: json["onesignal_id"],
    guestLattitude: json["guest_lattitude"],
    guestLongitude: json["guest_longitude"],
    bookedBy: json["booked_by"],
    bookingDate: json["booking_date"] == null ? null : DateTime.parse(json["booking_date"]),
    bookingTime: json["booking_time"],
    routesId: json["routes_id"],
    routesDetails: json["routes_details"],
    pickupHotel: json["pickup_hotel"],
    dropoffHotel: json["dropoff_hotel"] == null ? null : DropoffHotel.fromJson(json["dropoff_hotel"]),
    noOfPassengers: json["no_of_passengers"],
    noOfAdults: json["no_of_adults"],
    noOfChilds: json["no_of_childs"],
    noOfInfants: json["no_of_infants"],
    pickupLocation: json["pickup_location"],
    dropoffLocation: json["dropoff_location"],
    pickupDate: json["pickup_date"] == null ? null : DateTime.parse(json["pickup_date"]),
    pickupTime: json["pickup_time"],
    flightCompaniesId: json["flight_companies_id"],
    flightNumber: json["flight_number"],
    flightDetails: json["flight_details"],
    flightDate: json["flight_date"] == null ? null : DateTime.parse(json["flight_date"]),
    flightTime: json["flight_time"],
    actualFare: json["actual_fare"],
    agentFare: json["agent_fare"],
    bookedFare: json["booked_fare"],
    cashReceiveFromCustomer: json["cash_receive_from_customer"],
    extraInformation: json["extra_information"],
    visaTypesId: json["visa_types_id"],
    serviceType: json["service_type"],
    paymentType: json["payment_type"],
    dateAdded: json["date_added"] == null ? null : DateTime.parse(json["date_added"]),
    dateModified: json["date_modified"] == null ? null : DateTime.parse(json["date_modified"]),
    finalStatus: json["final_status"] == null ? null : FinalStatus.fromJson(json["final_status"]),
    finalStatusOther: json["final_status_other"],
    paymentStatus: json["payment_status"],
    completedStatus: json["completed_status"],
    status: json["status"],
    cancelReason: json["cancel_reason"],
    driverTripStatus: json["driver_trip_status"] == null ? null : DriverTripStatus.fromJson(json["driver_trip_status"]),
    pickupDatetime: json["pickup_datetime"] == null ? null : DateTime.parse(json["pickup_datetime"]),
    source: json["source"],
    routes: json["routes"] == null ? null : Routes.fromJson(json["routes"]),
    usersAgentsData: json["users_agents_data"] == null ? null : UsersAgentsData.fromJson(json["users_agents_data"]),
    flightCompanies: json["flight_companies"] == null ? null : FlightCompanies.fromJson(json["flight_companies"]),
    visaTypes: json["visa_types"] == null ? null : VisaTypes.fromJson(json["visa_types"]),
    vehicles: json["vehicles"] == null ? [] : List<Vehicle>.from(json["vehicles"]!.map((x) => Vehicle.fromJson(x))),
    pendingUpdate: json["pending_update"],
  );

  Map<String, dynamic> toJson() => {
    "bookings_id": bookingsId,
    "parent_id": parentId,
    "users_agents_id": usersAgentsId,
    "name": name,
    "contact": contact,
    "whatsapp": whatsapp,
    "onesignal_id": onesignalId,
    "guest_lattitude": guestLattitude,
    "guest_longitude": guestLongitude,
    "booked_by": bookedBy,
    "booking_date": "${bookingDate!.year.toString().padLeft(4, '0')}-${bookingDate!.month.toString().padLeft(2, '0')}-${bookingDate!.day.toString().padLeft(2, '0')}",
    "booking_time": bookingTime,
    "routes_id": routesId,
    "routes_details": routesDetails,
    "pickup_hotel": pickupHotel,
    "dropoff_hotel": dropoffHotel?.toJson(),
    "no_of_passengers": noOfPassengers,
    "no_of_adults": noOfAdults,
    "no_of_childs": noOfChilds,
    "no_of_infants": noOfInfants,
    "pickup_location": pickupLocation,
    "dropoff_location": dropoffLocation,
    "pickup_date": "${pickupDate!.year.toString().padLeft(4, '0')}-${pickupDate!.month.toString().padLeft(2, '0')}-${pickupDate!.day.toString().padLeft(2, '0')}",
    "pickup_time": pickupTime,
    "flight_companies_id": flightCompaniesId,
    "flight_number": flightNumber,
    "flight_details": flightDetails,
    "flight_date": "${flightDate!.year.toString().padLeft(4, '0')}-${flightDate!.month.toString().padLeft(2, '0')}-${flightDate!.day.toString().padLeft(2, '0')}",
    "flight_time": flightTime,
    "actual_fare": actualFare,
    "agent_fare": agentFare,
    "booked_fare": bookedFare,
    "cash_receive_from_customer": cashReceiveFromCustomer,
    "extra_information": extraInformation,
    "visa_types_id": visaTypesId,
    "service_type": serviceType,
    "payment_type": paymentType,
    "date_added": dateAdded?.toIso8601String(),
    "date_modified": dateModified?.toIso8601String(),
    "final_status": finalStatus?.toJson(),
    "final_status_other": finalStatusOther,
    "payment_status": paymentStatus,
    "completed_status": completedStatus,
    "status": status,
    "cancel_reason": cancelReason,
    "driver_trip_status": driverTripStatus?.toJson(),
    "pickup_datetime": pickupDatetime?.toIso8601String(),
    "source": source,
    "routes": routes?.toJson(),
    "users_agents_data": usersAgentsData?.toJson(),
    "flight_companies": flightCompanies?.toJson(),
    "visa_types": visaTypes?.toJson(),
    "vehicles": vehicles == null ? [] : List<dynamic>.from(vehicles!.map((x) => x.toJson())),
    "pending_update": pendingUpdate,
  };
}

class DriverTripStatus {
  String? bookingsDriversStatusId;
  String? name;
  String? status;

  DriverTripStatus({
    this.bookingsDriversStatusId,
    this.name,
    this.status,
  });

  factory DriverTripStatus.fromJson(Map<String, dynamic> json) => DriverTripStatus(
    bookingsDriversStatusId: json["bookings_drivers_status_id"],
    name: json["name"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "bookings_drivers_status_id": bookingsDriversStatusId,
    "name": name,
    "status": status,
  };
}

class DropoffHotel {
  String? hotelsId;
  String? citiesId;
  String? name;
  String? city;
  String? status;

  DropoffHotel({
    this.hotelsId,
    this.citiesId,
    this.name,
    this.city,
    this.status,
  });

  factory DropoffHotel.fromJson(Map<String, dynamic> json) => DropoffHotel(
    hotelsId: json["hotels_id"],
    citiesId: json["cities_id"],
    name: json["name"],
    city: json["city"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "hotels_id": hotelsId,
    "cities_id": citiesId,
    "name": name,
    "city": city,
    "status": status,
  };
}

class FinalStatus {
  String? bookingsFinalStatusId;
  String? name;
  String? status;

  FinalStatus({
    this.bookingsFinalStatusId,
    this.name,
    this.status,
  });

  factory FinalStatus.fromJson(Map<String, dynamic> json) => FinalStatus(
    bookingsFinalStatusId: json["bookings_final_status_id"],
    name: json["name"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "bookings_final_status_id": bookingsFinalStatusId,
    "name": name,
    "status": status,
  };
}

class FlightCompanies {
  String? flightCompaniesId;
  String? name;
  String? code;
  String? status;

  FlightCompanies({
    this.flightCompaniesId,
    this.name,
    this.code,
    this.status,
  });

  factory FlightCompanies.fromJson(Map<String, dynamic> json) => FlightCompanies(
    flightCompaniesId: json["flight_companies_id"],
    name: json["name"],
    code: json["code"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "flight_companies_id": flightCompaniesId,
    "name": name,
    "code": code,
    "status": status,
  };
}

class Routes {
  String? routesId;
  String? routesPickupId;
  String? routesDropoffId;
  String? vehiclesId;
  String? fare;
  String? serviceType;
  String? status;
  Vehicles? vehicles;
  Dropoff? pickup;
  Dropoff? dropoff;

  Routes({
    this.routesId,
    this.routesPickupId,
    this.routesDropoffId,
    this.vehiclesId,
    this.fare,
    this.serviceType,
    this.status,
    this.vehicles,
    this.pickup,
    this.dropoff,
  });

  factory Routes.fromJson(Map<String, dynamic> json) => Routes(
    routesId: json["routes_id"],
    routesPickupId: json["routes_pickup_id"],
    routesDropoffId: json["routes_dropoff_id"],
    vehiclesId: json["vehicles_id"],
    fare: json["fare"],
    serviceType: json["service_type"],
    status: json["status"],
    vehicles: json["vehicles"] == null ? null : Vehicles.fromJson(json["vehicles"]),
    pickup: json["pickup"] == null ? null : Dropoff.fromJson(json["pickup"]),
    dropoff: json["dropoff"] == null ? null : Dropoff.fromJson(json["dropoff"]),
  );

  Map<String, dynamic> toJson() => {
    "routes_id": routesId,
    "routes_pickup_id": routesPickupId,
    "routes_dropoff_id": routesDropoffId,
    "vehicles_id": vehiclesId,
    "fare": fare,
    "service_type": serviceType,
    "status": status,
    "vehicles": vehicles?.toJson(),
    "pickup": pickup?.toJson(),
    "dropoff": dropoff?.toJson(),
  };
}

class Dropoff {
  String? routesDropoffId;
  String? routesPickupId;
  String? name;
  String? type;
  String? status;

  Dropoff({
    this.routesDropoffId,
    this.routesPickupId,
    this.name,
    this.type,
    this.status,
  });

  factory Dropoff.fromJson(Map<String, dynamic> json) => Dropoff(
    routesDropoffId: json["routes_dropoff_id"],
    routesPickupId: json["routes_pickup_id"],
    name: json["name"],
    type: json["type"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "routes_dropoff_id": routesDropoffId,
    "routes_pickup_id": routesPickupId,
    "name": name,
    "type": type,
    "status": status,
  };
}

class Vehicles {
  String? vehiclesId;
  String? name;
  String? noOfPassengers;
  String? featureImage;
  String? noOfBags;
  String? noOfDoors;
  String? ac;
  String? status;

  Vehicles({
    this.vehiclesId,
    this.name,
    this.noOfPassengers,
    this.featureImage,
    this.noOfBags,
    this.noOfDoors,
    this.ac,
    this.status,
  });

  factory Vehicles.fromJson(Map<String, dynamic> json) => Vehicles(
    vehiclesId: json["vehicles_id"],
    name: json["name"],
    noOfPassengers: json["no_of_passengers"],
    featureImage: json["feature_image"],
    noOfBags: json["no_of_bags"],
    noOfDoors: json["no_of_doors"],
    ac: json["ac"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "vehicles_id": vehiclesId,
    "name": name,
    "no_of_passengers": noOfPassengers,
    "feature_image": featureImage,
    "no_of_bags": noOfBags,
    "no_of_doors": noOfDoors,
    "ac": ac,
    "status": status,
  };
}

class UsersAgentsData {
  String? usersAgentsId;
  String? usersRolesId;
  String? onesignalId;
  String? walletAmount;
  String? creditLimit;
  String? imageUrl;
  String? username;
  String? name;
  String? email;
  String? password;
  String? agency;
  String? address;
  String? city;
  String? state;
  String? country;
  String? contact;
  String? mobile;
  String? whatsapp;
  String? landline;
  String? iataNumber;
  String? localLicenseNumber;
  String? serviceType;
  String? notificationSwitch;
  String? resetOtp;
  dynamic dateAdded;
  DateTime? dateModified;
  String? status;

  UsersAgentsData({
    this.usersAgentsId,
    this.usersRolesId,
    this.onesignalId,
    this.walletAmount,
    this.creditLimit,
    this.imageUrl,
    this.username,
    this.name,
    this.email,
    this.password,
    this.agency,
    this.address,
    this.city,
    this.state,
    this.country,
    this.contact,
    this.mobile,
    this.whatsapp,
    this.landline,
    this.iataNumber,
    this.localLicenseNumber,
    this.serviceType,
    this.notificationSwitch,
    this.resetOtp,
    this.dateAdded,
    this.dateModified,
    this.status,
  });

  factory UsersAgentsData.fromJson(Map<String, dynamic> json) => UsersAgentsData(
    usersAgentsId: json["users_agents_id"],
    usersRolesId: json["users_roles_id"],
    onesignalId: json["onesignal_id"],
    walletAmount: json["wallet_amount"],
    creditLimit: json["credit_limit"],
    imageUrl: json["image_url"],
    username: json["username"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
    agency: json["agency"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    contact: json["contact"],
    mobile: json["mobile"],
    whatsapp: json["whatsapp"],
    landline: json["landline"],
    iataNumber: json["iata_number"],
    localLicenseNumber: json["local_license_number"],
    serviceType: json["service_type"],
    notificationSwitch: json["notification_switch"],
    resetOtp: json["reset_otp"],
    dateAdded: json["date_added"],
    dateModified: json["date_modified"] == null ? null : DateTime.parse(json["date_modified"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "users_agents_id": usersAgentsId,
    "users_roles_id": usersRolesId,
    "onesignal_id": onesignalId,
    "wallet_amount": walletAmount,
    "credit_limit": creditLimit,
    "image_url": imageUrl,
    "username": username,
    "name": name,
    "email": email,
    "password": password,
    "agency": agency,
    "address": address,
    "city": city,
    "state": state,
    "country": country,
    "contact": contact,
    "mobile": mobile,
    "whatsapp": whatsapp,
    "landline": landline,
    "iata_number": iataNumber,
    "local_license_number": localLicenseNumber,
    "service_type": serviceType,
    "notification_switch": notificationSwitch,
    "reset_otp": resetOtp,
    "date_added": dateAdded,
    "date_modified": dateModified?.toIso8601String(),
    "status": status,
  };
}

class Vehicle {
  String? bookingsMultipleId;
  String? bookingsId;
  String? vehiclesId;
  String? usersDriversId;
  String? usersDriversFare;
  String? paidStatus;
  DateTime? dateAdded;
  DateTime? dateModified;
  VehiclesDrivers? vehiclesDrivers;
  Vehicles? vehiclesName;

  Vehicle({
    this.bookingsMultipleId,
    this.bookingsId,
    this.vehiclesId,
    this.usersDriversId,
    this.usersDriversFare,
    this.paidStatus,
    this.dateAdded,
    this.dateModified,
    this.vehiclesDrivers,
    this.vehiclesName,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
    bookingsMultipleId: json["bookings_multiple_id"],
    bookingsId: json["bookings_id"],
    vehiclesId: json["vehicles_id"],
    usersDriversId: json["users_drivers_id"],
    usersDriversFare: json["users_drivers_fare"],
    paidStatus: json["paid_status"],
    dateAdded: json["date_added"] == null ? null : DateTime.parse(json["date_added"]),
    dateModified: json["date_modified"] == null ? null : DateTime.parse(json["date_modified"]),
    vehiclesDrivers: json["vehicles_drivers"] == null ? null : VehiclesDrivers.fromJson(json["vehicles_drivers"]),
    vehiclesName: json["vehicles_name"] == null ? null : Vehicles.fromJson(json["vehicles_name"]),
  );

  Map<String, dynamic> toJson() => {
    "bookings_multiple_id": bookingsMultipleId,
    "bookings_id": bookingsId,
    "vehicles_id": vehiclesId,
    "users_drivers_id": usersDriversId,
    "users_drivers_fare": usersDriversFare,
    "paid_status": paidStatus,
    "date_added": dateAdded?.toIso8601String(),
    "date_modified": dateModified?.toIso8601String(),
    "vehicles_drivers": vehiclesDrivers?.toJson(),
    "vehicles_name": vehiclesName?.toJson(),
  };
}

class VehiclesDrivers {
  String? usersDriversId;
  String? parentId;
  String? onesignalId;
  String? longitude;
  String? lattitude;
  String? walletAmount;
  String? driversType;
  String? companyName;
  String? name;
  String? email;
  String? password;
  String? contact;
  String? whatsapp;
  String? city;
  String? rating;
  String? image;
  String? status;
  String? resetOtp;
  String? notificationSwitch;
  DateTime? dateAdded;
  DateTime? dateModified;

  VehiclesDrivers({
    this.usersDriversId,
    this.parentId,
    this.onesignalId,
    this.longitude,
    this.lattitude,
    this.walletAmount,
    this.driversType,
    this.companyName,
    this.name,
    this.email,
    this.password,
    this.contact,
    this.whatsapp,
    this.city,
    this.rating,
    this.image,
    this.status,
    this.resetOtp,
    this.notificationSwitch,
    this.dateAdded,
    this.dateModified,
  });

  factory VehiclesDrivers.fromJson(Map<String, dynamic> json) => VehiclesDrivers(
    usersDriversId: json["users_drivers_id"],
    parentId: json["parent_id"],
    onesignalId: json["onesignal_id"],
    longitude: json["longitude"],
    lattitude: json["lattitude"],
    walletAmount: json["wallet_amount"],
    driversType: json["drivers_type"],
    companyName: json["company_name"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
    contact: json["contact"],
    whatsapp: json["whatsapp"],
    city: json["city"],
    rating: json["rating"],
    image: json["image"],
    status: json["status"],
    resetOtp: json["reset_otp"],
    notificationSwitch: json["notification_switch"],
    dateAdded: json["date_added"] == null ? null : DateTime.parse(json["date_added"]),
    dateModified: json["date_modified"] == null ? null : DateTime.parse(json["date_modified"]),
  );

  Map<String, dynamic> toJson() => {
    "users_drivers_id": usersDriversId,
    "parent_id": parentId,
    "onesignal_id": onesignalId,
    "longitude": longitude,
    "lattitude": lattitude,
    "wallet_amount": walletAmount,
    "drivers_type": driversType,
    "company_name": companyName,
    "name": name,
    "email": email,
    "password": password,
    "contact": contact,
    "whatsapp": whatsapp,
    "city": city,
    "rating": rating,
    "image": image,
    "status": status,
    "reset_otp": resetOtp,
    "notification_switch": notificationSwitch,
    "date_added": dateAdded?.toIso8601String(),
    "date_modified": dateModified?.toIso8601String(),
  };
}

class VisaTypes {
  String? visaTypesId;
  String? name;
  String? status;

  VisaTypes({
    this.visaTypesId,
    this.name,
    this.status,
  });

  factory VisaTypes.fromJson(Map<String, dynamic> json) => VisaTypes(
    visaTypesId: json["visa_types_id"],
    name: json["name"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "visa_types_id": visaTypesId,
    "name": name,
    "status": status,
  };
}
