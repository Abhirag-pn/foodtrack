import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class CustomTile extends StatelessWidget {
  final String title,subtitle,img;
  const CustomTile({
    super.key, required this.title, required this.subtitle, required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height / 10,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundImage:NetworkImage(img) ,
            radius: MediaQuery.of(context).size.width/14,
            
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
                style: Theme.of(context).textTheme.labelMedium,
              ),
               Text(subtitle,style: Theme.of(context).textTheme!.labelSmall,),
            ],
          ),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: const Text("Expand"),
          ),
        ],
      ),
    );
  }
}
