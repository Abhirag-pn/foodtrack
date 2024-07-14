import 'package:flutter/material.dart';
import 'package:foodtrack/constants/colors.dart';

ThemeData appTheme(BuildContext context) {
    return ThemeData(
          fontFamily: "Poppins",
          appBarTheme: AppBarTheme(backgroundColor: bgcolor),
          colorScheme: ColorScheme.fromSeed(seedColor: primary),
          useMaterial3: true,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              foregroundColor: onprimary, backgroundColor: primary),
          outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
            minimumSize: Size(MediaQuery.of(context).size.width / 2.5,
                MediaQuery.of(context).size.height / 15),
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
                      const BorderSide(width: 0, style: BorderStyle.none))));
  }