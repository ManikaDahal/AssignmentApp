// import 'package:flutter/material.dart';
// import 'package:setup_project/core/status_utils.dart';
// import 'package:setup_project/core/utils/api_const.dart';
// import 'package:setup_project/core/utils/api_response.dart';
// import 'package:setup_project/core/utils/dio.http.dart';
// import 'package:setup_project/features/model/login.dart';
// import 'package:setup_project/route/route_const.dart';
// import 'package:setup_project/route/route_generator.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LoginProvider extends ChangeNotifier {
//   final formKey = GlobalKey<FormState>();
//   late String email, password, repeat_password;
//   StatusUtils LoginStatus = StatusUtils.none;
//   bool showPassword = false;
//   bool security = false;
//   togglePasswordVisibility() {
//     showPassword = !showPassword;
//     notifyListeners();
//   }

//   confirmPassword() {
//     security = !security;
//     notifyListeners();
//   }

//   setLoginStatus(StatusUtils status) {
//     LoginStatus = status;
//     notifyListeners();
//   }

//   // Future<void> login(BuildContext context) async {
//   //   setLoginStatus(StatusUtils.loading);
//   //   LoginRequest login = LoginRequest(
//   //     email: email,
//   //     password: password,
//   //   );
//   //   ApiResponse response = await postData(Api.loginPage, login.toJson());
//   //   if (response.statusUtil == StatusUtils.success) {
//   //     final SharedPreferences prefs = await SharedPreferences.getInstance();
//   //     await prefs.setString('jwt_token', response.data['token']);
//   //     setLoginStatus(StatusUtils.success);
//   //    RouteGenerator.navigateToPage(context, Routes.homePage);
//   //   } else {
//   //     setLoginStatus(StatusUtils.error);
//   //   }
//   // }

//   Future<void> login(BuildContext context) async {
//   setLoginStatus(StatusUtils.loading);
  
//   LoginRequest login = LoginRequest(email: email, password: password);
//   ApiResponse response = await postData(Api.loginPage, login.toJson());

//   if (response.statusUtil == StatusUtils.success) {
//     final token = response.data['token'];

//     // Save to SharedPreferences
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('jwt_token', token);

//     // Set header in Dio
//     dio.options.headers['Authorization'] = 'Bearer $token';

//     setLoginStatus(StatusUtils.success);
//     RouteGenerator.navigateToPage(context, Routes.homePage);
//   } else {
//     setLoginStatus(StatusUtils.error);
//   }
// }

// }



import 'package:flutter/material.dart';
import 'package:project_1/core/uitils/LoginRequest.dart';
import 'package:project_1/core/uitils/api_const.dart';
import 'package:project_1/core/uitils/api_response.dart';
import 'package:project_1/core/uitils/dio_http.dart';
import 'package:project_1/core/uitils/status_utils.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class LoginProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  
  late String email, password;
  String token='';
  StatusUtils loginStatus = StatusUtils.none;
  bool showPassword = false;
  bool rememberMe = false;

  final Dio dio;
  LoginProvider({required this.dio});

  void togglePasswordVisibility() {
    showPassword = !showPassword;
    notifyListeners();
  }

  void setRememberMe(bool value) {
    rememberMe = value;
    notifyListeners();
  }

  void setLoginStatus(StatusUtils status) {
    loginStatus = status;
    notifyListeners();
  }

  Future<void> login() async {
    setLoginStatus(StatusUtils.loading);
    LoginRequest login = LoginRequest(email: email, password: password);
    ApiResponse response = await postData(Api.loginPage, login.toJson());
    if (response.statusUtil == StatusUtils.success) {
      final prefs = await SharedPreferences.getInstance();
      token = response.data['token'];
      await prefs.setString('jwt_token', token);
      if (rememberMe) {
        await prefs.setBool('remember_me', true);
        await prefs.setString('email', email);
      } else {
        await prefs.remove('remember_me');
        await prefs.remove('email');
      }
      setLoginStatus(StatusUtils.success);
    } else {
      setLoginStatus(StatusUtils.error);
    }
  }
}