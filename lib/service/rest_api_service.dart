import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umrahcar_user/models/get_chat_model.dart';

import '../models/get_booking_list_model.dart';
import '../models/login_model.dart';
import '../models/send_message_model.dart';
import '../utils/const.dart';



class DioClient {
  final Dio _dio = Dio()
    ..interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) async {
        final _sharedPref = await SharedPreferences.getInstance();
        if (_sharedPref.containsKey('userId')) {
          options.headers["Authorization"] =
          "Bearer ${_sharedPref.getString('userId')}";
        }
        return handler.next(options);
      }),
    );

  Future<LoginModel> login(Map<String,dynamic> model,BuildContext context) async {
    print("mapData: ${model}");
    try {
      final response =
      await _dio.post('$baseUrl/get_users_verify', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res= LoginModel.fromJson(response.data);
        return res;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Email or Password is incorrect")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Phone Number is incorrect")));

      rethrow;
    }
  }


  Future<GetBookingListModel> getBookingupcoming(Map<String,dynamic> model,BuildContext context) async {
    try {
      final response =
      await _dio.post('$baseUrl/get_bookings_users_upcoming', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res= GetBookingListModel.fromJson(response.data);
        return res;
      }
      else  {
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No data received")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }
  Future<GetBookingListModel> getBookingOngoing(Map<String,dynamic> model,BuildContext context) async {
    try {
      final response =
      await _dio.post('$baseUrl/get_bookings_users_ongoing', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res= GetBookingListModel.fromJson(response.data);
        return res;
      }
      else  {
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No data received")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }
  Future<GetBookingListModel> getBookingCompleted(Map<String,dynamic> model,BuildContext context) async {
    try {
      final response =
      await _dio.post('$baseUrl/get_bookings_users_completed', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res= GetBookingListModel.fromJson(response.data);
        return res;
      }
      else  {
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No data received")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }
  Future<GetChatModel> getChat(Map<String,dynamic> model,BuildContext context) async {
    try {
      final response =
      await _dio.post('$baseUrl/get_messages', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res= GetChatModel.fromJson(response.data);
        return res;
      }
      else  {
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Chat Found")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Chat Found")));

      rethrow;
    }
  }


  Future<SendMessageModel> sendMessage(Map<String,dynamic> model,BuildContext context) async {
    try {
      final response =
      await _dio.post('$baseUrl/send_messages', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res= SendMessageModel.fromJson(response.data);
        return res;
      }
      else  {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Chat Found")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Chat Found")));

      rethrow;
    }
  }






}
