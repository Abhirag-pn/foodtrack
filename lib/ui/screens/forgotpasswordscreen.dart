import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodtrack/constants/colors.dart';
import 'package:foodtrack/utils/validators.dart';

class Forgotpasswordscreen extends StatefulWidget {
  static const routename='forgotpass';
  const Forgotpasswordscreen({super.key});

  @override
  State<Forgotpasswordscreen> createState() => _ForgotpasswordscreenState();
}

class _ForgotpasswordscreenState extends State<Forgotpasswordscreen> {
  final _formKey = GlobalKey<FormState>();
  int countdown=30;
  bool pressed=false;

  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot password"),
        backgroundColor: primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text("Enter your email",style: Theme.of(context).textTheme.titleMedium,),
            
            Form(
                key: _formKey,
                child: TextFormField(
                  validator: validateEmail,
                  controller: emailController,
                )),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              
                onPressed: !pressed?()async {
                  if (_formKey.currentState!.validate()) {
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
                      String email=emailController.text.trim();
                       FirebaseAuth.instance.sendPasswordResetEmail(
                        email: email);
                     emailController.clear();  
                      
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "Password reset email sent to $email"),
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
                    
                  }
                }:null,
                child:  Text(pressed?"Wait $countdown seconds":" Sent Reset Link"),
                )
          ],
        ),
      ),
    );
  }
}
