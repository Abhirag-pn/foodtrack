import 'package:flutter/material.dart';

class Incrementer extends StatelessWidget {
  const Incrementer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
    
        child: Row(
          children: [
             IconButton(
                 onPressed: () {}, icon: const Icon(Icons.horizontal_rule,color: Colors.red,)),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text("4005",style: Theme.of(context).textTheme.titleMedium,),
                    ),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.add,color: Colors.green,))
          ],
        ),
      );
  }
}
