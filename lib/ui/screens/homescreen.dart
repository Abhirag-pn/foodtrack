import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtrack/bloc/homebloc/home_bloc.dart';
import 'package:foodtrack/constants/colors.dart';
import 'package:foodtrack/ui/screens/addfoodscreen.dart';
import 'package:foodtrack/ui/screens/billexpandscreen.dart';
import 'package:foodtrack/ui/screens/loginscreen.dart';
import 'package:foodtrack/ui/screens/paymenthistoryscreen.dart';
import 'package:foodtrack/ui/widgets/custombottomsheet.dart';
import 'package:intl/intl.dart';

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
  void didChangeDependencies() {
    homebloc.add(GetBillDetailsEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider.value(
      value: homebloc,
      child: BlocConsumer<HomeBloc, HomeState>(
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is !HomeActionState,
        listener: (context, state) {
          if (state is BillExpandedState) {
            Navigator.pushNamed(context, BillExpandScreen.routename,
                arguments: state.bill);
          }
          if (state is PaymentRequestSentState) {
           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Payment Request Have Been Sent!")));
           homebloc.add(GetBillDetailsEvent());
          }
          if (state is HomeErrorState) {
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errmsg)));
          }
          if (state is AddFoodState) {
            Navigator.pushNamed(context, AddFoodScreen.routename);
          }
          if (state is PayementState) {
            showModalBottomSheet(context: context, builder:  (context) {
              return CustomBottomSheet(onTapCash: () {
                homebloc.add(CashPaymentEvent(amount:state.amount ));
                Navigator.pop(context);
              },onTapGpay: () {
                homebloc.add(GpayPaymentEvent(amount: state.amount));
                 Navigator.pop(context);
              },);
            },);
          }
          if (state is HistoryState) {
           Navigator.of(context).pushNamed(PaymentHistoryScreen.routename,arguments:state.id);
          }
          if (state is LogoutState) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(context, LoginScreen.routename);
          }
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
                    onPressed: () {
                      homebloc.add(AddFoodClickedEvent());
                    },
                    label: const Text("Add new bill"),
                  ),
                  backgroundColor: Colors.transparent,
                  body: state is HomeLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : state is HomeLoadedState
                          ? Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height /
                                        3.5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                      width: 2,
                                                      color: bgcolor)),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text("Welcome"),
                                                Text(
                                                  state.username,
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
                                                onTap: () {
                                                  homebloc.add(LogoutRequestEvent());
                                                },
                                                child: const Icon(
                                                    Icons.logout,color: Colors.red,))
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
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                child: ElevatedButton(
                                              onPressed: () {
                                                if(state.bills.fold<double>(0, (sum, bill) => sum + bill.total).toDouble()>0)
                                          {    homebloc.add(PayClickedEvent(amount:state.bills.fold<double>(0, (sum, bill) => sum + bill.total).toDouble() ));}
                                          else
                                          {
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("There's nothing to pay")));
                                          }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            MediaQuery.of(
                                                                        context)
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
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: secondary),
                                              ),
                                            )),
                                           
                                            OutlinedButton(
                                                onPressed: () {
                                                  
                                                  homebloc.add(HistoryClickedEvent(id: state.id));
                                                },
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
                                          MediaQuery.of(context).size.height /
                                              15,
                                        ),
                                        topRight: Radius.circular(
                                          MediaQuery.of(context).size.height /
                                              15,
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ),
                                        ),
                                      const Divider(),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                          
                                        Expanded(
                                          child: state.bills.isNotEmpty?ListView.builder(
                                            padding: const EdgeInsets.only(
                                                top: 15, bottom: 15),
                                            itemCount: state.bills.length,
                                            itemBuilder: (context, index) {
                                              return BillTile(
                                                  onpress: () {
                                                  
                                                    homebloc.add(
                                                        BillExpandEvent(
                                                            bill: state
                                                                .bills[index]));
                                                  },
                                                  title:
                                                     DateFormat('EEEE, d MMMM').format(state.bills[index].date).toString(),
                                                  subtitle:
                                                      "₹${state.bills[index].total}",
                                                  img:
                                                      "https://static.vecteezy.com/system/resources/previews/025/268/632/non_2x/chicken-makhani-with-ai-generated-free-png.png");
                                            },
                                          ):const Center(child: Text("No bills"),),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const Center(
                              child: Text("Whoops something went wrong"),
                            )),
            ),
          );
        },
      ),
    );
  }
}

