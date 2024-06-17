import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodtrack/constants/colors.dart';
import 'package:foodtrack/ui/widgets/customtextfeild.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          const Spacer(),
            SvgPicture.asset('assets/images/authbg.svg',height: MediaQuery.of(context).size.height/4,),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Login",style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),),
                   Text("Login with your account to continue",style: Theme.of(context).textTheme.titleMedium),
                ],
              )),
             const SizedBox(
              height: 10,
            ),
            
             CustomTextFeild(hint: "Email",type: FeildType.normal,)
             ,
            const SizedBox(
              height: 20,
            ),
             CustomTextFeild(hint: "Password",type: FeildType.password,),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: (){}, child: const Text("Login")) ,const SizedBox(
              height: 20,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text("Dont have an account?",style: Theme.of(context).textTheme.titleSmall,),
                TextButton(onPressed: (){}, child: Text("SignUp",style: Theme.of(context).textTheme.titleSmall!.copyWith(color: primary),))
              ],
            ),
            const SizedBox(
              height: 10,
            )

          ],
        ),
      ),
    );
}}