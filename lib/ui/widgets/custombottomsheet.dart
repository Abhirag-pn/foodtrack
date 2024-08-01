import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  final void Function()? onTapCash,onTapGpay;
  const CustomBottomSheet({
    super.key, this.onTapCash, this.onTapGpay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
     padding: EdgeInsets.only(top:15),
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height/4.5,
      child:  Column(
        children: [
          Text("Choose Payment Method",style: Theme.of(context).textTheme.titleMedium),
          Divider(),
          ListTile(
            onTap: onTapCash,
            title: Text("Pay Using Cash"),
            trailing:  Image.asset('assets/images/cashicon.png',height: 30,width: 30,),
          ),
          ListTile(
            onTap: onTapGpay,
            title: Text("Pay Using Gpay"),
            trailing: Image.asset('assets/images/gpayicon.png',height: 30,width: 30,),
          )
        ],
      ),
    );
  }
}
