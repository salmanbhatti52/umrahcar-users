import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umrahcar_user/models/get_chat_model.dart';
import 'package:umrahcar_user/models/update_user_location.dart';

import '../models/distance_calculate_model.dart';
import '../models/get_all_system_data_model.dart';
import '../models/get_booking_list_model.dart';
import '../models/get_driver_profile.dart';
import '../models/login_model.dart';
import '../models/send_message_model.dart';
import '../utils/const.dart';

class DioClient {
  final Dio _dio = Dio()
    ..interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) async {
        final sharedPref = await SharedPreferences.getInstance();
        if (sharedPref.containsKey('userId')) {
          options.headers["Authorization"] =
              "Bearer ${sharedPref.getString('userId')}";
        }
        return handler.next(options);
      }),
    );

  Future<LoginModel> login(
      Map<String, dynamic> model, BuildContext context) async {
    print("mapData: $model");
    try {
      final response =
          await _dio.post('$baseUrl/get_users_verify', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = LoginModel.fromJson(response.data);
        return res;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Email or Password is incorrect")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Phone Number is incorrect")));

      rethrow;
    }
  }

  Future<GetBookingListModel?> getBookingupcoming(
      Map<String, dynamic> model, BuildContext context) async {
    try {
      // Log the request payload
      print("Request payload: $model");

      final response = await _dio.post(
        '$baseUrl/get_bookings_users_upcoming',
        data: model,
        options: Options(validateStatus: (status) {
          return status! < 500; // Accept status codes less than 500
        }),
      );

      if (response.statusCode == 200) {
        print("Response Data: ${response.data}");
        return GetBookingListModel.fromJson(response.data);
      } else if (response.statusCode == 400) {
        // Handle bad request
        print("Bad request: ${response.data}");
        _showSnackbar(context, "No upcoming Bookings");
        return null;
      } else {
        // Handle other errors
        _showSnackbar(
            context, "Unexpected response status: ${response.statusCode}");
        print("Error: Unexpected response status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      _showSnackbar(context, "An error occurred, please try again.");
      return null;
    }
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // Future<GetBookingListModel> getBookingupcoming(
  //     Map<String, dynamic> model, BuildContext context) async {
  //   try {
  //     final response =
  //         await _dio.post('$baseUrl/get_bookings_users_upcoming', data: model);
  //     if (response.statusCode == 200) {
  //       print("hiiii ${response.data}");
  //       var res = GetBookingListModel.fromJson(response.data);
  //       return res;
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text("No Booking Request Found")));
  //      throw 'SomeThing Missing';
  //     }
  //   } catch (e) {
  //          rethrow;
  //   }
  // }

  Future<GetBookingListModel> getBookingOngoing(
      Map<String, dynamic> model, BuildContext context) async {
    try {
      final response =
          await _dio.post('$baseUrl/get_bookings_users_ongoing', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = GetBookingListModel.fromJson(response.data);
        return res;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("No Ongoing Request found")));
        return GetBookingListModel();
      }
    } catch (e) {
      return GetBookingListModel();
    }
  }

Future<GetBookingListModel> getBookingCompleted(
    Map<String, dynamic> model, BuildContext context) async {
  try {
    final response = await _dio.post(
      '$baseUrl/get_bookings_users_completed',
      data: model,
    );

    // Check for a successful response
    if (response.statusCode == 200) {
      print("Response data: ${response.data}");
      return GetBookingListModel.fromJson(response.data);
    } else {
      // Show a snack bar if the response status is not successful
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No data received")),
      );
    }
  } catch (e) {
    // Log the error for debugging purposes
    print("Error fetching completed bookings: $e");
  }

  // Return an empty model if the request failed or no data was received
  return GetBookingListModel();
}


  Future<GetChatModel> getChat(
      Map<String, dynamic> model, BuildContext context) async {
    try {
      final response = await _dio.post('$baseUrl/get_messages', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = GetChatModel.fromJson(response.data);
        return res;
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Chat Found")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Chat Found")));

      rethrow;
    }
  }

  Future<SendMessageModel> sendMessage(
      Map<String, dynamic> model, BuildContext context) async {
    try {
      final response = await _dio.post('$baseUrl/send_messages', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = SendMessageModel.fromJson(response.data);
        return res;
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Chat Found")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Chat Found")));

      rethrow;
    }
  }

  Future<GetDriverProfile> getProfile(String? uid, BuildContext context) async {
    print("mapData: $uid");
    String url = "$baseUrl/get_details_drivers/$uid";
    print("url: $url");

    try {
      final response = await _dio.post(url);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = GetDriverProfile.fromJson(response.data);
        return res;
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("No Data Found")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("No Data Found")));

      rethrow;
    }
  }

  Future<UpdateUserLocation> updateUserLocation(
      Map<String, dynamic> model, BuildContext context) async {
    String url = "$baseUrl/update_guest_location";
    print("url: $url");

    try {
      final response = await _dio.post(url, data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = UpdateUserLocation.fromJson(response.data);
        return res;
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No ")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Data Found")));

      rethrow;
    }
  }

  Future<GetAllSystemData> getSystemAllData(BuildContext context) async {
    try {
      final response = await _dio.post(
        '$baseUrl/get_all_system_data',
      );
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = GetAllSystemData.fromJson(response.data);
        return res;
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("No data received")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<DistanceCalculatorModel> distanceCalculate(
      Map<String?, dynamic> model, BuildContext context) async {
    print("data: $model");
    try {
      final response =
          await _dio.post('$baseUrl/calculate_distance', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = DistanceCalculatorModel.fromJson(response.data);
        return res;
      } else {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "Unable To Delete Transaction. Only Pending transactions can be deleted")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              "Unable To Delete Transaction. Only Pending transactions can be deleted")));

      rethrow;
    }
  }
}
