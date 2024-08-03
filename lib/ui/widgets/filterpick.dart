import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class FilterPick extends StatelessWidget {
  final void Function() actionFunction;
  final bool selected;
  final String text,img;
  const FilterPick({
    super.key, required this.text, required this.img, required this.actionFunction,
   required this.selected
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: actionFunction
        
      
      ,
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
            Image.network(img,height: 30,width: 30,),
            Text(text,style:Theme.of(context).textTheme.labelSmall!.copyWith(fontWeight: FontWeight.w600))
          ],
        ),
        ),
      ),
    );
  }
}
