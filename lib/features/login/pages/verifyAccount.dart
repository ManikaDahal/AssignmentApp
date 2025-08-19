import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:project_1/core/uitils/color_uitils.dart';
import 'package:project_1/core/uitils/string_uitils.dart';
import 'package:project_1/custom_widgets/custom_elevatedButton.dart';
import 'package:project_1/route/route_const.dart';
import 'package:project_1/route/route_generator.dart';


class VerifyAccount extends StatelessWidget {
  const VerifyAccount({super.key});

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
      body: Column(
        children: [
          Center(
            child: Text(verify,style: TextStyle(fontSize:26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, ),),
          ),
            SizedBox(height: 40),
            Text(
              otptxt,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Pinput(
              length: 4,
              keyboardType: TextInputType.number,
              pinAnimationType: PinAnimationType.fade,
              onCompleted: (pin) => print("Entered OTP: $pin"),
            ),
              Center(
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(otpstr,style: TextStyle(fontSize: 20),),
                            GestureDetector(
                                onTap: () {
                                  RouteGenerator.navigateToPage(
                                      context, Routes.forget_passwordRoute);

                                  // Navigate to SignUpPage
                                },
                                child: Text(
                                  Resendstr,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,                                   
                                     decorationColor: const Color.fromARGB(255, 242, 82, 82),
                                    decoration: TextDecoration.underline,
                                    color: primaryColor,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                    // SizedBox(height: 20),
                     Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 70,
                width: MediaQuery.of(context).size.width * 0.95,
                child: CustomButton(
                    backgroundColor: primaryColor,
                    onPressed: () {
                      RouteGenerator.navigateToPage(
                          context, Routes.newPasswrdRoute);
                    },
                    child: Text(
                      verifystr,
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    )),
              ),
            ),
        ],
      ),
    );
  }
}