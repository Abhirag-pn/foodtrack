import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtrack/ui/widgets/authfooter.dart';

import '../../bloc/authbloc/auth_bloc.dart';
import '../widgets/authheader.dart';
import '../widgets/customtextfeild.dart';

class SignUpScreen extends StatefulWidget {
  static const routename='signup';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey _formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          
        },
        builder: (context, state) {
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
                      subtitle: "Create an account to get started",
                      title: "Register",
                      img: "assets/images/authbg2.svg",
                    ),
                    const SizedBox(
                      height: 10,
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
                      ctrlr: usernameController,
                      hint: "Username",
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
                    CustomTextFeild(
                      ctrlr: confirmpasswordController,
                      hint: "Confirm Password",
                      type: FeildType.password,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Login")),
                    const SizedBox(
                      height: 20,
                    ),
                    const Spacer(),
                    const AuthFooter(
                        text1: "Already have an account ? ", text2: "Login"),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
