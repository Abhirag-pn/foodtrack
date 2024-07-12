import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodtrack/constants/colors.dart';
import 'package:foodtrack/models/usermodel.dart';
import 'package:foodtrack/ui/screens/adminhomescreen.dart';
import 'package:foodtrack/ui/screens/homescreen.dart';
import 'package:foodtrack/ui/screens/loginscreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 1),
      ()async {
        final user=FirebaseAuth.instance.currentUser;
        if (user!= null) {
          final  userdoc= await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
          final userob=UserModel.fromMap(userdoc.data()!);
          if(userob.role=="user")
          {
            Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(context, HomeScreen.routename);
          }else{
            Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(context, AdminHomeScreen.routename);
          }
        }
        else{
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(context, LoginScreen.routename);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splashlogo.png',
              scale: 12,
            ),
            Text(
              "FoodTrack",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: onprimary),
            ),
          ],
        ),
      ),
    );
  }
}
