import 'dart:async';

import 'package:flame/components.dart';

class Chapter2 extends World{
  Vector2 size;

  List<Map<String, String>> dialogue = [
    {'player': 'Hello, how are you?'},
    {'npc': 'I am fine, thank you!'},
    {'player': 'What can I do for you today?'},
  ];

  Chapter2({required this.size});
  @override
  FutureOr<void> onLoad() async{
    // TODO: implement onLoad
    // await add(MenuDisplay(position: size/2));
  }
}