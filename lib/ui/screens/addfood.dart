import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:foodtrack/constants/colors.dart';
import 'package:foodtrack/ui/widgets/customtextfeild.dart';

import '../widgets/filterpick.dart';
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
        child: Stack(
          children: [
            Column(
              children: [
                
                 SizedBox(
                  height: MediaQuery.of(context).size.height/12,
                  width: double.maxFinite,
                  child: ListView(
                    
                    scrollDirection: Axis.horizontal,
                    children:  const [
                      FilterPick(
                        img: "https://static.vecteezy.com/system/resources/previews/019/614/281/non_2x/breakfast-graphic-clipart-design-free-png.png",
                        text: "Breakfast",
                      )
                       ,
                       SizedBox(width: 10,),
                        FilterPick(
                          img: "https://purepng.com/public/uploads/large/purepng.com-lunch-boxfood-box-school-lunch-box-lunch-941524636030wxs9g.png",
                          text: "Lunch",
                        )
                       ,
                       SizedBox(width: 10,),
                        FilterPick(
                          img: "https://i0.wp.com/www.treatwell.co.in/wp-content/uploads/2023/01/pazhampori.png?fit=500%2C500&ssl=1",
                          text: "Snacks",
                        )
                       ,
                       SizedBox(width: 10,),
                        FilterPick(
                          img: "https://static.vecteezy.com/system/resources/previews/025/268/632/non_2x/chicken-makhani-with-ai-generated-free-png.png",
                          text: "Curry",
                        ),
                         SizedBox(width: 10,),
                        FilterPick(
                          img: "https://static.vecteezy.com/system/resources/thumbnails/025/230/141/small_2x/fried-fish-carp-and-fresh-lemon-slice-on-transparent-background-free-png.png",
                          text: "Addons",
                        ),
                       
                        
            
                    ],
                  ),
                  
                 ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children:  [
                     
                      FoodTile(),
                      FoodTile(),
                      FoodTile(),
                      FoodTile(),
                      FoodTile(),
                      FoodTile(),
                      FoodTile(),
                      FoodTile(),
                      FoodTile(),
                      FoodTile(),
                      FoodTile(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/12,
                      )
                    ],
                  ),
                ),
             
              ],
            ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(onPressed: (){}, child: Text("Add")))
          ],
        ),
      ),
    );
  }
}

