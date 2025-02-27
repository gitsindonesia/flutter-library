import 'dart:async';

import 'package:flutter/material.dart';

import 'gits_pop_up_cons.dart';
import 'gits_pop_up_init.dart';
import 'index_painters.dart';
import 'keyboard_safe_area.dart';
import 'gits_pop_up_navigator_observer.dart';
import 'popup_widget/notification_card.dart';
import 'popup_widget/popup_widget.dart';

class GitsPopUp {
  static const String textKey = '_textKey';
  static const String notificationKey = '_notificationKey';
  static const String loadKey = '_loadKey';
  static const String attachedKey = '_attachedKey';
  static const String defaultKey = '_defaultKey';

  static final Map<String, List<CancelFunction>> cacheCancelFunction = {
    textKey: [],
    notificationKey: [],
    loadKey: [],
    attachedKey: [],
    defaultKey: [],
  };

  ///Display a custom notification notif
  static CancelFunction showCustomNotif(
      {required GitsPopUpBuilder gitsPopUpBuilder,
      WrapAnimation? wrapAnimation,
      WrapAnimation? wrapToastAnimation = notificationAnimation,
      Alignment? align = const Alignment(0, -0.99),
      List<DismissDirection> dismissDirections = const [
        DismissDirection.horizontal,
        DismissDirection.up
      ],
      Duration? duration = const Duration(seconds: 2),
      Duration? animationDuration,
      Duration? animationReverseDuration,
      VoidCallback? onClose,
      BackButtonBehavior? backButtonBehavior,
      bool enableKeyboardSafeArea = true,
      bool enableSlideOff = true,
      bool crossPage = true,
      bool onlyOne = true,
      bool useSafeArea = true}) {
    return showAnimationWidget(
        crossPage: crossPage,
        allowClick: true,
        clickClose: false,
        ignoreContentClick: false,
        enableKeyboardSafeArea: enableKeyboardSafeArea,
        onlyOne: onlyOne,
        onClose: onClose,
        duration: duration,
        backButtonBehavior: backButtonBehavior,
        animationDuration:
            animationDuration ?? const Duration(milliseconds: 256),
        animationReverseDuration: animationReverseDuration,
        wrapAnimation: wrapAnimation,
        wrapToastAnimation: (controller, cancel, child) {
          if (wrapToastAnimation != null) {
            child = wrapToastAnimation(controller, cancel, child);
          }
          if (align != null) {
            child = Align(alignment: align, child: child);
          }
          return useSafeArea ? SafeArea(child: child) : child;
        },
        gitsPopUpBuilder: (cancelFunction) => NotificationPopup(
            dismissDirections: dismissDirections,
            slideOffFunc: enableSlideOff ? cancelFunction : null,
            child: gitsPopUpBuilder(cancelFunction)),
        groupKey: notificationKey);
  }

  static CancelFunction showAnimationWidget({
    required GitsPopUpBuilder gitsPopUpBuilder,
    required Duration animationDuration,
    Duration? animationReverseDuration,
    WrapAnimation? wrapAnimation,
    WrapAnimation? wrapToastAnimation,
    BackButtonBehavior? backButtonBehavior,
    UniqueKey? key,
    String? groupKey,
    bool crossPage = true,
    bool allowClick = true,
    bool clickClose = false,
    bool ignoreContentClick = false,
    bool onlyOne = false,
    bool enableKeyboardSafeArea = true,
    Color backgroundColor = Colors.transparent,
    Duration? duration,
    VoidCallback? onClose,
  }) {
    AnimationController? controller = _createAnimationController(
        animationDuration,
        reverseDuration: animationReverseDuration);

    return showEnhancedWidget(
        allowClick: allowClick,
        clickClose: clickClose,
        groupKey: groupKey,
        key: key,
        crossPage: crossPage,
        onClose: onClose,
        onlyOne: onlyOne,
        enableKeyboardSafeArea: enableKeyboardSafeArea,
        backButtonBehavior: backButtonBehavior,
        backgroundColor: backgroundColor,
        ignoreContentClick: ignoreContentClick,
        closeFunc: () async {
          await controller?.reverse();
        },
        duration: duration,
        warpWidget: (cancel, child) => ProxyInitState(
              initStateCallback: () {
                assert(!controller!.isAnimating);
                controller!.forward();
              },
              child: ProxyDispose(
                  disposeCallback: () {
                    controller!.dispose();
                    controller = null;
                  },
                  child: wrapAnimation != null
                      ? wrapAnimation(controller!, cancel, child)
                      : child),
            ),
        gitsPopUpBuilder: (cancelFunction) => wrapToastAnimation != null
            ? wrapToastAnimation(
                controller!, cancelFunction, gitsPopUpBuilder(cancelFunction))
            : gitsPopUpBuilder(cancelFunction));
  }

