import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:samanta/gen/assets.gen.dart';

class Background extends ParallaxComponent {
  Background({required this.speed});

  final double speed;
  int houseNum = Random().nextInt(5) + 1;

  @override
  Future<void> onLoad() async {
    final layers = [
      ParallaxImageData(Assets.images.sky.path),
      ParallaxImageData(Assets.images.cloud.path),
      ParallaxImageData(Assets.images.trees.path),
      ParallaxImageData(Assets.images.lamp.path),
      ParallaxImageData(Assets.images.road.path),
    ];

    final baseVelocity = Vector2(speed / pow(2, layers.length), 0);

    final velocityMultiplierDelta = Vector2(2, 0);

    parallax = await game.loadParallax(
      layers,
      baseVelocity: baseVelocity,
      velocityMultiplierDelta: velocityMultiplierDelta,
      filterQuality: FilterQuality.none,
    );

  }
}
