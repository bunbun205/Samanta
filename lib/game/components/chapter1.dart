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

  final Timer customerSpawnTimer = Timer(5, repeat: true);
  late TimerComponent customerSpawner;
  final double goalEarnings = 1000;

  late TextComponent earnings;

  @override
  FutureOr<void> onLoad() async {
    await add(background);
    await add(MenuDisplay(scale: Vector2.all(8), position: gameRef.size / 2));
 
    customerSpawnTimer.start();
    customerSpawner = TimerComponent(period: 5, repeat: true, onTick: spawnCustomer);
    add(customerSpawner);
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

    if(gameRef.totalEarnings >= goalEarnings) {
      print("goal reached");
      customerSpawner.removeFromParent();
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