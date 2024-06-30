import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtrack/bloc/authbloc/auth_bloc.dart';
import 'package:foodtrack/ui/screens/adminloginscreen.dart';
import 'package:foodtrack/ui/screens/homescreen.dart';
import 'package:foodtrack/ui/screens/signinscreen.dart';
import 'package:foodtrack/ui/widgets/authfooter.dart';
import 'package:foodtrack/ui/widgets/authheader.dart';
import 'package:foodtrack/ui/widgets/customtextfeild.dart';
import 'package:foodtrack/utils/validators.dart';

import '../../constants/colors.dart';

class LoginScreen extends StatefulWidget {
  static const routename = 'login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        LoginRequestEvent(
          email: emailController.text,
          password: passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UserSignUpState) {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacementNamed(context, SignUpScreen.routename);
          } else if (state is AdminLoginState) {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacementNamed(context, Adminloginscreen.routename);
          } else if (state is AuthSuccessState) {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacementNamed(context, HomeScreen.routename);
          } else if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.errormessage),
              ),
            );
          }
        },
        builder: (context, state) {
          return  Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: state.runtimeType == AuthLoadingState
                      ? [
                          Center(
                            child: CircularProgressIndicator(
                              backgroundColor: primary,
                            ),
                          )
                        ]
                      : [
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
                            validator: validateEmail,
                            ctrlr: emailController,
                            hint: "Email",
                            type: FeildType.normal,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFeild(
                            validator: validatePassword,
                            ctrlr: passwordController,
                            hint: "Password",
                            type: FeildType.password,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              onPressed: _submitForm,
                              child: const Text("Login")),
                          const SizedBox(
                            height: 20,
                          ),
                          const Spacer(),
                           AuthFooter(
                            text1: "Dont have an account? ",
                            text2: "Register",
                            tap: (){BlocProvider.of<AuthBloc>(context)
                                    .add(ToggleSignUp());},
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: secondary),
                              onPressed: () {
                                BlocProvider.of<AuthBloc>(context)
                                    .add(ToggleAdminLogin());
                              },
                              child: const Text(
                                "Admin Login",
                              ))
                        ],
                ),
              ),
            
          );
        },
      ),
    );
  }
}
