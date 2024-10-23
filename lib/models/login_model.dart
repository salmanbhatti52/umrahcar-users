class LoginModel {
  String? status;
  Data? data;

  LoginModel({
    this.status,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data!.toJson(),
      };
}

class Data {
  int? bookingsAll;
  int? bookingsPending;
  int? bookingsCompleted;
  GuestData? guestData;

  Data({
    this.bookingsAll,
    this.bookingsPending,
    this.bookingsCompleted,
    this.guestData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bookingsAll: json["bookings_all"],
        bookingsPending: json["bookings_pending"],
        bookingsCompleted: json["bookings_completed"],
        guestData: GuestData.fromJson(json["guest_data"]),
      );

  Map<String, dynamic> toJson() => {
        "bookings_all": bookingsAll,
        "bookings_pending": bookingsPending,
        "bookings_completed": bookingsCompleted,
        "guest_data": guestData!.toJson(),
      };
}

class GuestData {
  String? bookingsId;
  String? parentId;
  String? usersAgentsId;
  String? name;
  String? contact;
  String? whatsapp;
  String? onesignalId;
  String? guestLattitude;
  String? guestLongitude;
  String? bookedBy;
  String? bookingDate;
  String? bookingTime;
  String? routesId;
  String? routesDetails;
  String? pickupHotel;
  String? dropoffHotel;
  String? noOfPassengers;
  String? noOfAdults;
  String? noOfChilds;
  String? noOfInfants;
  String? pickupLocation;
  String? dropoffLocation;
  String? pickupDate;
  String? pickupTime;
  String? flightCompaniesId;
  String? flightNumber;
  String? flightDetails;
  String? flightDate;
  String? flightTime;
  String? actualFare;
  String? agentFare;
  String? bookedFare;
  String? cashReceiveFromCustomer;
  String? extraInformation;
  String? visaTypesId;
  String? serviceType;
  String? paymentType;
  String? dateAdded;
  String? dateModified;
  String? finalStatus;
  String? finalStatusOther;
  String? paymentStatus;
  String? completedStatus;
  String? status;
  String? cancelReason;
  String? driverTripStatus;
  String? pickupDatetime;
  String? source;

  GuestData({
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
  });

  factory GuestData.fromJson(Map<String, dynamic> json) => GuestData(
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
        bookingDate: json["booking_date"],
        bookingTime: json["booking_time"],
        routesId: json["routes_id"],
        routesDetails: json["routes_details"],
        pickupHotel: json["pickup_hotel"],
        dropoffHotel: json["dropoff_hotel"],
        noOfPassengers: json["no_of_passengers"],
        noOfAdults: json["no_of_adults"],
        noOfChilds: json["no_of_childs"],
        noOfInfants: json["no_of_infants"],
        pickupLocation: json["pickup_location"],
        dropoffLocation: json["dropoff_location"],
        pickupDate: json["pickup_date"],
        pickupTime: json["pickup_time"],
        flightCompaniesId: json["flight_companies_id"],
        flightNumber: json["flight_number"],
        flightDetails: json["flight_details"],
        flightDate: json["flight_date"],
        flightTime: json["flight_time"],
        actualFare: json["actual_fare"],
        agentFare: json["agent_fare"],
        bookedFare: json["booked_fare"],
        cashReceiveFromCustomer: json["cash_receive_from_customer"],
        extraInformation: json["extra_information"],
        visaTypesId: json["visa_types_id"],
        serviceType: json["service_type"],
        paymentType: json["payment_type"],
        dateAdded: json["date_added"],
        dateModified: json["date_modified"],
        finalStatus: json["final_status"],
        finalStatusOther: json["final_status_other"],
        paymentStatus: json["payment_status"],
        completedStatus: json["completed_status"],
        status: json["status"],
        cancelReason: json["cancel_reason"],
        driverTripStatus: json["driver_trip_status"],
        pickupDatetime: json["pickup_datetime"],
        source: json["source"],
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
        "booking_date": bookingDate,
        "booking_time": bookingTime,
        "routes_id": routesId,
        "routes_details": routesDetails,
        "pickup_hotel": pickupHotel,
        "dropoff_hotel": dropoffHotel,
        "no_of_passengers": noOfPassengers,
        "no_of_adults": noOfAdults,
        "no_of_childs": noOfChilds,
        "no_of_infants": noOfInfants,
        "pickup_location": pickupLocation,
        "dropoff_location": dropoffLocation,
        "pickup_date": pickupDate,
        "pickup_time": pickupTime,
        "flight_companies_id": flightCompaniesId,
        "flight_number": flightNumber,
        "flight_details": flightDetails,
        "flight_date": flightDate,
        "flight_time": flightTime,
        "actual_fare": actualFare,
        "agent_fare": agentFare,
        "booked_fare": bookedFare,
        "cash_receive_from_customer": cashReceiveFromCustomer,
        "extra_information": extraInformation,
        "visa_types_id": visaTypesId,
        "service_type": serviceType,
        "payment_type": paymentType,
        "date_added": dateAdded,
        "date_modified": dateModified,
        "final_status": finalStatus,
        "final_status_other": finalStatusOther,
        "payment_status": paymentStatus,
        "completed_status": completedStatus,
        "status": status,
        "cancel_reason": cancelReason,
        "driver_trip_status": driverTripStatus,
        "pickup_datetime": pickupDatetime,
        "source": source,
      };
}
