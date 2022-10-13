import 'package:flutter/material.dart';

class GitsPopUpNavigatorObserverProxy {
  void Function(Route<dynamic> route, Route<dynamic>? previousRoute)? didPush;
  void Function(Route<dynamic>? newRoute, Route<dynamic>? oldRoute)? didReplace;
  void Function(Route<dynamic> route, Route<dynamic>? previousRoute)? didRemove;
  void Function(Route<dynamic> route, Route<dynamic>? previousRoute)? didPop;

  GitsPopUpNavigatorObserverProxy(
      {this.didPush, this.didReplace, this.didRemove, this.didPop});

  GitsPopUpNavigatorObserverProxy.all(VoidCallback leavePageCallback) {
    didPush = (_, __) => leavePageCallback();
    didReplace = (_, __) => leavePageCallback();
    didRemove = (_, __) => leavePageCallback();
    didPop = (_, __) => leavePageCallback();
  }
}

/// If your project has multiple [Navigators], add GitsPopUpNavigatorObserver to [Navigator.observers]
class GitsPopUpNavigatorObserver extends NavigatorObserver {
  static final List<GitsPopUpNavigatorObserverProxy> _leavePageCallbacks = [];

  static bool debugInitialization = false;

  GitsPopUpNavigatorObserver() {
    assert(() {
      debugInitialization = true;
      return true;
    }());
  }

  static void register(
      GitsPopUpNavigatorObserverProxy gitsPopUpNavigatorObserverProxy) {
    assert(debugInitialization, """
    Please initialize!
    Example:
    GitsPopUpInit(
      child:MaterialApp(
      title: 'Xxxx Demo',
      navigatorObservers: [GitsPopUpNavigatorObserver()],
      home: XxxxPage(),
    ));
    """);
    _leavePageCallbacks.add(gitsPopUpNavigatorObserverProxy);
  }

  static void unregister(
      GitsPopUpNavigatorObserverProxy gitsPopUpNavigatorObserverProxy) {
    _leavePageCallbacks.remove(gitsPopUpNavigatorObserverProxy);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final copy = _leavePageCallbacks.toList(growable: false);
    for (GitsPopUpNavigatorObserverProxy observerProxy in copy) {
      observerProxy.didPush?.call(route, previousRoute);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    final copy = _leavePageCallbacks.toList(growable: false);
    for (GitsPopUpNavigatorObserverProxy observerProxy in copy) {
      observerProxy.didReplace?.call(newRoute, oldRoute);
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final copy = _leavePageCallbacks.toList(growable: false);
    for (GitsPopUpNavigatorObserverProxy observerProxy in copy) {
      observerProxy.didRemove?.call(route, previousRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final copy = _leavePageCallbacks.toList(growable: false);
    for (GitsPopUpNavigatorObserverProxy observerProxy in copy) {
      observerProxy.didPop?.call(route, previousRoute);
    }
  }
}
