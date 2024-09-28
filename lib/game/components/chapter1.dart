import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:samanta/game/components/components.dart';
import 'package:samanta/game/components/gameover_screen.dart';
import 'package:samanta/game/game.dart';
import 'package:flutter/material.dart';
import 'package:samanta/gen/assets.gen.dart';

class Chapter1 extends Component with HasGameRef<Samanta>{

  late SpriteComponent background = SpriteComponent.fromImage(
    gameRef.images.fromCache(Assets.images.restaurant.path),
  );

  late Timer customerSpawnTimer;
  final double goalEarnings = 100;

  late TextComponent earnings;

  @override
  FutureOr<void> onLoad() async {
    await add(background);
    await add(MenuDisplay(scale: Vector2.all(8), position: gameRef.size / 2));

    customerSpawnTimer = Timer(5, repeat: true, onTick: spawnCustomer);
    earnings = TextComponent(
      text: gameRef.totalEarnings.toString(),
      textRenderer:
          TextPaint(style: const TextStyle(fontSize: 55, color: Colors.black))
              .copyWith(
        (style) => style.copyWith(
          letterSpacing: 2,
        ),
      ),
    );

    add(earnings);

  }

  @override
  void update(double dt) {
    background.scale = Vector2(gameRef.size.x/1920, gameRef.size.y/1080);
    earnings.text = gameRef.totalEarnings.toString();
    customerSpawnTimer.update(dt);
    if(gameRef.numCustomers==0 && customerSpawnTimer.current==0){
    gameRef.overlays.add("gameover_screen");
    }
  }

  void spawnCustomer() {
    if(gameRef.totalEarnings >= goalEarnings) {
      customerSpawnTimer.stop();
      return;
    }
    final customer = Customer();
    add(customer);
  }
}