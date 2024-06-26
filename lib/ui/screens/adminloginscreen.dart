import 'package:flutter/material.dart';
import 'package:foodtrack/ui/widgets/authfooter.dart';
import 'package:foodtrack/ui/widgets/authheader.dart';
import 'package:foodtrack/ui/widgets/customtextfeild.dart';

import '../../constants/colors.dart';

class Adminloginscreen extends StatelessWidget {
  const Adminloginscreen({super.key});

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
              subtitle: "Enter admin credentials to continue",
              title: "Admin Login",
              img: "assets/images/adminauth.svg",
            ),
            const SizedBox(
              height: 30,
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
         
          TextButton(
            style: TextButton.styleFrom(backgroundColor: secondary),
            onPressed: (){}, child: Text("User Login",))
          ],
        ),
      ),
    );
  }
}