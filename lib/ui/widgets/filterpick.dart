import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class FilterPick extends StatefulWidget {
  final void Function(bool) actionFunction;
   bool selected;
  final String text,img;
   FilterPick({
    super.key, required this.text, required this.img, required this.actionFunction,
    required this.selected
  });

  @override
  State<FilterPick> createState() => _FilterPickState();
}

class _FilterPickState extends State<FilterPick> {
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(widget.selected==false)
        {
          widget.actionFunction(true);
        }else{
          widget.selected=false;
          widget.actionFunction(false);
        }
        
        setState(() {
          
        });
      },
      child: UnconstrainedBox(
        child: Container(
          width: MediaQuery.of(context).size.width/3.2,
          height: MediaQuery.of(context).size.height/22,
        decoration: BoxDecoration(
          color: widget.selected?primary:secondary,
          
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
