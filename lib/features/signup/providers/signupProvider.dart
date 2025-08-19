import 'package:flutter/material.dart';
import 'package:project_1/core/uitils/api_const.dart';
import 'package:project_1/core/uitils/api_response.dart';
import 'package:project_1/core/uitils/dio_http.dart';
import 'package:project_1/core/uitils/status_utils.dart';
import 'package:project_1/features/login/model/user.dart';


class SignupProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  String selectedGender = 'Male';
  String selectedRole = 'User';

  final List<String> genderOptions = ['Male', 'Female', 'Other'];
  final List<String> roleOptions = ['User', 'Admin'];
  StatusUtils SignupStatus = StatusUtils.none;
  setSignupStatus(StatusUtils status) {
    SignupStatus = status;
    notifyListeners();
  }

  Future<void> submitForm() async {
    setSignupStatus( StatusUtils.loading);
    User user = User(
      username: usernameController.text,
      gender: selectedGender,
      email: emailController.text,
      password: passwordController.text,
      contact: contactController.text,
      role: selectedRole,
    );
    ApiResponse response = await postData(Api.userFormPage, user.toJson());
    if (response.statusUtil == StatusUtils.success) {
      setSignupStatus( StatusUtils.success);
     
    } else {
      setSignupStatus( StatusUtils.error);
     
    }
   
  }
}