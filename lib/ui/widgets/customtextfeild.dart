import 'package:flutter/material.dart';

enum FeildType { normal, password,search }

class CustomTextFeild extends StatefulWidget {
  final TextEditingController ctrlr;
  final String hint;
  final FeildType type;
  const CustomTextFeild({super.key, required this.hint, required this.type, required this.ctrlr});

  @override 
  State<CustomTextFeild> createState() => _CustomTextFeildState();
}

class _CustomTextFeildState extends State<CustomTextFeild> {
  bool obs = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: TextEditingController(),
      obscureText: widget.type==FeildType.password?obs:false,
      
        decoration: InputDecoration(
          prefixIcon: widget.type==FeildType.search?const Icon(Icons.search):null,
         suffixIcon: widget.type==FeildType.password?IconButton(icon: Icon(obs?Icons.visibility:Icons.visibility_off),onPressed: (){
          setState(() {
            obs=!obs;
          });
         },):null,
      hintText: widget.hint
    ));
  }
}
