import 'dart:async';
import 'dart:js_interop';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import 'package:samanta/game/game.dart';
import 'package:samanta/gen/assets.gen.dart';

class QuizComponent extends PositionComponent with HasGameRef<Samanta> {
  QuizComponent({
    required super.scale, required super.position
  }) : super(anchor: Anchor.centerLeft);

  late final SpriteComponent player;
  late final SpriteComponent npc;

  late final SpriteComponent textbox;

  late final TextBoxComponent text;

  late final ButtonComponent nextButton;

  late final List<ButtonComponent> options;

  @override
  FutureOr<void> onLoad() async{
    textbox=SpriteComponent.fromImage(gameRef.images.fromCache(Assets.images.textbox.path));
    textbox.position=Vector2(-textbox.size.x*3/20,-5 );
    textbox.scale=Vector2(0.3,0.1);
    nextButton=ButtonComponent(
      button: SpriteComponent.fromImage(gameRef.images.fromCache(Assets.images.button.path)),
      buttonDown: SpriteComponent.fromImage(gameRef.images.fromCache(Assets.images.buttondown.path)),
      anchor: anchor,
      scale: Vector2(.1,.1),
      position:Vector2(textbox.size.x*3/20+10,50),
      onPressed:_nextOption
    );
    // TODO: implement onLoad
    await addAll([textbox,nextButton]);
    return super.onLoad();
  }

  void _nextOption() {
  }
}