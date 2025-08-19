import 'package:flutter/material.dart';
import 'package:project_1/features/assignment/model/assignment.dart';
import 'package:project_1/features/assignment/pages/addAssignmentpage.dart';
import 'package:project_1/features/assignment/pages/getAssignmentpage.dart';
import 'package:project_1/features/home/pages/botton_nav_bar.dart';
import 'package:project_1/features/home/pages/homepage.dart';
import 'package:project_1/features/login/pages/forgetPassword.dart';
import 'package:project_1/features/login/pages/loginpage.dart';
import 'package:project_1/features/login/pages/verifyAccount.dart';
import 'package:project_1/features/signup/pages/signuppage.dart';
import 'package:project_1/route/route_const.dart';


class RouteGenerator {
  static navigateToPage(BuildContext context, String route,
      {dynamic arguments}) {
    Navigator.push(context,
        generateRoute(RouteSettings(name: route, arguments: arguments)));
  }

  static navigateToPageWithoutStack(BuildContext context, String route,
      {dynamic arguments}) {
    Navigator.pushAndRemoveUntil(
        context,
        generateRoute(RouteSettings(name: route, arguments: arguments)),
        (route) => false);
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case Routes.bottomNavbarRoute:
        return MaterialPageRoute(builder: (_) => BottomNavbar());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => UserFormPage());
      case Routes.homePage:
        return MaterialPageRoute(builder: (_) => HomePage());
     case Routes.addAssignmentRoute:
  final assignment = settings.arguments != null
      ? settings.arguments as Assignment
      : null;
  return MaterialPageRoute(
    builder: (_) => AssignmentPage(assignment: assignment),
  );

      case Routes.getAssignmentRoute:
        return MaterialPageRoute(builder: (_) => GetAssignmentPage());
        case Routes.forget_passwordRoute:
          return MaterialPageRoute(builder: (_) =>  ForgetPasswordScreen());
         case Routes.verifyaccRoute:
          return MaterialPageRoute(builder: (_) => VerifyAccount());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
