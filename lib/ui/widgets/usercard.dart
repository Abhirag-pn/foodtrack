import 'package:flutter/material.dart';
import 'package:foodtrack/constants/colors.dart';

class UserCard extends StatelessWidget {
  final void Function() onPress;
  final String title;
  final String subtitle;
  final String img;
  const UserCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onPress,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onPress,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: secondary, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              
              radius: 35,
              backgroundImage: NetworkImage(img,scale: 0.5),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(subtitle, style: Theme.of(context).textTheme.labelMedium)
          ],
        ),
      ),
    );
  }
}
