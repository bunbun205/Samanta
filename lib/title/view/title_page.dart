import 'package:flutter/material.dart';
import 'package:samanta/game/game.dart';
import 'package:samanta/l10n/l10n.dart';

class TitlePage extends StatelessWidget {
  const TitlePage({required this.chapterNum, required this.chapterName, super.key});

  final int chapterNum;
  final String chapterName;

  static Route<void> route(int num, String name) {
    return MaterialPageRoute<void>(
      builder: (_) => TitlePage(chapterNum: num, chapterName: name,),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text('Chapter $chapterNum : $chapterName'),
      ),
      body: const SafeArea(child: TitleView()),
    );
  }
}

class TitleView extends StatelessWidget {
  const TitleView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Center(
      child: SizedBox(
        width: 250,
        height: 64,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement<void, void>(GamePage.route());
          },
          child: Center(child: Text(l10n.titleButtonStart)),
        ),
      ),
    );
  }
}
