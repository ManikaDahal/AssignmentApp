import 'package:flutter/material.dart';
import 'package:project_1/core/uitils/authentication.dart';
import 'package:project_1/core/uitils/status_utils.dart';
import 'package:project_1/core/uitils/string_uitils.dart';
import 'package:project_1/custom_widgets/custom_elevatedButton.dart';
import 'package:project_1/custom_widgets/custom_snackbar.dart';
import 'package:project_1/custom_widgets/custom_textformfield.dart';
import 'package:project_1/features/login/providers/loginproviders.dart';
import 'package:project_1/route/route_const.dart';
import 'package:project_1/route/route_generator.dart';

import 'package:provider/provider.dart';


class LoginPage extends StatelessWidget {
  String? googleSignInAccount;
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: Text(
            welcomeString,
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Consumer<LoginProvider>(
          builder: (context, loginProvider, child) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: loginProvider.formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextformfield(
                      labelText: emailString,
                      onChanged: (value) {
                        loginProvider.email = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return emailErrorString;
                        }
                      },
                    ),
                    CustomTextformfield(
                      labelText: passwordString,
                      // prefixIcon: Icon(Icons.lock),
                      obscureText: !loginProvider.showPassword,
                      onChanged: (value) {
                        loginProvider.password = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return passwordErrorStr;
                        }
                        if (value.length < 6) {
                          return passwordErrorString;
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        onPressed: () {
                          loginProvider.togglePasswordVisibility();
                        },
                        icon: Icon(
                          loginProvider.showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: loginProvider.rememberMe,
                              onChanged: (value) {
                                loginProvider.setRememberMe(value ?? false);
                              },
                            ),
                            const Text("Remember me"),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            RouteGenerator.navigateToPage(
                                context, Routes.forget_passwordRoute);
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Colors.lightBlue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      ),
                      onPressed: () async {
                        if (loginProvider.formKey.currentState!.validate()) {
                          await loginProvider.login();
                          if (loginProvider.loginStatus == StatusUtils.success) {
                            CustomSnackBar.show(
                              context,
                              message: "Login successful!",
                              type: SnackBarType.success,
                            );
                            RouteGenerator.navigateToPage(
                                context, Routes.homePage);
                          } else if (loginProvider.loginStatus ==
                              StatusUtils.error) {
                            CustomSnackBar.show(
                              context,
                              message: "Login failed. Please try again.",
                              type: SnackBarType.error,
                            );
                          }
                        }
                      },
                      child: loginProvider.loginStatus == StatusUtils.loading
                          ? CircularProgressIndicator()
                          : Text("Submit"),
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      onPressed: () async {
                        final user = await Authentication.signInWithGoogle(
                            context: context);
                        print("Returned user: $user");
                        if (user != null) {
                          print("Navigating to home page");
                          CustomSnackBar.show(
                            context,
                            message: "Google sign-in successful!",
                            type: SnackBarType.success,
                          );
                          RouteGenerator.navigateToPage(context, Routes.homePage);
                        } else {
                          CustomSnackBar.show(
                            context,
                            message: "Google sign-in failed. Please try again.",
                            type: SnackBarType.error,
                          );
                        }
                        print("GoogleSignInAccount: $googleSignInAccount");
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/images/google_logo.png',
                            height: 30,
                            width: 34,
                          ),
                          const SizedBox(width: 10),
                          const Text("Continue With Google"),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        GestureDetector(
                          onTap: () {
                            RouteGenerator.navigateToPage(
                                context, Routes.registerRoute);
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.lightBlue,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                   
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