  static CancelFunction showEnhancedWidget(
      {required GitsPopUpBuilder gitsPopUpBuilder,
      UniqueKey? key,
      String? groupKey,
      bool crossPage = true,
      bool allowClick = true,
      bool clickClose = false,
      bool ignoreContentClick = false,
      bool onlyOne = false,
      bool enableKeyboardSafeArea = true,
      BackButtonBehavior? backButtonBehavior,
      FutureFunction? closeFunc,
      VoidCallback? onClose,
      Color backgroundColor = Colors.transparent,
      WrapWidget? warpWidget,
      Duration? duration}) {
    // ignore: unnecessary_null_comparison
    assert(enableKeyboardSafeArea != null);

    late final CancelFunction cancelFunction;
    dismissFunc() async {
      await closeFunc?.call();
      cancelFunction();
    }

    // OnlyOne Function
    final List<CancelFunction> cache =
        (cacheCancelFunction[groupKey ?? defaultKey] ??= []);
    if (onlyOne) {
      final clone = cache.toList();
      cache.clear();
      for (var cancel in clone) {
        cancel();
      }
    }
    cache.add(dismissFunc);

    // Timing function
    Timer? timer;
    if (duration != null) {
      timer = Timer(duration, () {
        dismissFunc();
        timer = null;
      });
    }

    // Automatically close across pages
    GitsPopUpNavigatorObserverProxy? observerProxy;
    if (!crossPage) {
      observerProxy = GitsPopUpNavigatorObserverProxy.all(dismissFunc);
      GitsPopUpNavigatorObserver.register(observerProxy);
    }

    // Intercept click return event
    VoidCallback? unRegisterFunc;
    if (backButtonBehavior == BackButtonBehavior.ignore) {
      unRegisterFunc =
          GitsPopUpWidgetsBindingObserver.singleton.registerPopListener(() {
        return true;
      });
    } else if (backButtonBehavior == BackButtonBehavior.close) {
      unRegisterFunc =
          GitsPopUpWidgetsBindingObserver.singleton.registerPopListener(() {
        dismissFunc();
        unRegisterFunc?.call();
        unRegisterFunc = null;
        return true;
      });
    }

    cancelFunction = showWidget(
        groupKey: groupKey,
        key: key,
        gitsPopUpBuilder: (_) {
          return KeyboardSafeArea(
            enable: enableKeyboardSafeArea,
            child: ProxyDispose(disposeCallback: () {
              cache.remove(dismissFunc);
              if (observerProxy != null) {
                GitsPopUpNavigatorObserver.unregister(observerProxy);
              }
              timer?.cancel();
              onClose?.call();
              unRegisterFunc?.call();
            }, child: Builder(builder: (BuildContext context) {
              final TextStyle textStyle =
                  Theme.of(context).textTheme.bodyMedium!;
              Widget child = DefaultTextStyle(
                  style: textStyle,
                  child: Stack(children: <Widget>[
                    Listener(
                      onPointerDown: clickClose ? (_) => dismissFunc() : null,
                      behavior: allowClick
                          ? HitTestBehavior.translucent
                          : HitTestBehavior.opaque,
                      child: const SizedBox.expand(),
                    ),
                    IgnorePointer(
                      child: Container(color: backgroundColor),
                    ),
                    IgnorePointer(
                      ignoring: ignoreContentClick,
                      child: gitsPopUpBuilder(dismissFunc),
                    )
                  ]));
              return warpWidget != null
                  ? warpWidget(dismissFunc, child)
                  : child;
            })),
          );
        });

    return dismissFunc;
  }

