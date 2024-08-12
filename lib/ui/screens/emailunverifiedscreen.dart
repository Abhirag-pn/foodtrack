import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodtrack/ui/screens/homescreen.dart';


class Emailunverifiedscreen extends StatefulWidget {
  static const routename = 'emailunverified';
  const Emailunverifiedscreen({super.key});

  @override
  State<Emailunverifiedscreen> createState() => _EmailunverifiedscreenState();
}

class _EmailunverifiedscreenState extends State<Emailunverifiedscreen> {
  late Timer timer;
   int countdown=30;
  bool pressed=false;

  @override
  void initState() {
    timer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) {
        FirebaseAuth.instance.currentUser!.reload();
        if (FirebaseAuth.instance.currentUser!.emailVerified) {
          log("verified");
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(context, HomeScreen.routename);
          timer.cancel();
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
    return Scaffold(
      
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(
              height: 10,
            ),
            const Text("Please check your mail and verify email!"),
            TextButton(
              onPressed:pressed? () async {
                
                    try{
                      pressed=true;
                     
                     Timer.periodic(const Duration(seconds: 1), (timer){
                      countdown--;
                      setState(() {
                        
                      });
                      if(countdown==0){
                        pressed=false;
                        countdown=30;
                        
                     timer.cancel();

                      }
                       
                     });
            await FirebaseAuth.instance.currentUser!
                    .sendEmailVerification();
                      
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            "Email Sent"),
                      ),
                      
                    );
                    }on Exception catch (e){
                      ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            e.toString()
                            ),
                      ),
                    );
                    }
              }:null,
              child: 
               Text(pressed?"Wait $countdown seconds":"Resend"),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
