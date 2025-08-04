import 'package:flutter/material.dart';
import 'package:project_1/core/uitils/LoginRequest.dart';
import 'package:project_1/core/uitils/api_const.dart';
import 'package:project_1/core/uitils/dio_http.dart';
import 'package:project_1/core/uitils/status_utils.dart';
import 'package:project_1/features/login/pages/loginpage.dart';
import 'package:project_1/core/uitils/api_response.dart';
import 'package:project_1/route/route_const.dart';
import 'package:project_1/route/route_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider  extends ChangeNotifier{

   bool showPassword=false;
     bool security=false;
     
    togglePasswordVisibility(){
    //   if(showPassword==true){
    //     showPassword=false;
    //   }
    //   else{
    //     showPassword=true;
    //   }
    //   notifyListeners();


    showPassword=!showPassword;
    notifyListeners();
}
  ConfirmPassword(){
 security=!security;
    notifyListeners();
}
StatusUtils LoginStatus = StatusUtils.none;
  setLoginStatus(StatusUtils status) {
    LoginStatus = status;
    notifyListeners();
  }

 final formKey = GlobalKey<FormState>();
  late String email, password, repeat_password;
Future<void> login(BuildContext context) async {
  
   setLoginStatus( StatusUtils.loading);
 LoginRequest login= LoginRequest(
      email: email,
      password: password,
    );
    ApiResponse response = await postData(Api.LoginPage, login.toJson());
     if (response.statusUtil == StatusUtils.success) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', response.data['token']);
      
      setLoginStatus( StatusUtils.success);
      RouteGenerator.navigateToPageWithoutStack(
          context,
          Routes.dashboardRoute,);
 
        
     
    } else {
      setLoginStatus( StatusUtils.error);
     
    }
    }
  }