  static CancelFunction showWidget(
      {required GitsPopUpBuilder gitsPopUpBuilder,
      UniqueKey? key,
      String? groupKey}) {
    final gk = groupKey ?? defaultKey;
    final uniqueKey = key ?? UniqueKey();
    cancelFunction() {
      remove(uniqueKey, gk);
    }

    gitsPopUpManager.insert(gk, uniqueKey, gitsPopUpBuilder(cancelFunction));
    return cancelFunction;
  }

  static void remove(UniqueKey key, [String? groupKey]) {
    gitsPopUpManager.remove(groupKey ?? defaultKey, key);
  }

  static void removeAll([String? groupKey]) {
    gitsPopUpManager.removeAll(groupKey ?? defaultKey);
  }

  static void cleanAll() {
    gitsPopUpManager.cleanAll();
  }

  static AnimationController _createAnimationController(Duration duration,
      {Duration? reverseDuration}) {
    return AnimationController(
        vsync: TickerProviderImpl(),
        duration: duration,
        reverseDuration: reverseDuration);
  }

  ///Display a default notification popup
  static CancelFunction showNotif({
    GitsPopUpBuilder? leading,
    required String title,
    String? subtitle,
    GitsPopUpBuilder? trailing,
    WrapAnimation? wrapAnimation,
    WrapAnimation? wrapToastAnimation = notificationAnimation,
    GestureTapCallback? onTap,
    Color? backgroundColor,
    Color? textColor,
    double? borderRadius,
    GestureLongPressCallback? onLongPress,
    Alignment? align = const Alignment(0, -0.99),
    List<DismissDirection> dismissDirections = const [
      DismissDirection.horizontal,
      DismissDirection.up
    ],
    BackButtonBehavior? backButtonBehavior,
    Duration? duration = const Duration(seconds: 2),
    Duration? animationDuration,
    Duration? animationReverseDuration,
    double? contentPadding,
    VoidCallback? onClose,
    bool enableKeyboardSafeArea = true,
    bool enableSlideOff = true,
    bool crossPage = true,
    bool onlyOne = true,
    double? margin,
    double? elevation,
  }) {
    return showCustomNotif(
        wrapAnimation: wrapAnimation,
        wrapToastAnimation: wrapToastAnimation,
        align: align,
        dismissDirections: dismissDirections,
        enableSlideOff: enableSlideOff,
        enableKeyboardSafeArea: enableKeyboardSafeArea,
        onlyOne: onlyOne,
        backButtonBehavior: backButtonBehavior,
        crossPage: crossPage,
        onClose: onClose,
        duration: duration,
        animationDuration: animationDuration,
        animationReverseDuration: animationReverseDuration,
        gitsPopUpBuilder: (cancelFunction) {
          return NotificationCard(
            title: title,
            cancelFunction: cancelFunction,
            leadingWidget: leading?.call(cancelFunction),
            actionWidget: trailing?.call(cancelFunction),
            backgroundColor: backgroundColor,
            borderRadius: borderRadius,
            contentPadding: contentPadding,
            margin: margin,
            elevation: elevation,
            onLongPress: onLongPress,
            onTap: onTap,
            subtitle: subtitle,
            textColor: textColor,
          );
        });
  }

