/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsAudioGen {
  const $AssetsAudioGen();

  /// File path: assets/audio/background.mp3
  String get background => 'assets/audio/background.mp3';

  /// File path: assets/audio/effect.mp3
  String get effect => 'assets/audio/effect.mp3';
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/unicorn_animation.png
  AssetGenImage get unicornAnimation =>
      const AssetGenImage('assets/images/unicorn_animation.png');
  
  AssetGenImage get sky =>
      const AssetGenImage('assets/images/sky.png');

  AssetGenImage get road =>
      const AssetGenImage('assets/images/road.png');

  AssetGenImage get trees =>
      const AssetGenImage('assets/images/trees.png');

  AssetGenImage get cloud =>
      const AssetGenImage('assets/images/cloud.png');
  
  AssetGenImage get lamp =>
      const AssetGenImage('assets/images/lamp.png');

  AssetGenImage get player =>
      const AssetGenImage('assets/images/player.png');

  AssetGenImage get rem =>
      const AssetGenImage('assets/images/rem.png');

  AssetGenImage get textbox =>
      const AssetGenImage('assets/images/textbox.png');

  AssetGenImage get button =>
      const AssetGenImage('assets/images/button.png');
  
  AssetGenImage get buttondown =>
      const AssetGenImage('assets/images/buttondown.png');

  AssetGenImage get restaurant =>
      const AssetGenImage('assets/images/restaurant.jpg');

  AssetGenImage get queue1 =>
      const AssetGenImage('assets/images/queue1.png');

  AssetGenImage get queue2 =>
      const AssetGenImage('assets/images/queue2.png');

  AssetGenImage get queue3 =>
      const AssetGenImage('assets/images/queue3.png');

  AssetGenImage get queue4 =>
      const AssetGenImage('assets/images/queue5.png');

  AssetGenImage get queue5 =>
      const AssetGenImage('assets/images/queue5.png');

  AssetGenImage get shelf =>
      const AssetGenImage('assets/images/shelf.jpg');

  AssetGenImage get counter =>
      const AssetGenImage('assets/images/counter.png');

  AssetGenImage get legend =>
      const AssetGenImage('assets/images/legend.png');
}

class $AssetsYarnGen {
  const $AssetsYarnGen();

  /// File path: assets/audio/background.mp3
  String get chapter1 => 'assets/yarn/chapter1.yarn';
  String get test => 'assets/yarn/test.yarn';
  String get chapter2 => 'assets/yarn/chapter2.yarn';
}

class $AssetsLicensesGen {
  const $AssetsLicensesGen();

  $AssetsLicensesPoppinsGen get poppins => const $AssetsLicensesPoppinsGen();
}

class $AssetsLicensesPoppinsGen {
  const $AssetsLicensesPoppinsGen();

  /// File path: assets/licenses/poppins/OFL.txt
  String get ofl => 'assets/licenses/poppins/OFL.txt';
}

class Assets {
  Assets._();

  static const $AssetsAudioGen audio = $AssetsAudioGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsYarnGen yarn = $AssetsYarnGen();
  static const $AssetsLicensesGen licenses = $AssetsLicensesGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}
