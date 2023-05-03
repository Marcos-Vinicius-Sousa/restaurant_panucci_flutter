import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:panucci_ristorante/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class CustomLocalNotification {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  late AndroidNotificationChannel channel;

  CustomLocalNotification() {
    channel = const AndroidNotificationChannel(
        'high_importance_channel', 'High Importance Notifications',
        description: 'This channel is used for important notifications',
        importance: Importance.max);

    _configurarAndroid().then((value) {
      flutterLocalNotificationsPlugin = value;
      inicializeNotifications();
    });
  }

  Future<FlutterLocalNotificationsPlugin> _configurarAndroid() async {
    var fluttterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    return fluttterLocalNotificationsPlugin;
  }

  inicializeNotifications() {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    final iOs = IOSInitializationSettings(
      onDidReceiveLocalNotification: (_, __, ___, _____) {},
    );

    flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(android: android, iOS: iOs),
    );
  }

  androidNotification(
      RemoteNotification notification, AndroidNotification android) {
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description,
                icon: android.smallIcon)));
  }
}
