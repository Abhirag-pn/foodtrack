import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodtrack/constants/colors.dart';
import 'package:foodtrack/ui/widgets/authfooter.dart';

import '../widgets/authheader.dart';
import '../widgets/customtextfeild.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          const Spacer(),
              const AuthHeader(
              subtitle: "Create an account to get started",
              title: "Register",
              img: "assets/images/authbg2.svg",
            ),
             const SizedBox(
              height: 10,
            ),
            
             const CustomTextFeild(hint: "Email",type: FeildType.normal,)
             ,
            const SizedBox(
              height: 20,
            ),
             const CustomTextFeild(hint: "Password",type: FeildType.password,),
             const SizedBox(
              height: 20,
            ),
              const CustomTextFeild(hint: "Confirm Password",type: FeildType.password,),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: (){}, child: const Text("Login")) ,const SizedBox(
              height: 20,
            ),
            const Spacer(),
           AuthFooter(text1: "Already have an account ? ", text2: "Login"),
            const SizedBox(
              height: 10,
            )

          ],
        ),
      ),
    );
  }
}