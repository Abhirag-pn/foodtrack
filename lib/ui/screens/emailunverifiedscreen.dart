import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodtrack/ui/screens/homescreen.dart';

class Emailunverifiedscreen extends StatefulWidget {
  static const routename='emailunverified';
  const Emailunverifiedscreen({super.key});

  @override
  State<Emailunverifiedscreen> createState() => _EmailunverifiedscreenState();
}

class _EmailunverifiedscreenState extends State<Emailunverifiedscreen> {
  late Timer timer;

  @override
  void initState() {
    final user = FirebaseAuth.instance.currentUser!;
    timer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) {
        log(FirebaseAuth.instance.currentUser!.emailVerified.toString());
        if (user.emailVerified) {
          log("verified");
          Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacementNamed(
                context, HomeScreen.routename);
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    log("Cancelled");
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 10,
            ),
            Text("Please check your mail and verify email!")
          ],
        ),
      ),
    );
  }
}
