import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import 'package:samanta/game/game.dart';
import 'package:samanta/gen/assets.gen.dart';

class DialogueComponent extends PositionComponent with HasGameRef<Samanta> {
  DialogueComponent({
    required super.position, required this.dialogues, required super.size
  }) : super(anchor: Anchor.centerLeft);

  late final SpriteComponent player;
  late final SpriteComponent npc;

  late final SpriteComponent textbox;

  late final TextBoxComponent text;

  late final ButtonComponent nextButton;

  late final List<Map<String, String>> dialogues;

  int counter = 0;

  @override
  Future<void> onLoad() async {
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
      text: dialogues[0].values.first,
      size: Vector2(textbox.size.x, textbox.size.y),
      scale: textbox.scale,
      position: textbox.position,
      align: Anchor.bottomCenter,
      textRenderer: TextPaint(style: const TextStyle(fontSize: 24, color: Colors.black)).copyWith(
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

  
  void _updateSprites() {
    if(counter > dialogues.length - 1) {
      gameRef.updateScene();
      return;
    }

    if(dialogues[counter].keys.first == 'player') {
      player.scale = Vector2.all(1.5);
      npc.scale = Vector2(-1, 1);
    }
    if(dialogues[counter].keys.first == 'npc') {
      player.scale = Vector2.all(1);
      npc.scale = Vector2(-1.5, 1.5);
    }
    text.text = dialogues[counter].values.first;
    counter++;
  }
}
