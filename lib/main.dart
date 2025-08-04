import 'package:flutter/material.dart';
import 'package:project_1/features/addAssignment/providers/addAssignmentproviders.dart';
import 'package:project_1/features/dashboard/pages/dashboardpage.dart';
import 'package:project_1/features/getAssignment/providers/getAssignmentproviders.dart';
import 'package:project_1/features/login/pages/loginpage.dart';
import 'package:project_1/features/login/providers/loginproviders.dart';
import 'package:project_1/features/signup/pages/signuppage.dart';
import 'package:project_1/features/signup/providers/signupProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignupProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => AddAssignmentProvider()),
        ChangeNotifierProvider(create: (_) => GetAssignmentProvider()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: LoginPage(),
      ),
    );
  }
}
