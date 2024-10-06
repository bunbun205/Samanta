import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:samanta/game/components/components.dart';
import 'package:samanta/gen/assets.gen.dart';
=======
>>>>>>> Stashed changes

class GameoverScreen extends StatelessWidget {
  const GameoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
<<<<<<< Updated upstream
      child: Container(
        width:600, height: 400, color: Colors.white,
        child: Column
        (children: 
        [
            Container(height:50,),
            Text("gameover",style:TextStyle(fontSize:60) ,textAlign: TextAlign.center,),
             Text("well done on completing the first chapter",style: TextStyle(fontSize:25),),
             Container(height: 50,),
             Row(children: [
              TextButton(onPressed: (){}, child:Container()),
              TextButton(onPressed: (){}, child: Container())
             ],)
        ],
=======
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
>>>>>>> Stashed changes
        ),
      ),
    );
  }
}