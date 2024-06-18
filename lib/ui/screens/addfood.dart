import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodtrack/constants/colors.dart';
import 'package:foodtrack/ui/widgets/customtextfeild.dart';

import '../widgets/foodtile.dart';

class AddFoodScreen extends StatelessWidget {
  const AddFoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.done))
        ],
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
        title: const Text("Add Items"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
             const CustomTextFeild(hint: "Search", type: FeildType.search),
             SizedBox(
              height: MediaQuery.of(context).size.height/12,
              width: double.maxFinite,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  UnconstrainedBox(
                    child: Container(
                      width: MediaQuery.of(context).size.width/3,
                      height: MediaQuery.of(context).size.height/15,
                    decoration: BoxDecoration(
                      color: secondary,
                      
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.network("https://static.vecteezy.com/system/resources/previews/019/614/281/non_2x/breakfast-graphic-clipart-design-free-png.png",height: 40,width: 40,),
                        Text("Breakfast")
                      ],
                    ),
                    ),
                  )
                   ,

                ],
              ),
             ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                 
                  const FoodTile(),
                  const FoodTile(),
                  const FoodTile(),
                  const FoodTile(),
                  const FoodTile(),
                  const FoodTile(),
                  const FoodTile(),
                  const FoodTile(),
                  const FoodTile(),
                  const FoodTile(),
                  const FoodTile(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
