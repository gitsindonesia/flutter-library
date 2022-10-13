import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Popup Variable
typedef CancelFunction = void Function();
typedef GitsPopUpBuilder = Widget Function(CancelFunction cancelFunction);
typedef FutureFunction = Future<void> Function();
typedef PopTestFunction = bool Function();

typedef WrapWidget = Widget Function(
    CancelFunction cancelFunction, Widget widget);
typedef WrapAnimation = Widget Function(AnimationController controller,
    CancelFunction cancelFunction, Widget widget);

class TickerProviderImpl extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}

/// Popup Widget Back Button Behaviour
enum BackButtonBehavior { none, ignore, close }

/// Colors Constants
Color blackColorCons = const Color(0xFF3F3F3F);
Color whiteColorCons = const Color(0xFFFFFFFF);
Color infoColorCons = const Color(0xFF3576C2);
Color dangerColorCons = const Color(0xFFEE1745);
Color warningColorCons = const Color(0xFFF99C1D);
Color successColorCons = const Color(0xFF15A049);
Color successBackgroundColorCons = const Color(0xFFE4F6EF);
Color infoBackgroundColorCons = const Color(0xFFDCEAFB);
Color dangerBackgroundColorCons = const Color(0xFFFEEFEF);
Color warningBackgroundColorCons = const Color(0xFFFFFDE1);

/// Font Size
double titleFontSizeCons = 12;
double subtitleFontSizeCons = 12;
