

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

  Data({
    this.bookingsAll,
    this.bookingsPending,
    this.bookingsCompleted,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bookingsAll: json["bookings_all"],
    bookingsPending: json["bookings_pending"],
    bookingsCompleted: json["bookings_completed"],
  );

  Map<String, dynamic> toJson() => {
    "bookings_all": bookingsAll,
    "bookings_pending": bookingsPending,
    "bookings_completed": bookingsCompleted,
  };
}