  ///Display a success notification popup
  static CancelFunction showSuccessNotif(
      {GitsPopUpBuilder? leading,
      required String title,
      String? subtitle,
      GitsPopUpBuilder? trailing,
      WrapAnimation? wrapAnimation,
      WrapAnimation? wrapToastAnimation = notificationAnimation,
      GestureTapCallback? onTap,
      Color? backgroundColor,
      Color? textColor,
      double? borderRadius,
      GestureLongPressCallback? onLongPress,
      Alignment? align = const Alignment(0, -0.99),
      List<DismissDirection> dismissDirections = const [
        DismissDirection.horizontal,
        DismissDirection.up
      ],
      BackButtonBehavior? backButtonBehavior,
      Duration? duration = const Duration(seconds: 2),
      Duration? animationDuration,
      Duration? animationReverseDuration,
      double? contentPadding,
      VoidCallback? onClose,
      bool enableKeyboardSafeArea = true,
      bool enableSlideOff = true,
      bool crossPage = true,
      bool onlyOne = true,
      double? margin,
      double? elevation,
      bool showTrailing = true,
      bool showLeading = true}) {
    return showCustomNotif(
        wrapAnimation: wrapAnimation,
        wrapToastAnimation: wrapToastAnimation,
        align: align,
        dismissDirections: dismissDirections,
        enableSlideOff: enableSlideOff,
        enableKeyboardSafeArea: enableKeyboardSafeArea,
        onlyOne: onlyOne,
        backButtonBehavior: backButtonBehavior,
        crossPage: crossPage,
        onClose: onClose,
        duration: duration,
        animationDuration: animationDuration,
        animationReverseDuration: animationReverseDuration,
        gitsPopUpBuilder: (cancelFunction) {
          return NotificationCard(
            title: title,
            cancelFunction: cancelFunction,
            leadingWidget: showLeading
                ? leading?.call(cancelFunction) ??
                    CustomPaint(
                        painter: IconCheckPainter(iconColor: successColorCons),
                        size: const Size(24, 24))
                : null,
            actionWidget: trailing?.call(cancelFunction),
            backgroundColor: successBackgroundColorCons,
            borderRadius: borderRadius,
            contentPadding: contentPadding,
            margin: margin,
            elevation: elevation,
            onLongPress: onLongPress,
            onTap: onTap,
            subtitle: subtitle,
            textColor: successColorCons,
            showAction: showTrailing,
          );
        });
  }

  ///Display a success notification popup
  static CancelFunction showInfoNotif(
      {GitsPopUpBuilder? leading,
      required String title,
      String? subtitle,
      GitsPopUpBuilder? trailing,
      WrapAnimation? wrapAnimation,
      WrapAnimation? wrapToastAnimation = notificationAnimation,
      GestureTapCallback? onTap,
      double? borderRadius,
      GestureLongPressCallback? onLongPress,
      Alignment? align = const Alignment(0, -0.99),
      List<DismissDirection> dismissDirections = const [
        DismissDirection.horizontal,
        DismissDirection.up
      ],
      BackButtonBehavior? backButtonBehavior,
      Duration? duration = const Duration(seconds: 2),
      Duration? animationDuration,
      Duration? animationReverseDuration,
      double? contentPadding,
      VoidCallback? onClose,
      bool enableKeyboardSafeArea = true,
      bool enableSlideOff = true,
      bool crossPage = true,
      bool onlyOne = true,
      double? margin,
      double? elevation,
      bool showTrailing = true,
      bool showLeading = true}) {
    return showCustomNotif(
        wrapAnimation: wrapAnimation,
        wrapToastAnimation: wrapToastAnimation,
        align: align,
        dismissDirections: dismissDirections,
        enableSlideOff: enableSlideOff,
        enableKeyboardSafeArea: enableKeyboardSafeArea,
        onlyOne: onlyOne,
        backButtonBehavior: backButtonBehavior,
        crossPage: crossPage,
        onClose: onClose,
        duration: duration,
        animationDuration: animationDuration,
        animationReverseDuration: animationReverseDuration,
        gitsPopUpBuilder: (cancelFunction) {
          return NotificationCard(
            title: title,
            cancelFunction: cancelFunction,
            leadingWidget: showLeading
                ? leading?.call(cancelFunction) ??
                    CustomPaint(
                        painter: IconInfoPainter(iconColor: infoColorCons),
                        size: const Size(24, 24))
                : null,
            actionWidget: trailing?.call(cancelFunction),
            backgroundColor: infoBackgroundColorCons,
            borderRadius: borderRadius,
            contentPadding: contentPadding,
            margin: margin,
            elevation: elevation,
            onLongPress: onLongPress,
            onTap: onTap,
            subtitle: subtitle,
            textColor: infoColorCons,
            showAction: showTrailing,
          );
        });
  }

