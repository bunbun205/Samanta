import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
import 'package:jenny/jenny.dart';
import 'package:samanta/game/game.dart';
import 'package:samanta/gen/assets.gen.dart';

class QuizComponent extends PositionComponent
    with HasGameRef<Samanta>, DialogueView {
  QuizComponent({required super.position, required super.size})
      : super(anchor: Anchor.centerLeft);

  late final SpriteComponent textbox;

  late final TextBoxComponent text;

  late final ButtonComponent nextButton;

  late final List<ButtonComponent> options = [];

  int counter = 0;

  final List<String> correctOptions = [
    'An activity that makes or sells goods and services',
    'Distributing products',
    'Primary Industry',
    'Consumer goods',
    'Wholesaler',
    'To move goods from one place to another',
    'All of the above',
    'It allows for quick responses to customer needs',
    'Storing goods safely',
    'Hotel industry',
    'Aids to Trade',
    'What is "insurance" used for in business?',
    'To protect against loss or damage',
    'C2C',
    'To inform consumers about products',
    'Primary Industry',
    'Finished products for consumers',
    'Digital transport',
    'Business to Consumer',
    'Building structures like buildings and bridges',
    'It allows for shopping from home'
  ];

  YarnProject yarnProject = YarnProject();

  Completer<int> _optionCompleter = Completer<int>();
  Completer _forwardCompleter = Completer();

  int index = 0;

  String quizData = ' ';

  @override
  Future<void> onLoad() async {
    quizData = await rootBundle.loadString(Assets.yarn.chapter2);
    yarnProject.parse(quizData);
    var dialogueRunner =
        DialogueRunner(yarnProject: yarnProject, dialogueViews: [this]);
    dialogueRunner.startDialogue('Chapter_2');
    textbox = SpriteComponent.fromImage(
        gameRef.images.fromCache(Assets.images.textbox.path));
    textbox.position =
        Vector2(-textbox.size.x / 2, gameRef.size.y / 2 - textbox.size.y / 2);

    text = TextBoxComponent(
      anchor: anchor,
      text: ' ',
      size: Vector2(textbox.size.x, textbox.size.y),
      scale: textbox.scale,
      position: textbox.position,
      align: Anchor.bottomCenter,
      textRenderer:
          TextPaint(style: const TextStyle(fontSize: 20, color: Colors.black))
              .copyWith(
        (style) => style.copyWith(
          letterSpacing: 2,
        ),
      ),
    );

    var buttonSprite = SpriteComponent.fromImage(
        gameRef.images.fromCache(Assets.images.button.path));

    nextButton = ButtonComponent(
      button: buttonSprite,
      buttonDown: SpriteComponent.fromImage(
          gameRef.images.fromCache(Assets.images.buttondown.path)),
      anchor: anchor,
      onPressed: () {
        if (!_forwardCompleter.isCompleted) {
          _forwardCompleter.complete();
        }
      },
      scale: textbox.scale / 2,
    );

    nextButton.position = Vector2(-buttonSprite.scaledSize.x / 2,
        gameRef.size.y / 2 + textbox.size.y / 2 + buttonSprite.size.y / 2);

    await addAll([textbox, nextButton, text]);
  }

  @override
  FutureOr<bool> onLineStart(DialogueLine line) async {
    _forwardCompleter = Completer();
    await _advance(line);
    return super.onLineStart(line);
  }

  @override
  FutureOr<int?> onChoiceStart(DialogueChoice choice) async {
    _optionCompleter = Completer<int>();
    nextButton.removeFromParent();
    for (int i = 0; i < choice.options.length; i++) {
      options.add(ButtonComponent(
        position: Vector2(textbox.position.x,
            textbox.position.y + textbox.scaledSize.y + i * 50 + 50),
        button: TextBoxComponent(
          text: '[${i + 1}] ${choice.options[i].text}',
          boxConfig: TextBoxConfig(
            maxWidth: gameRef.size.x,
            margins: EdgeInsets.all(5),
          ),
          textRenderer: TextPaint(
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      backgroundColor: Colors.white))
              .copyWith(
            (style) => style.copyWith(
              letterSpacing: 1,
            ),
          ),
        ),
        onPressed: () => {
          if (!_optionCompleter.isCompleted) {_optionCompleter.complete(i)}
        },
      ));
    }

    addAll(options);
    await _getChoice(choice);
    return _optionCompleter.future;
  }

  Future<void> _getChoice(DialogueChoice choice) async {
    return _forwardCompleter.future;
  }

  @override
  FutureOr<void> onChoiceFinish(DialogueOption option) async {
    if (option.text == correctOptions[index]) gameRef.score += 100;
    removeAll(options);
    options.clear();
    add(nextButton);
    index++;
    print(gameRef.score);
  }

  Future<void> _advance(DialogueLine line) async {
    text.text = line.text;
    return _forwardCompleter.future;
  }
}
