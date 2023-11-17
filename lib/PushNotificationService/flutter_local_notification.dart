import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hexcolor/hexcolor.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_notification');
    var initializationSettings = const InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ));
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        handleForeroundMessages(details);
      },
    );
  }

  Future<void> handleForeroundMessages(NotificationResponse message) async {}

  Future<void> showNotification(
      String title, String body, Map<String, dynamic>? payload) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: "channel_description",
      importance: Importance.max,
      priority: Priority.high,
      color: HexColor('#40a8c4'),
      colorized: true,
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: const DarwinNotificationDetails(),
    );

    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: payload?.toString(),
    );
  }
}
