import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Timer? _timer;

  void initialize() {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

      _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showTestNotification() {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'test_channel', // Channel ID
      'Test Notifications', // Channel Name
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    _flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      'Test Notification', // Title
      'This is a test notification.', // Body
      notificationDetails,
    );
  }

  void showNotification(RemoteMessage message) {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'joke_channel',
      'Daily Jokes',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    _flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      notificationDetails,
    );
  }

  void scheduleTestNotifications() {
    _timer?.cancel(); // Cancel any existing timers
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      showTestNotification();
    });
  }
}
