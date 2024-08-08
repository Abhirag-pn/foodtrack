import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtrack/bloc/authbloc/auth_bloc.dart';
import 'package:foodtrack/ui/screens/adminhomescreen.dart';
import 'package:foodtrack/ui/screens/loginscreen.dart';
import 'package:foodtrack/ui/widgets/authheader.dart';
import 'package:foodtrack/ui/widgets/customtextfeild.dart';

import '../../constants/colors.dart';

class Adminloginscreen extends StatefulWidget {
  static const routename = 'adminlogin';
  const Adminloginscreen({super.key});

  @override
  State<Adminloginscreen> createState() => _AdminloginscreenState();
}

class _AdminloginscreenState extends State<Adminloginscreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController adminEmailController = TextEditingController();
  final TextEditingController adminPasswordController = TextEditingController();
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        LoginRequestEvent(
          email: adminEmailController.text,
          password: adminPasswordController.text,
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        
        listener: (context, state) {
          
          if (state is UserLoginState) {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacementNamed(context, LoginScreen.routename);
          } else if (state is AdminAuthSuccessState) {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacementNamed(context, AdminHomeScreen.routename);
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
          return 
             Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child:  state.runtimeType == AuthLoadingState? CircularProgressIndicator(
                  color: primary

                  
                ):Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:
                        [
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
                          ElevatedButton(
                              onPressed: _submitForm, child: const Text("Login")),
                          const SizedBox(
                            height: 20,
                          ),
                          const Spacer(),
                          TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: secondary),
                              onPressed: () {BlocProvider.of<AuthBloc>(context).add(ToggleUserLogin());},
                              child: const Text(
                                "User Login",
                              ))
                        ]
                     
                ),
              ),
            
          );
        },
      ),
    );
  }
}
