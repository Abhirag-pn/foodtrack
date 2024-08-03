
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtrack/bloc/historybloc/history_bloc.dart';
import 'package:foodtrack/constants/colors.dart';
import 'package:intl/intl.dart';

import '../widgets/historytile.dart';

class PaymentHistoryScreen extends StatefulWidget {
  static const routename = 'paymenthistory';
  const PaymentHistoryScreen({super.key});

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  final historybloc = HistoryBloc();
  String? userid;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (userid == null) {
      userid = ModalRoute.of(context)!.settings.arguments as String?;
      if (userid != null) {
        historybloc.add(GetHistoryEvent(userId: userid!));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: historybloc,
      child: BlocConsumer<HistoryBloc, HistoryState>(
        listener: (context, state) {
          if (state is HistoryErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errmsg)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Bill History"),
              backgroundColor: primary,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.arrow_back_ios)),
            ),
            body: state is HistoryLoadedState
                ? ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: state.payments.length,
                    itemBuilder: (context, index) {
                      return HistoryTile(
                        isRejected: state.payments[index].isRejected,
                        isCompleted: state.payments[index].isCompleted,
                        title: DateFormat('EEEE dd MMMM')
                            .format(state.payments[index].paymentdate!),
                        subtitle: "₹${state.payments[index].totalamount}",
                      );
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(
                    backgroundColor: primary,
                  )),
          );
        },
      ),
    );
  }
}
