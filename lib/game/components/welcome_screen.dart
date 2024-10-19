import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:samanta/game/game.dart';
import 'package:samanta/gen/assets.gen.dart';

class WelcomeScreen extends Component with HasGameRef<Samanta>{

  late DialogueComponent dialogueScreen;

  @override
  FutureOr<void> onLoad() async {

    String dialogueData = await rootBundle.loadString(Assets.yarn.chapter1);
    dialogueScreen = DialogueComponent(position: gameRef.size/2, dialogueData: dialogueData, size: gameRef.size);
    await add(Background(speed: 200));
    await add(dialogueScreen);

  }

  @override
  void update(double dt) async {
    dialogueScreen.position = gameRef.size/2;
    super.update(dt);
  }
}