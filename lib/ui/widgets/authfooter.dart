import 'package:flutter/material.dart';
import 'package:foodtrack/constants/colors.dart';

class AuthFooter extends StatelessWidget {
  final String text1,text2;
  const AuthFooter({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                 text1,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                 GestureDetector(
                  onTap: (){},
                   child: Text(
                        text2,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: primary),
                      ),
                 )
              ],
            );
  }
}