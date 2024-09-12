import 'package:audioplayers/audioplayers.dart';
import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/painting.dart';
import 'package:samanta/game/game.dart';
import 'package:samanta/gen/assets.gen.dart';
import 'package:samanta/l10n/l10n.dart';

class Samanta extends FlameGame {
  Samanta({
    required this.l10n,
    required this.effectPlayer,
    required this.textStyle,
    required Images images,
  }) {
    this.images = images;
  }

  final AppLocalizations l10n;

  final AudioPlayer effectPlayer;

  final TextStyle textStyle;

  int counter = 0;

  @override
  Color backgroundColor() => const Color(0xFF2A48DF);


  bool changeScene = false;

  @override
  Future<void> onLoad() async {
    world = World(
      children: [
        // Unicorn(position: size / 2),
        // CounterComponent(
        //   position: (size / 2)
        //     ..sub(
        //       Vector2(0, 16),
        //     ),
        DialogueComponent(position: size/2),
      ],
    );

    camera = CameraComponent(world: world);
    camera.viewfinder.position = size / 2;
    camera.viewfinder.zoom = 8;
    camera.backdrop.add(Background(speed: 200));
    await addAll([world, camera]);
  }

  @override
  void update(double dt) {
    // TODO: implement update
    if(changeScene) {
      world = Restaurant();
      camera = CameraComponent(world: world);
      camera.viewfinder.position = size / 2;
      camera.viewfinder.zoom = 8;
      final background = SpriteComponent.fromImage(images.fromCache(Assets.images.restaurant.path));
      background.size = size;
      camera.backdrop.add(background);
    }
    super.update(dt);
  }

  void updateScene() {
    changeScene = true;
  }
}
