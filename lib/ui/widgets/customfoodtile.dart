import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class CustomFoodTile extends StatelessWidget {
  final String title,subtitle,img;
  
  const CustomFoodTile({
    super.key, required this.title, required this.subtitle, required this.img,  
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      height: MediaQuery.of(context).size.height / 10,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: MediaQuery.of(context).size.width/14,
            
         backgroundImage: NetworkImage(img),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.labelLarge,
              ),
               Text(subtitle),
            ],
          ),
         
        ],
      ),
    );
  }
}
