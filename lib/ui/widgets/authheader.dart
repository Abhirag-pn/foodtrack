import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthHeader extends StatelessWidget {
  final String title,subtitle,img;
  const AuthHeader({super.key, required this.title, required this.subtitle, required this.img});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          SvgPicture.asset(img,height: MediaQuery.of(context).size.height/4.5,),
            const SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),),
                   Text(subtitle,style: Theme.of(context).textTheme.titleMedium),
                ],
              )),
      ],
    );
  }
}