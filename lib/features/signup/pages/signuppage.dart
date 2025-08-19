import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_1/core/uitils/status_utils.dart';
import 'package:project_1/custom_widgets/custom_snackbar.dart';
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
      appBar: AppBar(title: const Text("User Registration")),
      body: Consumer<SignupProvider>(
        builder: (context, signupProvider, child) => Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: signupProvider.formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextformfield(
                    labelText: "Username",
                    hintText: "Enter your username",
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Username is required";
                      }
                      return null;
                    },
                    onChanged: (value) =>
                        signupProvider.usernameController.text = value,
                  ),
                  CustomTextformfield(
                    labelText: "Email",
                    hintText: "Enter your email",
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || !value.contains('@')) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                    onChanged: (value) =>
                        signupProvider.emailController.text = value,
                  ),
                  CustomTextformfield(
                    labelText: "Password",
                    hintText: "Enter your password",
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return "Minimum 6 characters";
                      }
                      return null;
                    },
                    onChanged: (value) =>
                        signupProvider.passwordController.text = value,
                  ),
                  CustomTextformfield(
                    labelText: "Contact",
                    hintText: "Enter your phone number",
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.length < 7) {
                        return "Enter a valid contact number";
                      }
                      return null;
                    },
                    onChanged: (value) =>
                        signupProvider.contactController.text = value,
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: signupProvider.selectedGender,
                    items: signupProvider.genderOptions
                        .map((gender) => DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => signupProvider.selectedGender = value);
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
                    items: signupProvider.roleOptions
                        .map((role) => DropdownMenuItem(
                              value: role,
                              child: Text(role),
                            ))
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
                  ElevatedButton(
                    onPressed: () async{
                      if (signupProvider.formKey.currentState!.validate()) {
                         await signupProvider.submitForm();
                        if (signupProvider.SignupStatus ==
                            StatusUtils.success) {
                          CustomSnackBar.show(
                            context,
                            message: "Signup successful!",
                            type: SnackBarType.success,
                          );
                          RouteGenerator.navigateToPage(context, Routes.loginRoute);
                        } else if (signupProvider.SignupStatus ==
                            StatusUtils.error) {
                          CustomSnackBar.show(
                            context,
                            message: "Signup failed. Please try again.",
                            type: SnackBarType.error,
                          );
                        }
                      }
                    },
                    child: signupProvider.SignupStatus == StatusUtils.loading
                        ? CircularProgressIndicator()
                        : Text("Submit"),
                  ),
                  InkWell(
                    onTap: () {
                      RouteGenerator.navigateToPage(context, Routes.loginRoute);
                    },
                    child: Text("login"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
