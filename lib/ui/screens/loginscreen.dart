import 'package:flutter/material.dart';
import 'package:foodtrack/ui/widgets/authfooter.dart';
import 'package:foodtrack/ui/widgets/authheader.dart';
import 'package:foodtrack/ui/widgets/customtextfeild.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            const AuthHeader(
              subtitle: "Login with your account to continue",
              title: "Login",
              img: "assets/images/authbg.svg",
            ),
            const SizedBox(
              height: 10,
            ),
            const CustomTextFeild(
              hint: "Email",
              type: FeildType.normal,
            ),
            const SizedBox(
              height: 20,
            ),
            const CustomTextFeild(
              hint: "Password",
              type: FeildType.password,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: () {}, child: const Text("Login")),
            const SizedBox(
              height: 20,
            ),
            const Spacer(),
          const   AuthFooter(text1:  "Dont have an account? ",text2: "Register",),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
