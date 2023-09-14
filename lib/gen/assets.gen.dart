/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/FAVS.png
  AssetGenImage get favs => const AssetGenImage('assets/icons/FAVS.png');

  /// File path: assets/icons/back.png
  AssetGenImage get back => const AssetGenImage('assets/icons/back.png');

  /// File path: assets/icons/call.png
  AssetGenImage get call => const AssetGenImage('assets/icons/call.png');

  /// File path: assets/icons/check.png
  AssetGenImage get check => const AssetGenImage('assets/icons/check.png');

  /// File path: assets/icons/edit.png
  AssetGenImage get edit => const AssetGenImage('assets/icons/edit.png');

  /// File path: assets/icons/flag.jpg
  AssetGenImage get flag => const AssetGenImage('assets/icons/flag.jpg');

  /// File path: assets/icons/info.png
  AssetGenImage get info => const AssetGenImage('assets/icons/info.png');

  /// File path: assets/icons/log_out.png
  AssetGenImage get logOut => const AssetGenImage('assets/icons/log_out.png');

  /// File path: assets/icons/note.png
  AssetGenImage get note => const AssetGenImage('assets/icons/note.png');

  /// File path: assets/icons/password.jpg
  AssetGenImage get password =>
      const AssetGenImage('assets/icons/password.jpg');

  /// File path: assets/icons/person.jpg
  AssetGenImage get person => const AssetGenImage('assets/icons/person.jpg');

  /// File path: assets/icons/phone.jpg
  AssetGenImage get phone => const AssetGenImage('assets/icons/phone.jpg');

  /// File path: assets/icons/question.png
  AssetGenImage get question =>
      const AssetGenImage('assets/icons/question.png');

  /// File path: assets/icons/search.jpg
  AssetGenImage get search => const AssetGenImage('assets/icons/search.jpg');

  /// File path: assets/icons/share.png
  AssetGenImage get share => const AssetGenImage('assets/icons/share.png');

  /// File path: assets/icons/star.png
  AssetGenImage get star => const AssetGenImage('assets/icons/star.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        favs,
        back,
        call,
        check,
        edit,
        flag,
        info,
        logOut,
        note,
        password,
        person,
        phone,
        question,
        search,
        share,
        star
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/app_icon.svg
  String get appIcon => 'assets/images/app_icon.svg';

  /// File path: assets/images/city.png
  AssetGenImage get city => const AssetGenImage('assets/images/city.png');

  /// File path: assets/images/drawer_background.png
  AssetGenImage get drawerBackground =>
      const AssetGenImage('assets/images/drawer_background.png');

  /// File path: assets/images/logo.jpg
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.jpg');

  /// File path: assets/images/main_logo.png
  AssetGenImage get mainLogo =>
      const AssetGenImage('assets/images/main_logo.png');

  /// File path: assets/images/saudi.jpg
  AssetGenImage get saudi => const AssetGenImage('assets/images/saudi.jpg');

  /// File path: assets/images/side_leaves.png
  AssetGenImage get sideLeaves =>
      const AssetGenImage('assets/images/side_leaves.png');

  /// File path: assets/images/splash_background.png
  AssetGenImage get splashBackground =>
      const AssetGenImage('assets/images/splash_background.png');

  /// File path: assets/images/top_leaves.png
  AssetGenImage get topLeaves =>
      const AssetGenImage('assets/images/top_leaves.png');

  /// List of all assets
  List<dynamic> get values => [
        appIcon,
        city,
        drawerBackground,
        logo,
        mainLogo,
        saudi,
        sideLeaves,
        splashBackground,
        topLeaves
      ];
}

class $AssetsTranslationsGen {
  const $AssetsTranslationsGen();

  /// File path: assets/translations/ar.json
  String get ar => 'assets/translations/ar.json';

  /// File path: assets/translations/en.json
  String get en => 'assets/translations/en.json';

  /// List of all assets
  List<String> get values => [ar, en];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsTranslationsGen translations = $AssetsTranslationsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}