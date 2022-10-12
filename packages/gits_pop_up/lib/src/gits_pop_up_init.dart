import 'package:flutter/material.dart';

import 'gits_pop_up_cons.dart';
import 'gits_pop_up_manager.dart';

final GlobalKey<GitsPopUpSettingsState> key =
    GlobalKey<GitsPopUpSettingsState>();

GitsPopUpSettingsState get gitsPopUpManager {
  assert(key.currentState != null);
  return key.currentState!;
}

class GitsPopUpWidgetsBindingObserver with WidgetsBindingObserver {
  GitsPopUpWidgetsBindingObserver._() : _listener = <PopTestFunction>[] {
    (WidgetsBinding.instance as dynamic).addObserver(this);
  }

  final List<PopTestFunction> _listener;

  static final GitsPopUpWidgetsBindingObserver singletonBinding =
      GitsPopUpWidgetsBindingObserver._();

  static GitsPopUpWidgetsBindingObserver get singleton => singletonBinding;

  VoidCallback registerPopListener(PopTestFunction popTestFunction) {
    _listener.add(popTestFunction);
    return () {
      _listener.remove(popTestFunction);
    };
  }

  @override
  Future<bool> didPopRoute() async {
    if (_listener.isNotEmpty) {
      final clone = _listener.reversed.toList(growable: false);
      for (PopTestFunction popTest in clone) {
        if (popTest()) return true;
      }
    }
    return super.didPopRoute();
  }
}

GitsPopUpSettings gitsPopUpInit(BuildContext context, Widget? child) {
  GitsPopUpWidgetsBindingObserver.singletonBinding;
  return GitsPopUpSettings(key: key, child: child!);
}
