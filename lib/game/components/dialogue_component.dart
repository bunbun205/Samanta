import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import 'package:samanta/game/game.dart';
import 'package:samanta/gen/assets.gen.dart';

class DialogueComponent extends PositionComponent with HasGameRef<Samanta> {
  DialogueComponent({
    required super.position,
  }) : super(anchor: Anchor.centerLeft);

  late final SpriteComponent player;
  late final SpriteComponent npc;

  late final SpriteComponent textbox;

  late final TextBoxComponent text;

  late final ButtonComponent nextButton;

  late final List<Map<String, String>> dialogues = [
    {'player': 'Hello, how are you?'},
    {'npc': 'I am fine, thank you!'},
    {'player': 'What can I do for you today?'},
    {'npc': ' well today i want you to run a restraunt for me'},
    {'player': ' okay then i better get to it.'},
  ];

  int counter = 0;

  @override
  Future<void> onLoad() async {
    late TextRenderer renderer;
    player = SpriteComponent.fromImage(gameRef.images.fromCache(Assets.images.player.path));
    npc = SpriteComponent.fromImage(gameRef.images.fromCache(Assets.images.rem.path));
    textbox = SpriteComponent.fromImage(gameRef.images.fromCache(Assets.images.textbox.path));
    player.scale = Vector2.all(0.1);
    npc.scale = Vector2(-0.1, 0.1);
    player.position = Vector2(-50, 0);
    npc.position = Vector2(50, 0);
    textbox.scale = Vector2(0.1, 0.1);
    textbox.position = Vector2(-textbox.size.x/20, 0);
    print(textbox.size);
    text = TextBoxComponent(
      anchor: anchor,
      text: dialogues[0].values.first,
      size: Vector2(textbox.size.x, textbox.size.y),
      scale: textbox.scale,
      position: textbox.position,
      align: Anchor.bottomCenter,
      textRenderer: TextPaint(style: TextStyle(fontSize: 24, color: Colors.black)).copyWith(
        (style) => style.copyWith(
          letterSpacing: 2.0,
        )
      ),
    );

    nextButton = ButtonComponent(
      button: SpriteComponent.fromImage(gameRef.images.fromCache(Assets.images.button.path)),
      buttonDown: SpriteComponent.fromImage(gameRef.images.fromCache(Assets.images.buttondown.path)),
      anchor: anchor,
      onPressed: _updateSprites,
      scale: textbox.scale/2,
      position: textbox.position + Vector2(25, 25),
    );
    await addAll([player, npc, textbox, text, nextButton]);
  }

  
  void _updateSprites() {
    if(counter > dialogues.length - 1) {
      gameRef.updateScene();
      return;
    }

    if(dialogues[counter].keys.first == 'player') {
      player.scale = Vector2.all(0.15);
      npc.scale = Vector2(-0.1, 0.1);
    }
    if(dialogues[counter].keys.first == 'npc') {
      player.scale = Vector2.all(0.1);
      npc.scale = Vector2(-0.15, 0.15);
    }
    text.text = dialogues[counter].values.first;
    counter++;
  }
}
