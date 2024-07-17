import 'package:flutter/material.dart';

class AlertRow extends StatelessWidget {
  const AlertRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Monday 12 June",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Text(
                    "₹200",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                 Image.asset('assets/images/upiicon.png',height: 20,width: 20,)
                ],
              ),
            ],
          ),
          const Spacer(),
          const Icon(
            Icons.close,
            color: Colors.red,
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.done,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
