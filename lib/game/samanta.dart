import 'package:audioplayers/audioplayers.dart';
import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/painting.dart';
import 'package:samanta/game/game.dart';
import 'package:samanta/gen/assets.gen.dart';
import 'package:samanta/l10n/l10n.dart';

class Samanta extends FlameGame
  with HasCollisionDetection {
  Samanta({
    required this.l10n,
    required this.effectPlayer,
    required this.textStyle,
    required Images images,
    required this.chapterNum,
  }) {
    this.images = images;
  }

  final AppLocalizations l10n;

  final AudioPlayer effectPlayer;

  final TextStyle textStyle;

  late double totalEarnings = 0;

  late String orderDisplay = '';

  int counter = 0;

  @override
  Color backgroundColor() => const Color(0xFF2A48DF);


  bool changeScene = false;
  int chapterNum;

  int numCustomers = 0;

  int score = 0;

  late List<Sprite> customerSprites = [
    Sprite(images.fromCache(Assets.images.queue1.path)),
    Sprite(images.fromCache(Assets.images.queue2.path)),
    Sprite(images.fromCache(Assets.images.queue3.path)),
    Sprite(images.fromCache(Assets.images.queue4.path)),
    Sprite(images.fromCache(Assets.images.queue5.path)),
  ];

  late RouterComponent router;

  late InventoryDisplay inventoryDisplay;

  @override
  Future<void> onLoad() async {

    router = RouterComponent(
      routes: {
        'Introduction' : chapterNum == 1 ? Route(WelcomeScreen.new) : Route(Chapter2.new),
        'Chapter1' : Route(Chapter1.new),
        'Chapter2' : Route(Chapter2.new),
      },
      initialRoute: 'Introduction',
    );
    await add(router);
    super.onLoad();
  }

  @override
  Future<void> update(double dt) async {
    if(changeScene) {

      switch (chapterNum) {
        case 1:
          router.pushNamed('Chapter1');
        
        case 2:
          router.pushNamed('Chapter2');

        default:
      } 
      
    }

    super.update(dt);
  }

  void updateScene() {
    changeScene = true;
  }
}
