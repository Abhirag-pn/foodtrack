import 'package:flutter/material.dart';
import 'package:foodtrack/constants/colors.dart';
import 'package:foodtrack/models/billmodel.dart';
import 'package:foodtrack/models/foodmodel.dart';
import 'package:foodtrack/ui/widgets/customfoodtile.dart';

class BillExpandScreen extends StatelessWidget {
  static const routename = 'billexpand';
  const BillExpandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bill = ModalRoute.of(context)!.settings.arguments as Bill;

    // Method to count food items

    return Scaffold(
      appBar: AppBar(
        title: const Text("Food Items"),
        backgroundColor: primary,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: bill.items.length,
        itemBuilder: (context, index) {
         
          int count = bill.items[index].qty;
          double price = bill.items[index].price;
          return CustomFoodTile(
          
            title: '$count ${bill.items[index].name} ',
            subtitle: 'Total: ₹${(price * count).toStringAsFixed(2)}',
            img: bill.items[index].imageLink,
          );
        },
      ),
    );
  }
}
