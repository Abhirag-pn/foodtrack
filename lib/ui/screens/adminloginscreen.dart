import 'package:flutter/material.dart';
import 'package:foodtrack/ui/widgets/authfooter.dart';
import 'package:foodtrack/ui/widgets/authheader.dart';
import 'package:foodtrack/ui/widgets/customtextfeild.dart';

import '../../constants/colors.dart';

class Adminloginscreen extends StatefulWidget {
  const Adminloginscreen({super.key});

  @override
  State<Adminloginscreen> createState() => _AdminloginscreenState();
}

class _AdminloginscreenState extends State<Adminloginscreen> {
  final GlobalKey _formKey=GlobalKey();
  final TextEditingController adminEmailController=TextEditingController();
  final TextEditingController adminPasswordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
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
               CustomTextFeild(
                ctrlr: adminEmailController,
                hint: "Email",
                type: FeildType.normal,
              ),
              const SizedBox(
                height: 20,
              ),
               CustomTextFeild(
                ctrlr: adminPasswordController,
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
      ),
    );
  }
}