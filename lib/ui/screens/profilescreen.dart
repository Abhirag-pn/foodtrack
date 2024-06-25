import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodtrack/constants/colors.dart';

import '../widgets/profilebutton.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondary,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 5,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [secondary, primary],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight)),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              Text("Abhirag PN",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.w700)),
              const Expanded(
                  child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    ProfileButton(text: "Close",icon: Icons.close,),
                    SizedBox(height: 10,),
                      ProfileButton(text: "Logout",icon: Icons.logout,),
                       SizedBox(height: 10,),
                      ProfileButton(text: "Logout",icon: Icons.logout,),
                  ],
                ),
              ))
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 11,
            child: CircleAvatar(
              backgroundImage: const NetworkImage(
                  "https://cdn.openart.ai/stable_diffusion/93dc20ff655adb978b3fd4f8c8e010bd0b3bf8ff_2000x2000.webp"),
              radius: MediaQuery.of(context).size.height / 10,
            ),
          )
        ],
      ),
    );
  }
}

