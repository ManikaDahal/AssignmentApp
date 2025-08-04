import 'package:flutter/material.dart';
import 'package:project_1/core/uitils/api_const.dart';
import 'package:project_1/core/uitils/api_response.dart';
import 'package:project_1/core/uitils/dio_http.dart';
import 'package:project_1/core/uitils/status_utils.dart';
import 'package:project_1/core/uitils/user.dart';

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
    User user = User(
      username: usernameController.text,
      email: emailController.text,
      password: passwordController.text,
      contact: contactController.text,
      gender: selectedGender,
      role: selectedRole,
    );
    ApiResponse response = await postData(Api.UserFormPage, user.toJson());
    if (response.statusUtil == StatusUtils.success) {
      setSignupStatus( StatusUtils.success);
      // Handle success, e.g., show a success message or navigate to another page
    } else {
      setSignupStatus( StatusUtils.error);
      // Handle error, e.g., show an error message
    }
    // Handle response here
  }
}