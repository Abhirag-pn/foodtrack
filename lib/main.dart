import 'package:flutter/material.dart';
import 'package:foodtrack/constants/colors.dart';

import 'ui/screens/loginscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FoodTrack',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: primary),
            useMaterial3: true,
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  shape:  RoundedRectangleBorder(borderRadius:  BorderRadius.circular(MediaQuery.of(context).size.height/40),),
                  minimumSize: Size(double.infinity, MediaQuery.of(context).size.height/13),
              backgroundColor: primary,
            )),
            scaffoldBackgroundColor: bgcolor,
            inputDecorationTheme:  InputDecorationTheme(
                contentPadding: EdgeInsets.all(MediaQuery.of(context).size.height/50),
               fillColor: secondary,
               filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height/40),
                  borderSide: const BorderSide(width: 0,style: BorderStyle.none)

                  
                ))),
        home: const LoginScreen());
  }
}
