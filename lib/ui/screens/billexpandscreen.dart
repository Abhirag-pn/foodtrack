import 'package:flutter/material.dart';
import 'package:foodtrack/constants/colors.dart';
import 'package:foodtrack/models/billmodel.dart';
import 'package:foodtrack/models/foodmodel.dart';
import 'package:foodtrack/ui/widgets/billtile.dart';
import 'package:foodtrack/ui/widgets/customfoodtile.dart';

class BillExpandScreen extends StatelessWidget {
  static const routename = 'billexpand';
  const BillExpandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bill = ModalRoute.of(context)!.settings.arguments as Bill;

    // Method to count food items
    Map<String, int> countFoodItems(List<Food> items) {
      Map<String, int> foodCounts = {};
      for (var item in items) {
        if (foodCounts.containsKey(item.name)) {
          foodCounts[item.name] = foodCounts[item.name]! + 1;
        } else {
          foodCounts[item.name] = 1;
        }
      }
      return foodCounts;
    }


    Map<String, int> foodCounts = countFoodItems(bill.items);

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
        itemCount: foodCounts.length,
        itemBuilder: (context, index) {
          String foodName = foodCounts.keys.elementAt(index);
          int count = foodCounts[foodName]!;
          double price = bill.items.firstWhere((item) => item.name == foodName).price;
          return CustomFoodTile(
          
            title: '$count $foodName ',
            subtitle: 'Total: ₹${(price * count).toStringAsFixed(2)}',
            img: bill.items.firstWhere((item) => item.name == foodName).imageLink,
          );
        },
      ),
    );
  }
}
