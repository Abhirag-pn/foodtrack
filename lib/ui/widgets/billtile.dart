import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class BillTile extends StatelessWidget {
  const BillTile({
    super.key,
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
          CircleAvatar(
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
                "Monday, 18th June",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const Text("₹43"),
            ],
          ),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: const Text("Details"),
          ),
        ],
      ),
    );
  }
}
