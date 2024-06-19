import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodtrack/constants/colors.dart';
import 'package:foodtrack/ui/screens/addfood.dart';
import 'package:foodtrack/ui/screens/signinscreen.dart';

import 'ui/screens/homescreen.dart';
import 'ui/screens/loginscreen.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FoodTrack',
        theme: ThemeData(
          fontFamily: "Poppins",
          appBarTheme: AppBarTheme(
            backgroundColor: bgcolor
          ),
            colorScheme: ColorScheme.fromSeed(seedColor: primary),
            useMaterial3: true,
            outlinedButtonTheme: OutlinedButtonThemeData(
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width/2.5, MediaQuery.of(context).size.height/15),
              foregroundColor: onprimary,
              side: const BorderSide(width: 2),
            )),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.height / 40),
              ),
              minimumSize: Size(
                  double.infinity, MediaQuery.of(context).size.height / 13),
              backgroundColor: primary,
            )),
            scaffoldBackgroundColor: bgcolor,
            inputDecorationTheme: InputDecorationTheme(
                contentPadding:
                    EdgeInsets.all(MediaQuery.of(context).size.height / 50),
                fillColor: secondary,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.height / 40),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none)))),
        home: const  AddFoodScreen());
  }
}
