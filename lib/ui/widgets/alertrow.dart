import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlertRow extends StatelessWidget {
  final String amount,type;
  final DateTime date;
  final void Function()? approve;
  final void Function()? reject;
  const AlertRow({
    super.key, required this.amount, required this.type, required this.date,required this.approve,required this.reject,
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
                  Text( DateFormat('EEEE dd MMMM').format(date),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Text(
                      "₹$amount" ,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                     Image.asset(type=='gpay'?'assets/images/gpayicon.png':'assets/images/cashicon.png',height: 20,width: 20,)
                    ],
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: reject,
                child: const Icon(
                  Icons.close,
                  color: Colors.red,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap:approve ,
                child: Icon(
                  Icons.done,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        
        ),
        
      ],
    );
  }
}
