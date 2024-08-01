import 'package:flutter/material.dart';

class AlertRow extends StatelessWidget {
  final String amount,type;
  final DateTime date;
  const AlertRow({
    super.key, required this.amount, required this.type, required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(  
      children: [
       Divider(), SizedBox(
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
                     Image.asset('assets/images/gpayicon.png',height: 20,width: 20,)
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
        
        ),
        
      ],
    );
  }
}
