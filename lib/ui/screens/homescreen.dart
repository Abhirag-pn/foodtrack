import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtrack/bloc/homebloc/home_bloc.dart';
import 'package:foodtrack/constants/colors.dart';

import '../widgets/billtile.dart';

class HomeScreen extends StatefulWidget {
  static const routename = 'home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homebloc = HomeBloc();

  @override
  void initState() {
    homebloc.add(GetBillDetailsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: homebloc,
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [primary, secondary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
            child: SafeArea(
              child: Scaffold(
                floatingActionButton: FloatingActionButton.extended(
                  backgroundColor: primary,
                  foregroundColor: onprimary,
                  onPressed: () {},
                  label: const Text("Add new bill"),
                ),
                backgroundColor: Colors.transparent,
                body: state is HomeLoadedState
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 3.5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            image: const DecorationImage(
                                                image: NetworkImage(
                                                  "https://cdn.openart.ai/stable_diffusion/93dc20ff655adb978b3fd4f8c8e010bd0b3bf8ff_2000x2000.webp",
                                                ),
                                                fit: BoxFit.cover),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                            border: Border.all(
                                                width: 2, color: bgcolor)),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text("Good Morning"),
                                          Text(
                                            "Abhirag",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w600),
                                          )
                                        ],
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                          onTap: () {},
                                          child: const Icon(
                                              Icons.person_2_outlined))
                                    ],
                                  ),
                                  Divider(
                                    color: onprimary,
                                  ),
                                  const Text("Amount to be paid"),
                                  Text(
                                    "₹${state.bills.fold<double>(0, (sum, bill) => sum + bill.total).toStringAsFixed(2)}",

                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(
                                            color: onprimary,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                          child: ElevatedButton(
                                        onPressed: () {
                                          log(state.bills.toString());
                                          
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          10),
                                            ),
                                            minimumSize: Size(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.5,
                                                MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    15),
                                            backgroundColor: onprimary,
                                            foregroundColor: secondary),
                                        child: Text(
                                          "Pay Now",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: secondary),
                                        ),
                                      )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      OutlinedButton(
                                          onPressed: () {},
                                          child: Text(
                                            "History",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w600),
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 0),
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
                                      'Bill Contents',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: ListView(
                                      padding: const EdgeInsets.only(
                                          top: 15, bottom: 15),
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
                                                "https://static.vecteezy.com/system/resources/previews/025/268/632/non_2x/chicken-makhani-with-ai-generated-free-png.png"),
                                        BillTile(
                                            title: "Monday,15 June",
                                            subtitle: "₹500",
                                            img:
                                                "https://static.vecteezy.com/system/resources/previews/025/268/632/non_2x/chicken-makhani-with-ai-generated-free-png.png"),
                                        BillTile(
                                            title: "Monday,15 June",
                                            subtitle: "₹500",
                                            img:
                                                "https://static.vecteezy.com/system/resources/previews/025/268/632/non_2x/chicken-makhani-with-ai-generated-free-png.png"),
                                        BillTile(
                                            title: "Monday,15 June",
                                            subtitle: "₹500",
                                            img:
                                                "https://static.vecteezy.com/system/resources/previews/025/268/632/non_2x/chicken-makhani-with-ai-generated-free-png.png"),
                                        BillTile(
                                            title: "Monday,15 June",
                                            subtitle: "₹500",
                                            img:
                                                "https://static.vecteezy.com/system/resources/previews/025/268/632/non_2x/chicken-makhani-with-ai-generated-free-png.png"),
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
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
