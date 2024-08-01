import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtrack/bloc/adminprofilebloc/adminprofileexpand_bloc.dart';
import 'package:foodtrack/constants/colors.dart';
import 'package:foodtrack/ui/screens/billexpandscreen.dart';
import 'package:intl/intl.dart';

import '../../models/paymentmodel.dart';
import '../widgets/alertrow.dart';
import '../widgets/billtile.dart';

class AdminProfileExpandedScreen extends StatefulWidget {
  static const routename = 'adminprofileexpand';
  const AdminProfileExpandedScreen({super.key});

  @override
  State<AdminProfileExpandedScreen> createState() =>
      _AdminProfileExpandedScreenState();
}

class _AdminProfileExpandedScreenState
    extends State<AdminProfileExpandedScreen> {
  final profileexpandedbloc = AdminprofileexpandBloc();
  String? userid;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (userid == null) {
      userid = ModalRoute.of(context)!.settings.arguments as String?;
      if (userid != null) {
        profileexpandedbloc.add(AdminGetBillsEvent(userid: userid!));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: profileexpandedbloc,
      child: BlocConsumer<AdminprofileexpandBloc, AdminprofileexpandState>(
        listenWhen: (previous, current) =>
            current is AdminprofileexpandActionState,
        buildWhen: (previous, current) =>
            current is! AdminprofileexpandActionState,
        listener: (context, state) {
          if (state is AdminBillExpandedState) {
            Navigator.pushNamed(context, BillExpandScreen.routename,
                arguments: state.bill);
          }
          if (state is MarkAsPaidClickedState) {
        
          }
          if (state is MarkAsPaidUpdatedState
          ) {
            
          }
        

          if (state is AdminBillErrorState) {
            log(state.errmsg);
          }
        },
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primary, secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: state is AdminBillLoadingState
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : state is AdminBillLoadedState
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
                                  height:
                                      MediaQuery.of(context).size.height / 3.5,
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
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              border: Border.all(
                                                  width: 2, color: bgcolor),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            state.username,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                          const Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Icon(Icons.close),
                                          ),
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
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                profileexpandedbloc.add(MarkAsPaidClickedEvent());
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
                                                      15,
                                                ),
                                                backgroundColor: onprimary,
                                                foregroundColor: secondary,
                                              ),
                                              child: Text(
                                                "Mark as paid",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: secondary,
                                                    ),
                                              ),
                                            ),
                                          ),
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
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
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
                                              15),
                                      topRight: Radius.circular(
                                          MediaQuery.of(context).size.height /
                                              15),
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
                                                  fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                          padding: const EdgeInsets.only(
                                              top: 15, bottom: 15),
                                          itemCount: state.bills.length,
                                          itemBuilder: (context, index) {
                                            return BillTile(
                                                onpress: () {
                                                  profileexpandedbloc.add(
                                                      AdminBillExpandEvent(
                                                          bill: state
                                                              .bills[index]));
                                                },
                                                title: DateFormat(
                                                        'EEEE, d MMMM')
                                                    .format(
                                                        state.bills[index].date)
                                                    .toString(),
                                                subtitle:
                                                    "₹${state.bills[index].total}",
                                                img:
                                                    "https://static.vecteezy.com/system/resources/previews/025/268/632/non_2x/chicken-makhani-with-ai-generated-free-png.png");
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const Center(
                            child: Text("Whoops something went wrong"),
                          ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> requestsDialog(BuildContext context,List<Payment> requests) {
    return showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return  AlertDialog(

                                                    title: const Column(
                                                      children: [
                                                        Text(
                                                            "Payment Requests"),
                                                          
                                                      ],
                                                    ),
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children:requests.isEmpty? [
                                                        const Text("No Payment Requests")
                                                      ]:List.generate(requests.length, (index) {
                                                        return AlertRow(
                                                          amount: requests[index].totalamount.toString(),
                                                          date: requests[index].paymentdate!,
                                                          type: requests[index].paymentMethod!,

                                                        );
                                                      },),
                                                    ),
                                                  );
                                                },
                                              );
  }
}