  ///Display a success notification popup
  static CancelFunction showWarningNotif(
      {GitsPopUpBuilder? leading,
      required String title,
      String? subtitle,
      GitsPopUpBuilder? trailing,
      WrapAnimation? wrapAnimation,
      WrapAnimation? wrapToastAnimation = notificationAnimation,
      GestureTapCallback? onTap,
      double? borderRadius,
      GestureLongPressCallback? onLongPress,
      Alignment? align = const Alignment(0, -0.99),
      List<DismissDirection> dismissDirections = const [
        DismissDirection.horizontal,
        DismissDirection.up
      ],
      BackButtonBehavior? backButtonBehavior,
      Duration? duration = const Duration(seconds: 2),
      Duration? animationDuration,
      Duration? animationReverseDuration,
      double? contentPadding,
      VoidCallback? onClose,
      bool enableKeyboardSafeArea = true,
      bool enableSlideOff = true,
      bool crossPage = true,
      bool onlyOne = true,
      double? margin,
      double? elevation,
      bool showTrailing = true,
      bool showLeading = true}) {
    return showCustomNotif(
        wrapAnimation: wrapAnimation,
        wrapToastAnimation: wrapToastAnimation,
        align: align,
        dismissDirections: dismissDirections,
        enableSlideOff: enableSlideOff,
        enableKeyboardSafeArea: enableKeyboardSafeArea,
        onlyOne: onlyOne,
        backButtonBehavior: backButtonBehavior,
        crossPage: crossPage,
        onClose: onClose,
        duration: duration,
        animationDuration: animationDuration,
        animationReverseDuration: animationReverseDuration,
        gitsPopUpBuilder: (cancelFunction) {
          return NotificationCard(
            title: title,
            cancelFunction: cancelFunction,
            leadingWidget: showLeading
                ? leading?.call(cancelFunction) ??
                    CustomPaint(
                        painter: IconInfoPainter(iconColor: warningColorCons),
                        size: const Size(24, 24))
                : null,
            actionWidget: trailing?.call(cancelFunction),
            backgroundColor: warningBackgroundColorCons,
            borderRadius: borderRadius,
            contentPadding: contentPadding,
            margin: margin,
            elevation: elevation,
            onLongPress: onLongPress,
            onTap: onTap,
            subtitle: subtitle,
            textColor: warningColorCons,
            showAction: showTrailing,
          );
        });
  }

