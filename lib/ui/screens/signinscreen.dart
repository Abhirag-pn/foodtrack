import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtrack/constants/colors.dart';
import 'package:foodtrack/ui/screens/homescreen.dart';
import 'package:foodtrack/ui/screens/loginscreen.dart';
import 'package:foodtrack/ui/widgets/authfooter.dart';
import 'package:foodtrack/utils/validators.dart';

import '../../bloc/authbloc/auth_bloc.dart';
import '../widgets/authheader.dart';
import '../widgets/customtextfeild.dart';

class SignUpScreen extends StatefulWidget {
  static const routename = 'signup';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    usernameController.dispose();
    super.dispose();
  }



  Future<void> _submitForm() async {
    final formValid = _formKey.currentState!.validate();
    if (!formValid) return;

    BlocProvider.of<AuthBloc>(context).add(
      CreateAccountEvent(
        username: usernameController.text,
        email: emailController.text,
        password: passwordController.text,
        cpassword: confirmpasswordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
         listenWhen: (previous, current) => current is AuthActionState,
        buildWhen: (previous, current) => current is !AuthActionState,
        listener: (context, state) {
          if (state is UserLoginState) {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacementNamed(context, LoginScreen.routename);
          } else if (state is AuthSuccessState) {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacementNamed(context, HomeScreen.routename);
          } else if (state is AuthErrorState){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.errormessage),
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child:state.runtimeType == AuthLoadingState
                    ? Center(child: CircularProgressIndicator(backgroundColor: primary,),)
                    : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
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
                          validator: validateEmail,
                          ctrlr: emailController,
                          hint: "Email",
                          type: FeildType.normal,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFeild(
                          validator: validateUsernameNoSpaces,
                          ctrlr: usernameController,
                          hint: "Username",
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
                        CustomTextFeild(
                          validator: (value) => validateConfirmPassword(
                              passwordController.text, value),
                          ctrlr: confirmpasswordController,
                          hint: "Confirm Password",
                          type: FeildType.password,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed:  _submitForm,
                          child: const Text("Register"),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Spacer(),
                        AuthFooter(
                          text1: "Already have an account ? ",
                          text2: "Login",
                          tap: () {
                            BlocProvider.of<AuthBloc>(context).add(ToggleLogin());
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
              ),
            ),
          );
        },
      ),
    );
  }
}
