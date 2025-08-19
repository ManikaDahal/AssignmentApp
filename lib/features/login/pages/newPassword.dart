
import 'package:flutter/material.dart';
import 'package:project_1/core/uitils/color_uitils.dart';
import 'package:project_1/core/uitils/string_uitils.dart';
import 'package:project_1/custom_widgets/custom_elevatedButton.dart';
import 'package:project_1/custom_widgets/custom_textformfield.dart';
import 'package:project_1/route/route_const.dart';
import 'package:project_1/route/route_generator.dart';

class Newpassword extends StatefulWidget {
  Newpassword({super.key});

  @override
  State<Newpassword> createState() => _NewpasswordState();
}

class _NewpasswordState extends State<Newpassword> {
  bool showPassword = false;

  String? password, confirm_password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  newpasswordstr,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              CustomTextformfield(
                labelText: passwordstr,
                onChanged: (value) {
                  password = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return passwordvalidation;
                  }
                  if (value.length < 6) {
                    return passwordvalidationstr;
                  }
                  return null;
                },
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              SizedBox(height: 20),
              CustomTextformfield(
                labelText: confirm_passwordstr,
                onChanged: (value) {
                  confirm_password = value;
                },
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return passwordvalidation;
                //   }
                //   if (value.length < 6) {
                //     return passwordvalidationstr;
                //   }
                //   return null;
                // },
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  height: 70,
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: CustomButton(
                      backgroundColor: primaryColor,
                      onPressed: () {
                        RouteGenerator.navigateToPage(context, Routes.loginRoute);
                      },
                      child: Text(
                        Resetpasswordstr,
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      )),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
