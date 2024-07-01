import 'package:flutter/material.dart';
import 'package:foodtrack/constants/colors.dart';
import 'package:foodtrack/ui/widgets/customtextfeild.dart';

import '../widgets/customtile.dart';

class AdminHomeScreen extends StatefulWidget {
  static const routename = 'adminhome';
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  String dvalue = "Breakfast";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  backgroundColor: bgcolor,
                  title: Text("Enter details",
                      style: Theme.of(context).textTheme.titleMedium),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextFeild(
                          hint: "Name",
                          type: FeildType.normal,
                          ctrlr: TextEditingController()),
                      SizedBox(
                        height: 5,
                      ),
                      CustomTextFeild(
                          hint: "Price",
                          type: FeildType.normal,
                          ctrlr: TextEditingController()),
                      SizedBox(
                        height: 5,
                      ),
                      CustomTextFeild(
                          hint: "Image link",
                          type: FeildType.normal,
                          ctrlr: TextEditingController()),
                      Row(
                        children: [
                          Text("Type:"),
                          Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              color: secondary,
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.height / 40),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  dropdownColor: bgcolor,
                                  elevation: 0,
                                  value: dvalue,
                                  items: const [
                                    DropdownMenuItem(
                                      value: "Breakfast",
                                      child: Text("Breakfast"),
                                    ),
                                    DropdownMenuItem(
                                      value: "Lunch",
                                      child: Text("Lunch"),
                                    ),
                                    DropdownMenuItem(
                                      value: "Snacks",
                                      child: Text("Snacks"),
                                    ),
                                    DropdownMenuItem(
                                      value: "Beverage",
                                      child: Text("Beverage"),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      dvalue = value!;
                                    });
                                  }),
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(onPressed: () {}, child: Text("Add food"))
                    ],
                  ),
                );
              });
        },
        label: Text("Add Food"),
      ),
      appBar: AppBar(
        title: const Text("Admin Panel"),
        backgroundColor: primary,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
        children: const [
          CustomTile(
              title: "Shibin Suresh",
              subtitle: "23 pending",
              img:
                  "https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg")
        ],
      ),
    );
  }
}
