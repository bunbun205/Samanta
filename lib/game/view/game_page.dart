import 'package:flame/game.dart' hide Route;
import 'package:flame_audio/bgm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samanta/game/components/gameover_screen.dart';
import 'package:samanta/game/game.dart';
import 'package:samanta/l10n/l10n.dart';
import 'package:samanta/loading/cubit/cubit.dart';

class GamePage extends StatelessWidget {
  const GamePage({required this.chapterNum, super.key});
  final int chapterNum;

  static Route<void> route(int chapterNum) {
    return MaterialPageRoute<void>(
      builder: (_) => GamePage(
        chapterNum: chapterNum,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AudioCubit(audioCache: context.read<PreloadCubit>().audio);
      },
      child: Scaffold(
        body: SafeArea(child: GameView(chapterNum: chapterNum)),
      ),
    );
  }
}

class GameView extends StatefulWidget {
  const GameView({required this.chapterNum, super.key, this.game});

  final FlameGame? game;

  final int chapterNum;

  @override
  State<GameView> createState() => _GameViewState(chapterNum: chapterNum);
}

class _GameViewState extends State<GameView> {
  _GameViewState({required this.chapterNum});
  FlameGame? _game;

  late final Bgm bgm;

  int chapterNum;

  @override
  void initState() {
    super.initState();
    bgm = context.read<AudioCubit>().bgm;
    // bgm.play(Assets.audio.background);
  }

  @override
  void dispose() {
    bgm.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodySmall!.copyWith(
          color: Colors.white,
          fontSize: 4,
        );

    _game ??= widget.game ??
        Samanta(
          l10n: context.l10n,
          effectPlayer: context.read<AudioCubit>().effectPlayer,
          textStyle: textStyle,
          images: context.read<PreloadCubit>().images,
          chapterNum: chapterNum,
        );
    return Stack(
      children: [
        Positioned.fill(
          child: GameWidget(
            game: _game!,
            overlayBuilderMap: {
              'gameover_screen': (BuildContext context, game) {
                return const GameoverScreen();
              },
            },
          ),
        ),
        Align(
            alignment: Alignment.topRight,
            child: Row(
              children: [
                BlocBuilder<AudioCubit, AudioState>(
                  builder: (context, state) {
                    return IconButton(
                      icon: Icon(
                        state.volume == 0 ? Icons.volume_off : Icons.volume_up,
                      ),
                      onPressed: () =>
                          context.read<AudioCubit>().toggleVolume(),
                    );
                  },
                ),
                // BlocBuilder<PauseCubit, PauseState>(
                //   builder: (context, pauseState) {
                //     return IconButton(
                //       icon: Icon(
                //         pauseState.paused ? Icons.play_arrow : Icons.pause,
                //       ),
                //       onPressed: () => context.read<PauseCubit>().togglePause(),
                //     );
                //   },
                // ),
                // BlocListener<ExitCubit, ExitState>(
                //   listener: (context, state) {
                //     if (state.shouldExit) {
                //       Navigator.of(context).pop(); // Exit the game
                //     }
                //   },
                //   child: IconButton(
                //     icon: const Icon(Icons.exit_to_app),
                //     onPressed: () => context.read<ExitCubit>().exitGame(),
                //   ),
                // ),
              ],
            )),
      ],
    );
  }
}
