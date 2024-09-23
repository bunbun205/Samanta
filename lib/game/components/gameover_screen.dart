import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:samanta/gen/assets.gen.dart';

class GameoverScreen extends StatelessWidget {
  const GameoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        Assets.images.textbox.path,
        width: 600,
        height: 400,
      ),
    );
  }
}