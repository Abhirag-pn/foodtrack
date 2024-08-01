// ignore_for_file: unused_import

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtrack/bloc/authbloc/auth_bloc.dart';
import 'package:foodtrack/constants/colors.dart';
import 'package:foodtrack/ui/screens/addfoodscreen.dart';
import 'package:foodtrack/ui/screens/adminloginscreen.dart';
import 'package:foodtrack/ui/screens/adminprofileexpandedscreen.dart';
import 'package:foodtrack/ui/screens/adminhomescreen.dart';
import 'package:foodtrack/ui/screens/billexpandscreen.dart';
import 'package:foodtrack/ui/screens/homescreen.dart';
import 'package:foodtrack/ui/screens/loginscreen.dart';
import 'package:foodtrack/ui/screens/paymenthistoryscreen.dart';
import 'package:foodtrack/ui/screens/profilescreen.dart';
import 'package:foodtrack/ui/screens/signinscreen.dart';
import 'package:foodtrack/ui/screens/splashscreen.dart';

import 'firebase_options.dart';
import 'ui/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FoodTrack',
        theme: appTheme(context),
        home: const Splashscreen(),
        routes: {
          SignUpScreen.routename: (context) => const SignUpScreen(),
          LoginScreen.routename: (context) => const LoginScreen(),
          Profilescreen.routename: (context) => const Profilescreen(),
          PaymentHistoryScreen.routename: (context) =>
              const PaymentHistoryScreen(),
          HomeScreen.routename: (context) => const HomeScreen(),
          BillExpandScreen.routename: (context) => const BillExpandScreen(),
          AdminHomeScreen.routename: (context) => const AdminHomeScreen(),
          AdminProfileExpandedScreen.routename: (context) =>
              const AdminProfileExpandedScreen(),
          Adminloginscreen.routename: (context) => const Adminloginscreen(),
          AddFoodScreen.routename: (context) => const AddFoodScreen(),
        },
      ),
    );
  }

  
}
