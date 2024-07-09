import 'package:flutter/material.dart';
import 'package:foodtrack/constants/colors.dart';
import 'package:foodtrack/ui/widgets/billtile.dart';

class PaymentHistoryScreen extends StatelessWidget {
   static const routename='paymenthistory';
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bill History"),
        backgroundColor: primary,
        leading: IconButton(
            onPressed: () {}, icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: ListView(padding: const EdgeInsets.all(10), children:  [
        
        BillTile(
          onpress: () {
            
          },
            title: "Monday,15 June",
            subtitle: "₹500",
            img:
                "https://static.vecteezy.com/system/resources/previews/025/268/632/non_2x/chicken-makhani-with-ai-generated-free-png.png")
      ]),
    );
  }
}
