import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioProvider extends ChangeNotifier {
  late Dio dio;

  DioProvider() {
    dio = Dio();
    _loadToken();
  }

  void _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  void updateToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
    dio.options.headers['Authorization'] = 'Bearer $token';
    notifyListeners();
  }

  Future<Response> post(String url, dynamic data) async {
    return await dio.post(url, data: data);
  }

  Future<Response> get(String url) async {
    return await dio.get(url);
  }
}
