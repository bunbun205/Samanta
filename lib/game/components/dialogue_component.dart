import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jenny/jenny.dart';
import 'package:samanta/game/game.dart';
import 'package:samanta/gen/assets.gen.dart';

class DialogueComponent extends PositionComponent
 with HasGameRef<Samanta>, DialogueView {
  DialogueComponent({
    required super.position, required this.dialogueData, required super.size
  }) : super(anchor: Anchor.centerLeft);

  late final SpriteComponent player;
  late final SpriteComponent npc;

  late final SpriteComponent textbox;

  late final TextBoxComponent text;

  late final ButtonComponent nextButton;

  late final String dialogueData;

  YarnProject yarnProject = YarnProject();

  Completer<void> _forwardCompleter = Completer();

  @override
  Future<void> onLoad() async {
    String testData = await rootBundle.loadString(Assets.yarn.test);
    yarnProject
      ..parse(dialogueData)
      ..parse(testData);
    var dialogueRunner = DialogueRunner(
      yarnProject: yarnProject, dialogueViews: [this]
    );
    dialogueRunner.startDialogue('Chapter_1');
    player = SpriteComponent.fromImage(gameRef.images.fromCache(Assets.images.player.path));
    npc = SpriteComponent.fromImage(gameRef.images.fromCache(Assets.images.rem.path));
    textbox = SpriteComponent.fromImage(gameRef.images.fromCache(Assets.images.textbox.path));
    // player.scale = Vector2.all(0.1);
    // npc.scale = Vector2(-0.1, 0.1);
    player.position = Vector2(-gameRef.size.x/2 + 2.5*player.size.x, gameRef.size.y/2 - player.size.y/3);
    npc.flipHorizontallyAroundCenter();
    npc.position = Vector2(gameRef.size.x/2 - 2.5*player.size.x, gameRef.size.y/2 - player.size.y/3);
    // textbox.scale = Vector2(0.1, 0.1);
    textbox.position = Vector2(-textbox.size.x/2, gameRef.size.y/2 - textbox.size.y/2);
    text = TextBoxComponent(
      anchor: anchor,
      text: ' ',
      size: Vector2(textbox.size.x, textbox.size.y),
      scale: textbox.scale,
      position: textbox.position,
      align: Anchor.bottomCenter,
      textRenderer: TextPaint(style: const TextStyle(fontSize: 20, color: Colors.black)).copyWith(
        (style) => style.copyWith(
          letterSpacing: 2,
          
        ),
      ),
    );

    var buttonSprite = SpriteComponent.fromImage(gameRef.images.fromCache(Assets.images.button.path));

    nextButton = ButtonComponent(
      button: buttonSprite,
      buttonDown: SpriteComponent.fromImage(gameRef.images.fromCache(Assets.images.buttondown.path)),
      anchor: anchor,
      onPressed: _updateSprites,
      scale: textbox.scale/2,
    );

    nextButton.position = Vector2(- buttonSprite.scaledSize.x/2, gameRef.size.y/2 + textbox.size.y/2 + buttonSprite.size.y/2);
    await addAll([player, npc, textbox, text, nextButton]);
  }

  @override
  FutureOr<bool> onLineStart(DialogueLine line) async {
    _forwardCompleter = Completer();
    await _advance(line);
    return super.onLineStart(line);
  }

  var characterName;

  Future<void> _advance(DialogueLine line) async {
    text.text = line.text;
    characterName = line.character?.name;
    if(characterName == 'player') {
      player.scale = Vector2.all(1.5);
      npc.scale = Vector2(-1, 1);
    }
    if(characterName == 'npc') {
      player.scale = Vector2.all(1);
      npc.scale = Vector2(-1.5, 1.5);
    }
    return _forwardCompleter.future;
  }

  
  void _updateSprites() {
    // if(counter > dialogues.length - 1) {
    //   gameRef.updateScene();
    //   return;
    // }

    
    // text.text = dialogues[counter].values.first;
    // counter++;

    if(!_forwardCompleter.isCompleted) {
      _forwardCompleter.complete();
    }

  }

 @override
  FutureOr<void> onNodeFinish(Node node) async {
    gameRef.updateScene();
    return super.onNodeFinish(node);
  }
}
