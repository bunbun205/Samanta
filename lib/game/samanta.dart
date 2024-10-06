import 'package:audioplayers/audioplayers.dart';
import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/painting.dart';
import 'package:samanta/game/game.dart';
import 'package:samanta/gen/assets.gen.dart';
import 'package:samanta/l10n/l10n.dart';

<<<<<<< Updated upstream
class Samanta extends FlameGame with HasCollisionDetection {
=======
class Samanta extends FlameGame
  with HasCollisionDetection {
>>>>>>> Stashed changes
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

  int counter = 0;

  @override
  Color backgroundColor() => const Color(0xFF2A48DF);


  bool changeScene = false;
  int chapterNum;

<<<<<<< Updated upstream
int numCustomers=0;
=======
  int numCustomers = 0;
>>>>>>> Stashed changes

  late List<Sprite> customerSprites = [
    Sprite(images.fromCache(Assets.images.customer.path)),
    Sprite(images.fromCache(Assets.images.rem.path)),
    Sprite(images.fromCache(Assets.images.customer1.path)),
  ];

  late RouterComponent router;

  @override
  Future<void> onLoad() async {

    router = RouterComponent(
      routes: {
<<<<<<< Updated upstream
        "Introduction" : Route(WelcomeScreen.new),
        "Chapter1" : Route(Chapter1.new),
        "Chapter2" : Route(Chapter2.new),
=======
        'Introduction' : Route(WelcomeScreen.new),
        'Chapter1' : Route(Chapter1.new),
        'Chapter2' : Route(Chapter2.new),
>>>>>>> Stashed changes
      },
      initialRoute: 'Introduction',
    );
    await add(router);
    super.onLoad();
  }

  @override
<<<<<<< Updated upstream
  void update(double dt) async {
    if(changeScene) {
    switch(chapterNum){
      case 1:
        router.pushNamed("Chapter1");
      break;
      case 2:
        router.pushNamed("Chapter2");
      break;
    }
=======
  Future<void> update(double dt) async {
    if(changeScene) {

      switch (chapterNum) {
        case 1:
          router.pushNamed('Chapter1');
        
        case 2:
          router.pushNamed('Chapter2');

        default:
      } 
      
>>>>>>> Stashed changes
    }

    print(numCustomers);
    super.update(dt);
  }

  void updateScene() {
    changeScene = true;
  }
}
