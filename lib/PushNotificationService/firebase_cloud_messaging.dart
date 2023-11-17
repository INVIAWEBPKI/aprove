import 'package:contadores_invia/Database/database_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'flutter_local_notification.dart';

@pragma('vm:entry-point')
Future<void> showForegroundNotification(
    String title, String body, Map<String, dynamic> payload) async {
  final NotificationService notificationService = NotificationService();
  await notificationService.init();
  await notificationService.showNotification(title, body, payload);
}

@pragma('vm:entry-point')
Future<void> handleBackgroundMessages(RemoteMessage message) async {
  DatabaseHelper.saveNotification(message.data['body'], message.data['title'],
      message.data['link'], message.data['screen'], message.data['titulo']);
  showForegroundNotification(
      message.data['title'], message.data['body'], message.data);
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final NotificationService _notificationService = NotificationService();
  bool notificationTapped = false;

  Future<void> initNotifications() async {
    try {
      await _firebaseMessaging.subscribeToTopic("sandbox");
      NotificationSettings settings =
          await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      if (kDebugMode) {
        print('User granted permission: ${settings.authorizationStatus}');
      }

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        debugPrint(notificationTapped.toString());
        if (kDebugMode) {
          print('Received foreground message: ${message.data["title"]}');
        }
        DatabaseHelper.saveNotification(
            message.data['body'],
            message.data['title'],
            message.data['link'],
            message.data['screen'],
            message.data['titulo']);
        _showForegroundNotification(
            message.data['title'], message.data['body'], message.data);
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        handleBackgroundMessages(message);
      });

      _retrieveInitialMessage();

      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessages);

      final fCMToken = await _firebaseMessaging.getToken();
      if (kDebugMode) {
        print("Token: $fCMToken");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> _retrieveInitialMessage() async {}

  Future<void> _showForegroundNotification(
      String title, String body, Map<String, dynamic> payload) async {
    await _notificationService.init();
    await _notificationService.showNotification(title, body, payload);
  }
}
