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
                onPressed: ()async {
                  if (_formKey.currentState!.validate()) {
                    try{

                     await  FirebaseAuth.instance.sendPasswordResetEmail(
                        email: emailController.text.trim());
                     emailController.clear();   
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "Password reset email sent to ${emailController.text.trim()}"),
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
                },
                child: const Text("Forgot Password"))
          ],
        ),
      ),
    );
  }
}
