import 'package:flutter/material.dart';
import 'package:foodtrack/ui/widgets/incrementer.dart';

import '../../constants/colors.dart';

class FoodTile extends StatelessWidget {
  const FoodTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(0),
      height: MediaQuery.of(context).size.height / 5.8,
      width: double.maxFinite,
      decoration: BoxDecoration(
     color: secondary
       ,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          
          Container(
            color: primary,
            height: double.maxFinite,
            width: MediaQuery.of(context).size.width / 3,
            child: Image.network(
              "https://www.cubesnjuliennes.com/wp-content/uploads/2023/10/Best-Crispy-Plain-Dosa-Recipe.jpg",
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 160,
                  child: Row(
                    children: [
                      Text(
                        "Dosa",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const Spacer(),
                      Text("₹43",
                          style: Theme.of(context).textTheme.titleLarge),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
              const Incrementer()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

