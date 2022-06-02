import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  final String notificationIcon;
  final Function(String?) onSelectedNotification;

  LocalNotification({
    required this.notificationIcon,
    required this.onSelectedNotification,
  }) {
    _initializeNotificationsPlugin();
  }

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
