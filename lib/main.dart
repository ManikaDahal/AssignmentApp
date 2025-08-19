import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_1/features/assignment/pages/addAssignmentpage.dart';
import 'package:project_1/features/assignment/providers/addAssignmentproviders.dart';
import 'package:project_1/features/home/providers/dio_provider.dart';
import 'package:project_1/features/home/providers/home_provider.dart';
import 'package:project_1/features/login/pages/loginpage.dart';
import 'package:project_1/features/login/providers/loginproviders.dart';
import 'package:project_1/features/signup/providers/signupProvider.dart';
import 'package:project_1/firebase_options.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    super.initState();
    Future.microtask(() {
      readValueFromSharedPreference();
    });
  }

  String? token;
  readValueFromSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString("jwt_token");
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DioProvider()),
        ChangeNotifierProxyProvider<DioProvider, LoginProvider>(
          create: (_) => LoginProvider(dio: Dio()),
          update: (_, dioProvider, __) => LoginProvider(dio: dioProvider.dio),
        ),
        ChangeNotifierProvider(create: (_) => SignupProvider()),
        // ChangeNotifierProvider(create: (_)=>LoginProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => AddAssignmentProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:
            token != null && token!.isNotEmpty ? AssignmentPage() : LoginPage(),
      ),
    );
  }
}
