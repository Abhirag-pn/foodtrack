import 'package:flutter/material.dart';

class Incrementer extends StatefulWidget {
  final void Function() minusFunction,addFunction;
  const Incrementer({
    
    super.key, required this.minusFunction, required this.addFunction,
  });

  @override
  State<Incrementer> createState() => _IncrementerState();
}

class _IncrementerState extends State<Incrementer> {
  int count=0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
    
        child: Row(
          children: [
             IconButton(
                 onPressed: () {
                  setState(() {
                    if(count>0)
                  {  count--;
                    widget.minusFunction();}
                  });
                 }, icon: const Icon(Icons.horizontal_rule,color: Colors.red,)),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(count.toString(),style: Theme.of(context).textTheme.titleMedium,),
                    ),
            IconButton(
              
                onPressed: () {

                  setState(() {
                   if(count<50)
                   {
                     count++;
                    widget.addFunction();
                   }
                  });
                }, icon: const Icon(Icons.add,color: Colors.green,)),
          ],
        ),
      );
  }
}
