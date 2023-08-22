

class UpdateUserLocation {
  String? status;
  String? message;

  UpdateUserLocation({
    this.status,
    this.message,
  });

  factory UpdateUserLocation.fromJson(Map<String, dynamic> json) => UpdateUserLocation(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
