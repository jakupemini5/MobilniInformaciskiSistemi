import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Timer? _timer;

  Future<void> initialize() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

      _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    NotificationSettings settings =
        await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User denied permission');
    }

    // Retrieve the FCM token
    String? token = await _firebaseMessaging.getToken();
    if (token != null) {
      print('FCM Token: $token');
      // Save or send the token to your backend
    } else {
      print('Failed to retrieve FCM token');
    }
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

  void showNotification(RemoteMessage message, String title, String body) {
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
      title,
      body,
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
