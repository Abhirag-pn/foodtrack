import 'package:flutter/material.dart';
import 'package:foodtrack/constants/colors.dart';

import '../widgets/billtile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primary,
        foregroundColor: onprimary,
        onPressed: () {},
        label: const Text("Add new bill"),
      ),
      backgroundColor: primary,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  const Text("Amount to be paid"),
                  Text(
                    "₹233",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: onprimary, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                
                    children: [
                      SizedBox(
                          
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text("Pay Now"),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.height / 10),
              ),
                              minimumSize: Size(MediaQuery.of(context).size.width/2.5, MediaQuery.of(context).size.height/15),
                              backgroundColor: onprimary,
                                foregroundColor: primary),
                          )),
                          SizedBox(width: 10,),
                      OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            "History",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                          )),
                    ],
                  ),
                  const Spacer()
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              decoration: BoxDecoration(
                color: bgcolor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    MediaQuery.of(context).size.height / 15,
                  ),
                  topRight: Radius.circular(
                    MediaQuery.of(context).size.height / 15,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Bill history',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      children: const [
                        BillTile(
                            title: "Monday,15 June",
                            subtitle: "₹500",
                            img:
                                "https://static.vecteezy.com/system/resources/previews/025/268/632/non_2x/chicken-makhani-with-ai-generated-free-png.png"),
                        BillTile(
                            title: "Monday,15 June",
                            subtitle: "₹500",
                            img:
                                "https://static.vecteezy.com/system/resources/previews/025/268/632/non_2x/chicken-makhani-with-ai-generated-free-png.png")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