  ///Display a success notification popup
  static CancelFunction showDangerNotif(
      {GitsPopUpBuilder? leading,
      required String title,
      String? subtitle,
      GitsPopUpBuilder? trailing,
      WrapAnimation? wrapAnimation,
      WrapAnimation? wrapToastAnimation = notificationAnimation,
      GestureTapCallback? onTap,
      double? borderRadius,
      GestureLongPressCallback? onLongPress,
      Alignment? align = const Alignment(0, -0.99),
      List<DismissDirection> dismissDirections = const [
        DismissDirection.horizontal,
        DismissDirection.up
      ],
      BackButtonBehavior? backButtonBehavior,
      Duration? duration = const Duration(seconds: 2),
      Duration? animationDuration,
      Duration? animationReverseDuration,
      double? contentPadding,
      VoidCallback? onClose,
      bool enableKeyboardSafeArea = true,
      bool enableSlideOff = true,
      bool crossPage = true,
      bool onlyOne = true,
      double? margin,
      double? elevation,
      bool showTrailing = true,
      bool showLeading = true}) {
    return showCustomNotif(
        wrapAnimation: wrapAnimation,
        wrapToastAnimation: wrapToastAnimation,
        align: align,
        dismissDirections: dismissDirections,
        enableSlideOff: enableSlideOff,
        enableKeyboardSafeArea: enableKeyboardSafeArea,
        onlyOne: onlyOne,
        backButtonBehavior: backButtonBehavior,
        crossPage: crossPage,
        onClose: onClose,
        duration: duration,
        animationDuration: animationDuration,
        animationReverseDuration: animationReverseDuration,
        gitsPopUpBuilder: (cancelFunction) {
          return NotificationCard(
            title: title,
            cancelFunction: cancelFunction,
            leadingWidget: showLeading
                ? leading?.call(cancelFunction) ??
                    CustomPaint(
                        painter: IconInfoPainter(iconColor: dangerColorCons),
                        size: const Size(24, 24))
                : null,
            actionWidget: trailing?.call(cancelFunction),
            backgroundColor: dangerBackgroundColorCons,
            borderRadius: borderRadius,
            contentPadding: contentPadding,
            margin: margin,
            elevation: elevation,
            onLongPress: onLongPress,
            onTap: onTap,
            subtitle: subtitle,
            textColor: dangerColorCons,
            showAction: showTrailing,
          );
        });
  }

  ///Display a custom loading popup
  static CancelFunction showCustomLoading(
      {required GitsPopUpBuilder gitsPopUpBuilder,
      WrapAnimation? wrapAnimation = loadingAnimation,
      WrapAnimation? wrapToastAnimation,
      Alignment? align = Alignment.center,
      BackButtonBehavior? backButtonBehavior,
      bool clickClose = false,
      bool allowClick = false,
      bool ignoreContentClick = false,
      bool crossPage = false,
      bool enableKeyboardSafeArea = true,
      VoidCallback? onClose,
      Duration? duration,
      Duration? animationDuration,
      Duration? animationReverseDuration,
      Color backgroundColor = Colors.black26,
      bool useSafeArea = true}) {
    return showAnimationWidget(
        groupKey: loadKey,
        enableKeyboardSafeArea: enableKeyboardSafeArea,
        gitsPopUpBuilder: gitsPopUpBuilder,
        backButtonBehavior: backButtonBehavior,
        animationDuration:
            animationDuration ?? const Duration(milliseconds: 300),
        animationReverseDuration: animationReverseDuration,
        wrapAnimation: wrapAnimation,
        wrapToastAnimation: (controller, cancel, child) {
          if (wrapToastAnimation != null) {
            child = wrapToastAnimation(controller, cancel, child);
          }
          if (align != null) {
            child = Align(alignment: align, child: child);
          }
          return useSafeArea ? SafeArea(child: child) : child;
        },
        onClose: onClose,
        clickClose: clickClose,
        allowClick: allowClick,
        crossPage: crossPage,
        ignoreContentClick: ignoreContentClick,
        onlyOne: false,
        duration: duration,
        backgroundColor: backgroundColor);
  }

  ///Display a standard loading popup
  static CancelFunction showLoading(
      {WrapAnimation? wrapAnimation = loadingAnimation,
      WrapAnimation? wrapToastAnimation,
      Alignment align = Alignment.center,
      BackButtonBehavior? backButtonBehavior,
      bool crossPage = true,
      bool clickClose = false,
      bool allowClick = false,
      bool enableKeyboardSafeArea = true,
      VoidCallback? onClose,
      Duration? duration,
      Duration? animationDuration,
      Duration? animationReverseDuration,
      Color backgroundColor = Colors.black26,
      String? message}) {
    return showCustomLoading(
        wrapAnimation: wrapAnimation,
        wrapToastAnimation: wrapToastAnimation,
        align: align,
        enableKeyboardSafeArea: enableKeyboardSafeArea,
        backButtonBehavior: backButtonBehavior,
        gitsPopUpBuilder: (_) => LoadingWidget(loadingTitle: message),
        clickClose: clickClose,
        allowClick: allowClick,
        crossPage: crossPage,
        ignoreContentClick: true,
        onClose: onClose,
        duration: duration,
        animationDuration: animationDuration,
        animationReverseDuration: animationReverseDuration,
        backgroundColor: backgroundColor);
  }

