/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/Poppins-Regular.ttf
  String get poppinsRegular => 'assets/fonts/Poppins-Regular.ttf';

  /// List of all assets
  List<String> get values => [poppinsRegular];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/atm.png
  AssetGenImage get atm => const AssetGenImage('assets/icons/atm.png');

  /// File path: assets/icons/calendar.png
  AssetGenImage get calendar =>
      const AssetGenImage('assets/icons/calendar.png');

  /// File path: assets/icons/cgv.png
  AssetGenImage get cgv => const AssetGenImage('assets/icons/cgv.png');

  /// File path: assets/icons/face_id.png
  AssetGenImage get faceId => const AssetGenImage('assets/icons/face_id.png');

  /// File path: assets/icons/google.png
  AssetGenImage get google => const AssetGenImage('assets/icons/google.png');

  /// File path: assets/icons/home.png
  AssetGenImage get home => const AssetGenImage('assets/icons/home.png');

  /// File path: assets/icons/lock.png
  AssetGenImage get lock => const AssetGenImage('assets/icons/lock.png');

  /// File path: assets/icons/lotte.png
  AssetGenImage get lotte => const AssetGenImage('assets/icons/lotte.png');

  /// File path: assets/icons/my_ticker.png
  AssetGenImage get myTicker =>
      const AssetGenImage('assets/icons/my_ticker.png');

  /// File path: assets/icons/notification.png
  AssetGenImage get notification =>
      const AssetGenImage('assets/icons/notification.png');

  /// File path: assets/icons/seating.png
  AssetGenImage get seating => const AssetGenImage('assets/icons/seating.png');

  /// File path: assets/icons/shopee_pay.png
  AssetGenImage get shopeePay =>
      const AssetGenImage('assets/icons/shopee_pay.png');

  /// File path: assets/icons/shopping_cart.png
  AssetGenImage get shoppingCart =>
      const AssetGenImage('assets/icons/shopping_cart.png');

  /// File path: assets/icons/ticket.png
  AssetGenImage get ticket => const AssetGenImage('assets/icons/ticket.png');

  /// File path: assets/icons/translate.png
  AssetGenImage get translate =>
      const AssetGenImage('assets/icons/translate.png');

  /// File path: assets/icons/user.png
  AssetGenImage get user => const AssetGenImage('assets/icons/user.png');

  /// File path: assets/icons/video.png
  AssetGenImage get video => const AssetGenImage('assets/icons/video.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        atm,
        calendar,
        cgv,
        faceId,
        google,
        home,
        lock,
        lotte,
        myTicker,
        notification,
        seating,
        shopeePay,
        shoppingCart,
        ticket,
        translate,
        user,
        video
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/4dx.png
  AssetGenImage get a4dx => const AssetGenImage('assets/images/4dx.png');

  /// File path: assets/images/avatar.png
  AssetGenImage get avatar => const AssetGenImage('assets/images/avatar.png');

  /// File path: assets/images/banner.png
  AssetGenImage get banner => const AssetGenImage('assets/images/banner.png');

  /// File path: assets/images/banner2.png
  AssetGenImage get banner2 => const AssetGenImage('assets/images/banner2.png');

  /// File path: assets/images/banner3.png
  AssetGenImage get banner3 => const AssetGenImage('assets/images/banner3.png');

  /// File path: assets/images/bannerIntroImages2.jpg
  AssetGenImage get bannerIntroImages2 =>
      const AssetGenImage('assets/images/bannerIntroImages2.jpg');

  /// File path: assets/images/bannerIntroImages3.jpg
  AssetGenImage get bannerIntroImages3 =>
      const AssetGenImage('assets/images/bannerIntroImages3.jpg');

  /// File path: assets/images/bannerIntroImages4.jpg
  AssetGenImage get bannerIntroImages4 =>
      const AssetGenImage('assets/images/bannerIntroImages4.jpg');

  /// File path: assets/images/cover.png
  AssetGenImage get cover => const AssetGenImage('assets/images/cover.png');

  /// File path: assets/images/imax.png
  AssetGenImage get imax => const AssetGenImage('assets/images/imax.png');

  /// File path: assets/images/movie.png
  AssetGenImage get movie => const AssetGenImage('assets/images/movie.png');

  /// File path: assets/images/promo.png
  AssetGenImage get promo => const AssetGenImage('assets/images/promo.png');

  /// File path: assets/images/retal.png
  AssetGenImage get retal => const AssetGenImage('assets/images/retal.png');

  /// File path: assets/images/sweetbox.png
  AssetGenImage get sweetbox =>
      const AssetGenImage('assets/images/sweetbox.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        a4dx,
        avatar,
        banner,
        banner2,
        banner3,
        bannerIntroImages2,
        bannerIntroImages3,
        bannerIntroImages4,
        cover,
        imax,
        movie,
        promo,
        retal,
        sweetbox
      ];
}

class Assets {
  Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

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
