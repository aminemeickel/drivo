// ignore_for_file: constant_identifier_names

import 'dart:io';
import 'dart:math';

import 'package:drivo/core/log.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHandler {
  static const _CHANNEL_ID = 'drivo_channel_id';
  static const _CHANNEL_NAME = 'dirvo';
  static const _CHANNEL_DESCRIPTION = 'notification for Drivo app';
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  void _requestPermissions() async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> showNotification(String title, String body) async {
    await _init();

    if (Platform.isIOS) {
      _requestPermissions();
    }

    await _flutterLocalNotificationsPlugin.show(
        Random.secure().nextInt(600),
        title,
        body,
        const NotificationDetails(
            iOS: IOSNotificationDetails(),
            android: AndroidNotificationDetails(_CHANNEL_ID, _CHANNEL_NAME,
                importance: Importance.high,
                priority: Priority.high,
                channelDescription: _CHANNEL_DESCRIPTION)),
        payload: 'payload');
  }

  Future<void> _init() async {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    const initializationSettingsIOS = IOSInitializationSettings();
    InitializationSettings initializationSettings =
        const InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    var initDone = await _flutterLocalNotificationsPlugin
        .initialize(initializationSettings);
    Log.verbose(initDone);
  }

  Future<void> initFirebaseMessaging() async {
    Log.verbose('SHOW NOTIFICATION');
    bool showNotificationIsAlowed = true;
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    if (Platform.isIOS) {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      Log.verbose('Settings ${settings.authorizationStatus}');
      showNotificationIsAlowed =
          settings.authorizationStatus == AuthorizationStatus.authorized;
    }
    if (showNotificationIsAlowed) {
      FirebaseMessaging.onMessage.listen((event) async {
        await showNotification(
            event.notification?.title ?? '', event.notification?.body ?? '');
      });
    }
  }
}
