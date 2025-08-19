
import 'package:flutter/material.dart';
import 'package:project_1/core/uitils/color_uitils.dart';
import 'package:project_1/core/uitils/string_uitils.dart';
import 'package:project_1/custom_widgets/custom_elevatedButton.dart';
import 'package:project_1/custom_widgets/custom_textformfield.dart';
import 'package:project_1/route/route_const.dart';
import 'package:project_1/route/route_generator.dart';


class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(
              forget_password,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              emailvalidation,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            SizedBox(height: 20),
            CustomTextformfield(
              hintText: emailstr,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 70,
                width: MediaQuery.of(context).size.width * 0.95,
                child: CustomButton(
                    backgroundColor: primaryColor,
                    onPressed: () {
                      RouteGenerator.navigateToPage(
                          context, Routes.verifyaccRoute);
                    },
                    child: Text(
                      linkstr,
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    )),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