  static void hideLoading() {
    gitsPopUpManager.cleanAll();
  }

  ///Display a standard text popup
  static CancelFunction showText(
      {required String text,
      WrapAnimation? wrapAnimation,
      WrapAnimation? wrapToastAnimation = textAnimation,
      Color backgroundColor = Colors.transparent,
      Color contentColor = Colors.black54,
      BorderRadiusGeometry borderRadius =
          const BorderRadius.all(Radius.circular(8)),
      TextStyle textStyle = const TextStyle(fontSize: 17, color: Colors.white),
      AlignmentGeometry? align = const Alignment(0, 0.8),
      EdgeInsetsGeometry contentPadding =
          const EdgeInsets.only(left: 14, right: 14, top: 5, bottom: 7),
      Duration? duration = const Duration(seconds: 2),
      Duration? animationDuration,
      Duration? animationReverseDuration,
      BackButtonBehavior? backButtonBehavior,
      VoidCallback? onClose,
      bool enableKeyboardSafeArea = true,
      bool clickClose = false,
      bool crossPage = true,
      bool onlyOne = true}) {
    return showCustomText(
        wrapAnimation: wrapAnimation,
        wrapToastAnimation: wrapToastAnimation,
        duration: duration,
        animationDuration: animationDuration,
        animationReverseDuration: animationReverseDuration,
        crossPage: crossPage,
        backgroundColor: backgroundColor,
        clickClose: clickClose,
        backButtonBehavior: backButtonBehavior,
        onClose: onClose,
        enableKeyboardSafeArea: enableKeyboardSafeArea,
        ignoreContentClick: true,
        onlyOne: onlyOne,
        align: align,
        gitsPopUpBuilder: (_) => TextToast(
              contentPadding: contentPadding,
              contentColor: contentColor,
              borderRadius: borderRadius,
              textStyle: textStyle,
              text: text,
            ));
  }

  ///Display a custom text popup
  static CancelFunction showCustomText(
      {required GitsPopUpBuilder gitsPopUpBuilder,
      WrapAnimation? wrapAnimation,
      WrapAnimation? wrapToastAnimation = textAnimation,
      AlignmentGeometry? align = const Alignment(0, 0.8),
      Color backgroundColor = Colors.transparent,
      Duration? duration = const Duration(seconds: 2),
      Duration? animationDuration,
      Duration? animationReverseDuration,
      VoidCallback? onClose,
      BackButtonBehavior? backButtonBehavior,
      bool enableKeyboardSafeArea = true,
      bool crossPage = true,
      bool clickClose = false,
      bool ignoreContentClick = false,
      bool onlyOne = false,
      bool useSafeArea = true}) {
    return showAnimationWidget(
        groupKey: textKey,
        clickClose: clickClose,
        allowClick: true,
        enableKeyboardSafeArea: enableKeyboardSafeArea,
        onlyOne: onlyOne,
        crossPage: crossPage,
        ignoreContentClick: ignoreContentClick,
        backgroundColor: backgroundColor,
        backButtonBehavior: backButtonBehavior,
        onClose: onClose,
        duration: duration,
        animationDuration:
            animationDuration ?? const Duration(milliseconds: 256),
        animationReverseDuration: animationReverseDuration,
        wrapAnimation: wrapAnimation,
        wrapToastAnimation: (controller, cancel, child) {
          if (wrapToastAnimation != null) {
            child = wrapToastAnimation(controller, cancel, child);
          }
          if (align != null) {
            child = Align(alignment: align, child: child);
          }
          return useSafeArea ? SafeArea(child: child) : child;
        },
        gitsPopUpBuilder: gitsPopUpBuilder);
  }
}
