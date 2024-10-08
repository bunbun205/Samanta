import 'dart:async';

import 'package:flame/components.dart';
import 'package:samanta/game/game.dart';

class WelcomeScreen extends Component with HasGameRef<Samanta>{

  List<Map<String, String>> dialogue = [
    {'player': 'Hello, how are you?'},
    {'npc': 'I am fine, thank you!'},
    {'player': 'What can I do for you today?'},
    {'npc': ' well today i want you to run a restraunt for me'},
    {'player': ' okay then i better get to it.'},
  ];

  late DialogueComponent dialogueScreen;

  @override
  FutureOr<void> onLoad() async {
    dialogueScreen = DialogueComponent(position: gameRef.size/2, dialogues: dialogue, size: gameRef.size);
    await add(Background(speed: 200));
    await add(dialogueScreen);

  }

  @override
  void update(double dt) {
    dialogueScreen.position = gameRef.size/2;
    super.update(dt);
  }
}