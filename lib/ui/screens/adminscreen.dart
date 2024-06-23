import 'package:flutter/material.dart';
import 'package:foodtrack/constants/colors.dart';
import 'package:foodtrack/ui/widgets/billtile.dart';
import 'package:foodtrack/ui/widgets/foodtile.dart';

import '../widgets/customtile.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("Admin Panel"),backgroundColor: primary,),
      body: ListView(
        children: [
          CustomTile(title: "Shibin Suresh", subtitle: "23 pending", img: "https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg")
        ],),
    );
  }
}