import 'package:flutter/material.dart';

class GameoverScreen extends StatelessWidget {
  const GameoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 600,
        height: 200,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 54, 54, 54),
          backgroundBlendMode: BlendMode.darken,
          border: Border.all(width: 5, color: Colors.white),
        ),
        child: Column(
          children: [
             const Text('Game Over', textAlign: TextAlign.center, style: TextStyle(fontSize: 60, color: Colors.white),),
             const Text('Chapter 1 is over', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.white60),),
             Row(children: [
              TextButton(onPressed: () {}, child: Container(),),
             ],),
          ],
        ),
      ),
    );
  }
}