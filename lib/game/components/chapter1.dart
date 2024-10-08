import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:samanta/game/game.dart';
import 'package:samanta/gen/assets.gen.dart';

class Chapter1 extends Component with HasGameRef<Samanta> {
  late SpriteComponent background;

  late Timer customerSpawnTimer;
  final double goalEarnings = 1000;

  late TextComponent earnings;

  late SpriteComponent counter;

  @override
  FutureOr<void> onLoad() async {
    background = SpriteComponent.fromImage(
      gameRef.images.fromCache(Assets.images.restaurant.path),
      size: gameRef.size,
    );
    await add(background);
    await add(MenuDisplay(position: gameRef.size / 2));
    gameRef.inventoryDisplay = InventoryDisplay(scale: Vector2.all(8), position: gameRef.size / 2);
    await add(gameRef.inventoryDisplay);

    customerSpawnTimer = Timer(5, repeat: true, onTick: spawnCustomer);
    customerSpawnTimer.start();
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

    counter = SpriteComponent.fromImage(
      gameRef.images.fromCache(Assets.images.counter.path),
      scale: Vector2.all(0.5),
    );
    add(counter);

    add(earnings);
  }

  @override
  void update(double dt) {
    background.size = gameRef.size;

    earnings.text = gameRef.totalEarnings.toString();
    customerSpawnTimer.update(dt);

    if (gameRef.numCustomers == 0 && customerSpawnTimer.current == 0) {
      gameRef.overlays.add('gameover_screen');
    }
  }

  void spawnCustomer() {
    if (gameRef.totalEarnings >= goalEarnings) {
      customerSpawnTimer.stop();
      return;
    }
    final customer = Customer();
    add(customer);
  }
}
