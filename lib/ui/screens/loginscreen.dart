import 'package:flutter/material.dart';
import 'package:foodtrack/ui/widgets/authfooter.dart';
import 'package:foodtrack/ui/widgets/authheader.dart';
import 'package:foodtrack/ui/widgets/customtextfeild.dart';

import '../../constants/colors.dart';

class LoginScreen extends StatefulWidget {
   static const routename='login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey _formKey= GlobalKey();
   
   final TextEditingController emailController=TextEditingController();
   final TextEditingController passwordController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
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
                height: 20,
              ),
               CustomTextFeild(
                ctrlr: emailController,
                hint: "Email",
                type: FeildType.normal,
              ),
              const SizedBox(
                height: 20,
              ),
               CustomTextFeild(
                ctrlr: passwordController,
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
              ),
               TextButton(
              style: TextButton.styleFrom(backgroundColor: secondary),
              onPressed: (){}, child: Text("Admin Login",))
            ],
          ),
        ),
      ),
    );
  }
}
