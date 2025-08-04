import 'package:flutter/material.dart';
import 'package:project_1/core/uitils/color_uitils.dart';
import 'package:project_1/core/uitils/status_utils.dart';
import 'package:project_1/core/uitils/string_uitils.dart';
import 'package:project_1/custom_widgets/custom_elevatedButton.dart';
import 'package:project_1/custom_widgets/custom_textformfield.dart';
import 'package:project_1/features/signup/providers/signupProvider.dart';
import 'package:project_1/route/route_const.dart';
import 'package:project_1/route/route_generator.dart';

import 'package:provider/provider.dart';

class UserFormPage extends StatefulWidget {
  const UserFormPage({super.key});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: primaryColor,
      title: Text(createAccountString,style: TextStyle(color: whiteColor,fontSize: 25,),),
      centerTitle: true,
      ),

      body: Consumer<SignupProvider>(
        builder:
            (context, signupProvider, child) => Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: signupProvider.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextformfield(
                        labelText: usernameString,
                        hintText: usernamePlaceStr,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return validateuserNameString;
                          }
                          return null;
                        },
                        onChanged:
                            (value) =>
                                signupProvider.usernameController.text = value,
                      ),
                      CustomTextformfield(
                        labelText: emailString,
                        hintText: emailPlaceStr,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || !value.contains('@')) {
                            return validateEmailAddressString;
                          }
                          return null;
                        },
                        onChanged:
                            (value) =>
                                signupProvider.emailController.text = value,
                      ),
                      CustomTextformfield(
                        labelText: passwordString,
                        hintText: passwordPlaceString,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return "Minimum 6 characters";
                          }
                          return null;
                        },
                        onChanged:
                            (value) =>
                                signupProvider.passwordController.text = value,
                      ),
                      CustomTextformfield(
                        labelText: "Contact",
                        hintText: "Enter your phone number",
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.length < 7) {
                            return "Enter a valid contact number";
                          }
                          return null;
                        },
                        onChanged:
                            (value) =>
                                signupProvider.contactController.text = value,
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: signupProvider.selectedGender,
                        items:
                            signupProvider.genderOptions
                                .map(
                                  (gender) => DropdownMenuItem(
                                    value: gender,
                                    child: Text(gender),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(
                              () => signupProvider.selectedGender = value,
                            );
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Gender",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: signupProvider.selectedRole,
                        items:
                            signupProvider.roleOptions
                                .map(
                                  (role) => DropdownMenuItem(
                                    value: role,
                                    child: Text(role),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => signupProvider.selectedRole = value);
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Role",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomElevatedbutton(
                        onPressed: () async {
                          if (signupProvider.formKey.currentState!.validate()) {
                            await signupProvider.submitForm();
                            if (signupProvider.SignupStatus ==
                                StatusUtils.success) {
                                  
                              const snackBar = SnackBar(
                                content: Text('Signedup successully'),
                              );

                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(snackBar);
                              RouteGenerator.navigateToPageWithoutStack(
                                context,
                                Routes.dashboardRoute,
                              );
                            } else if (signupProvider.SignupStatus ==
                                StatusUtils.error) {
                              const snackBar = SnackBar(
                                content: Text('Signedup failed'),
                              );

                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(snackBar);
                            }
                          }
                        },
                        child:
                            signupProvider.SignupStatus == StatusUtils.loading
                                ? CircularProgressIndicator()
                                : Text("Submit",style: TextStyle(fontSize: 20),),
                      ),
                      const SizedBox(height: 10),
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    const Text("Already have an account?"),
    TextButton(
      onPressed: () {
        RouteGenerator.navigateToPageWithoutStack(
          context,
          Routes.loginRoute,
        );
      },
      child: const Text(
        "Login",
        style: TextStyle(
          decoration: TextDecoration.underline,
          decorationColor:primaryColor, 
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
      ),
    );
  }
}
