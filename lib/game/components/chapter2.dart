import 'dart:async';

import 'package:flame/components.dart';
import 'package:samanta/game/game.dart';
<<<<<<< Updated upstream

class Chapter2 extends Component with HasGameRef<Samanta>{





  @override
  FutureOr<void> onLoad() async{
    // TODO: implement onLoad
    await add(QuizComponent(scale: Vector2.all(8),position: gameRef.size/2));
=======

class Chapter2 extends Component with HasGameRef<Samanta> {

  @override
  FutureOr<void> onLoad() async{
    // TODO: implement onLoad
    await add(QuizComponent(scale: Vector2.all(8), position: gameRef.size/2));
>>>>>>> Stashed changes
  }
}