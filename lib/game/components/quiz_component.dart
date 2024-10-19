import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
import 'package:jenny/jenny.dart';
import 'package:samanta/game/game.dart';
import 'package:samanta/gen/assets.gen.dart';

class QuizComponent extends PositionComponent
 with HasGameRef<Samanta>, DialogueView {
  QuizComponent({
    required super.scale, required super.position,
  }) : super(anchor: Anchor.centerLeft);

  late final SpriteComponent player;
  late final SpriteComponent npc;

  late final SpriteComponent textbox;

  late final TextBoxComponent text;

  late final ButtonComponent nextButton;

  late final List<ButtonComponent> options;

  YarnProject yarnProject = YarnProject();

  Completer<int> _optionCompleter = Completer<int>();
  Completer _forwardCompleter = Completer();

  int counter = 0;

  String quizData = ' ';

  @override
  Future<void> onLoad() async {
    quizData = await rootBundle.loadString(Assets.yarn.chapter2);
    yarnProject.parse(quizData);
    var dialogueRunner = DialogueRunner(
      yarnProject: yarnProject, dialogueViews:[this]
    );
    player = SpriteComponent.fromImage(gameRef.images.fromCache(Assets.images.player.path));
    npc = SpriteComponent.fromImage(gameRef.images.fromCache(Assets.images.rem.path));
    textbox = SpriteComponent.fromImage(gameRef.images.fromCache(Assets.images.textbox.path));
    player.scale = Vector2.all(0.1);
    npc.scale = Vector2(-0.1, 0.1);
    player.position = Vector2(-50, -5);
    npc.position = Vector2(50, -5);
    textbox.scale = Vector2(0.1, 0.1);
    textbox.position = Vector2(-textbox.size.x/20, 0);

    var buttonSprite = SpriteComponent.fromImage(gameRef.images.fromCache(Assets.images.button.path));

    nextButton = ButtonComponent(
      button: buttonSprite,
      buttonDown: SpriteComponent.fromImage(gameRef.images.fromCache(Assets.images.buttondown.path)),
      anchor: anchor,
      onPressed: () {
        if(!_forwardCompleter.isCompleted) {
          _forwardCompleter.complete();
        }
      },
      scale: textbox.scale/2,
    );

    await addAll([player, npc, textbox, nextButton]);
  }

  

}
