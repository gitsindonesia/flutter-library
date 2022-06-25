import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Instance class for local notification functionality.
class LocalNotification {
  /// Wrap the package [FlutterLocalNotificationsPlugin].
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  /// Specifies the icon for notifications.
  final String notificationIcon;

  /// Function for handle if notification selected.
  final Function(String?) onSelectedNotification;

  LocalNotification({
    required this.notificationIcon,
    required this.onSelectedNotification,
  }) {
    _initializeNotificationsPlugin();
  }

  /// Initialize provides cross-platform functionality for displaying local notifications.
  void _initializeNotificationsPlugin() {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final initializationSettingsAndroid =
        AndroidInitializationSettings(notificationIcon);
    const initializationSettingsIOS = IOSInitializationSettings();

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectedNotification,
    );
  }

  /// Function for show local notification with given [message]
  Future<void> showLocalNotification(String message) async {
    const channelId = 'Gits Inspector';
    const channelName = 'Gits Inspector';
    const channelDescription = 'Gits Inspector';
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      enableVibration: false,
      playSound: false,
      styleInformation: BigTextStyleInformation(message),
    );
    const iOSPlatformChannelSpecifics =
        IOSNotificationDetails(presentSound: false);
    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await _flutterLocalNotificationsPlugin.show(
      0,
      'Gits Inspector',
      message,
      platformChannelSpecifics,
    );
  }
}
