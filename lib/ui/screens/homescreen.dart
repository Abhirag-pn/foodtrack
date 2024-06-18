import 'package:flutter/material.dart';
import 'package:foodtrack/constants/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(onPressed: (){},label: const Text("Add new bill"),),
      backgroundColor: primary,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              children: [
               const Spacer(),
                const Text("Amount to be paid"),
                Text(
                  "₹233",
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(color: onprimary, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8,),
                OutlinedButton(onPressed: () {}, child: const Text("Pay Now")),
                const Spacer()
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: bgcolor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                          MediaQuery.of(context).size.height / 10),
                      topRight: Radius.circular(
                          MediaQuery.of(context).size.height / 10))),
            ),
          )
        ],
      ),
    );
  }
}
