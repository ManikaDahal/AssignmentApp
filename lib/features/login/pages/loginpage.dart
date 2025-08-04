import 'package:flutter/material.dart';
import 'package:project_1/core/uitils/color_uitils.dart';
import 'package:project_1/core/uitils/status_utils.dart';
import 'package:project_1/core/uitils/string_uitils.dart';
import 'package:project_1/custom_widgets/custom_elevatedButton.dart';
import 'package:project_1/custom_widgets/custom_textformfield.dart';
import 'package:project_1/features/login/providers/loginproviders.dart';
import 'package:project_1/route/route_const.dart';
import 'package:project_1/route/route_generator.dart';

import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          welcomeBackStr,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: whiteColor
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<LoginProvider >(
        builder: (context, loginProvider,
         child) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: loginProvider.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextformfield(
                  labelText: emailString,
                  onChanged: (value) {
                    loginProvider.email = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return validateEmailAddressString;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextformfield(
                  labelText: passwordString,
                  obscureText: !loginProvider.showPassword,
                  onChanged: (value) {
                    loginProvider.password = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return validatePasswordStr;
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
                const SizedBox(height: 24),
                CustomElevatedbutton(
                  
                  onPressed: loginProvider.LoginStatus == StatusUtils.loading
                      ? null
                      : () async {
                          if (loginProvider.formKey.currentState!.validate()) {
                            await loginProvider.login(context);
                            final messenger = ScaffoldMessenger.of(context);
                            if (loginProvider.LoginStatus ==
                                StatusUtils.success) {
                              messenger.showSnackBar(const SnackBar(
                                content: Text("Logged in successfully"),
                              ));
                              RouteGenerator.navigateToPageWithoutStack(
                                context,
                                Routes.dashboardRoute,
                              );
                            } else if (loginProvider.LoginStatus ==
                                StatusUtils.error) {
                              messenger.showSnackBar(const SnackBar(
                                content: Text("Login failed"),
                              ));
                            }
                          }
                        },
                  child: loginProvider.LoginStatus == StatusUtils.loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text("Submit",style: TextStyle(fontSize: 20),),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        RouteGenerator.navigateToPageWithoutStack(
                          context,
                          Routes.signupRoute,
                        );
                      },
                      child: const Text(
                        "Sign Up",
                        
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: primaryColor,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
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
    );
  }
}
