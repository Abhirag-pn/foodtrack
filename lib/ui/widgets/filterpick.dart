import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class FilterPick extends StatefulWidget {
  final String text,img;
  const FilterPick({
    super.key, required this.text, required this.img,
  });

  @override
  State<FilterPick> createState() => _FilterPickState();
}

class _FilterPickState extends State<FilterPick> {
  bool selected=false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        selected=!selected;
        setState(() {
          
        });
      },
      child: UnconstrainedBox(
        child: Container(
          width: MediaQuery.of(context).size.width/3.2,
          height: MediaQuery.of(context).size.height/22,
        decoration: BoxDecoration(
          color: selected?primary:secondary,
          
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network(widget.img,height: 30,width: 30,),
            Text(widget.text,style:Theme.of(context).textTheme.labelSmall!.copyWith(fontWeight: FontWeight.w600))
          ],
        ),
        ),
      ),
    );
  }
}
