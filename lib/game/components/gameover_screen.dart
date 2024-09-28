import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:samanta/game/components/components.dart';
import 'package:samanta/gen/assets.gen.dart';

class GameoverScreen extends StatelessWidget {
  const GameoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
        ),
      ),
    );
  }
}