import 'package:flutter/material.dart';

class GameoverScreen extends StatelessWidget {
  const GameoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 600,
        height: 400,
        child: Column(
          children: [
             const Text('Game Over', textAlign: TextAlign.center, style: TextStyle(fontSize: 60),),
             const Text('Chapter 1 is over', textAlign: TextAlign.center, style: TextStyle(fontSize: 12),),
             Row(children: [
              TextButton(onPressed: () {}, child: Container(),),
              TextButton(onPressed: () {}, child: Container()),
             ],),
          ],
        ),
      ),
    );
  }
}