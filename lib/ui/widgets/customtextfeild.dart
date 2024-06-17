import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum FeildType { normal, password }

class CustomTextFeild extends StatefulWidget {
  final String hint;
  final FeildType type;
  const CustomTextFeild({super.key, required this.hint, required this.type});

  @override
  State<CustomTextFeild> createState() => _CustomTextFeildState();
}

class _CustomTextFeildState extends State<CustomTextFeild> {
  bool obs = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obs,
      
        decoration: InputDecoration(
         suffixIcon: widget.type==FeildType.password?IconButton(icon: Icon(obs?Icons.visibility:Icons.visibility_off),onPressed: (){
          setState(() {
            obs=!obs;
          });
         },):null,
      hintText: widget.hint
    ));
  }
}
