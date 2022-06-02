import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gits_inspector/gits_inspector.dart';
import 'package:gits_inspector/src/extensions/date_time_extensions.dart';
import 'package:gits_inspector/src/helper/local_notification.dart';
import 'package:gits_inspector/src/helper/shake_detector.dart';
import 'package:gits_inspector/src/pages/gits_inspector_page.dart';

class GitsInspector {
  final bool showInspectorOnShake;
  final bool showNotification;
  final bool saveInspectorToLocal;
  final String notificationIcon;

  bool _inspectorOpened = false;
  ShakeDetector? _shakeDetector;
  LocalNotification? _localNotification;
  NavigatorState? _navigatorState;

  GitsInspector({
    this.showInspectorOnShake = true,
    this.showNotification = true,
    this.saveInspectorToLocal = true,
    this.notificationIcon = '@mipmap/ic_launcher',
  }) {
    if (showNotification && saveInspectorToLocal) {
      _localNotification = LocalNotification(
        notificationIcon: notificationIcon,
        onSelectedNotification: (payload) => navigateToInspectorPage(),
      );
    }
    if (showInspectorOnShake && saveInspectorToLocal) {
      _shakeDetector = ShakeDetector.autoStart(
        onPhoneShake: navigateToInspectorPage,
      );
    }
  }

  void setNavigatorState(NavigatorState navigatorState) =>
      _navigatorState = navigatorState;

  void navigateToInspectorPage() async {
    if (_inspectorOpened) return;
    if (_navigatorState == null) {
      if (kDebugMode) {
        print(
            'Cant start Gits Inspector. Please add context with parent NavigatorState to your application');
      }
      return;
    }

    _inspectorOpened = true;
    await _navigatorState?.push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const GitsInspectorPage(),
      ),
    );
    _inspectorOpened = false;
  }

  Future<void> inspectorRequest(Inspector inspector) async {
    if (!saveInspectorToLocal) return;
    await InspectorService.insert(inspector);
    await showLocalNotification();
  }

  Future<void> inspectorResponse(
    String uuid,
    ResponseInspector response,
  ) async {
    if (!saveInspectorToLocal) return;
    await InspectorService.updateResponse(uuid, response);
    await showLocalNotification();
  }

  Future<void> inspectorResponseTimeout(String uuid) async {
    if (!saveInspectorToLocal) return;
    await InspectorService.updateResponse(
        uuid, ResponseInspector(isTimeout: true));
    await showLocalNotification();
  }

  Future<void> showLocalNotification() async {
    if (!showNotification || !saveInspectorToLocal) return;
    final inspectors = await InspectorService.getAll(limit: 7);
    String message = '';
    for (var element in inspectors) {
      final statusIfTimeout =
          element.response?.isTimeout ?? false ? '! ! !' : '. . .';
      final statusCode = element.response?.status ?? statusIfTimeout;
      final time = element.createdAt.toHHMMSS();
      message += '$time - $statusCode ${element.request.url.path}\n';
    }
    message += '. . .';
    _localNotification?.showLocalNotification(message);
  }

  void onClose() {
    _shakeDetector?.stopListening();
  }
}
