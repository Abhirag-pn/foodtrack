import 'package:flutter/material.dart';
import 'package:foodtrack/ui/widgets/billtile.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bill History"),),
      body: 
      Column(
        children: [
           BillTile(
                                title: "Monday,15 June",
                                subtitle: "₹500",
                                img:
                                    "https://static.vecteezy.com/system/resources/previews/025/268/632/non_2x/chicken-makhani-with-ai-generated-free-png.png")
        ]
      ),
    );
  }
}