import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class HistoryTile extends StatelessWidget {
  final String title, subtitle;
  final bool isRejected, isCompleted;
  const HistoryTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isCompleted,
    required this.isRejected,
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
              radius: MediaQuery.of(context).size.width / 14,
              child: isCompleted
                  ? const Icon(Icons.done)
                  : ((isCompleted == false && isRejected == false))
                      ? Icon(Icons.access_time_rounded)
                      : const Icon(Icons.close)),
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
              Text(subtitle)
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
