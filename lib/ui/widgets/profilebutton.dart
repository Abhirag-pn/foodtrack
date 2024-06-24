import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final String text;
  final IconData icon;
  const ProfileButton({
    super.key, required this.text, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height / 18,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {},
            child: Icon(icon),
          )
        ],
      ),
    );
  }
}
