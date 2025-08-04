import 'package:flutter/material.dart';
import 'package:project_1/features/addAssignment/pages/addAssignmentpage.dart';
import 'package:project_1/features/dashboard/pages/dashboardpage.dart';
import 'package:project_1/features/getAssignment/pages/getAssignmentpage.dart';
import 'package:project_1/features/login/pages/loginpage.dart';
import 'package:project_1/features/onboarding/pages/onboardingpage.dart';
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
      return MaterialPageRoute(builder: (_) =>  LoginPage());
       case Routes.signupRoute:
        return MaterialPageRoute(builder: (_) =>  UserFormPage());
        case Routes.onboardingRoute:
        return MaterialPageRoute(builder: (_) =>  Onboardingpage());
         case Routes.dashboardRoute:
        return MaterialPageRoute(builder: (_) =>  DashboardPage());
        case Routes.addAssignmentRoute:
        return MaterialPageRoute(builder: (_) =>  AddAssignmentPage());
        case Routes.getAssignmentRoute:
        return MaterialPageRoute(builder: (_) =>  GetAssignmentPage());
      
          
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
