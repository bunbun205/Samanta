import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:samanta/game/game.dart';

class Chapter2 extends Component with HasGameRef<Samanta> {

  late TextComponent score;

  @override
  FutureOr<void> onLoad() async{
    await add(Background(speed: 100));
    score = TextComponent(
      text: gameRef.totalEarnings.toString(),
      textRenderer:
          TextPaint(style: const TextStyle(fontSize: 55, color: Colors.black))
              .copyWith(
        (style) => style.copyWith(
          letterSpacing: 2,
        ),
      ),
    );
    await add(QuizComponent(position: gameRef.size/2, size: gameRef.size));
    await add(score);
  }

  @override
  void update(double dt) {
    score.text = gameRef.score.toString();
    super.update(dt);
  }
}