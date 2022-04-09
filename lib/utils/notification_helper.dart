import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restauran_app_revisi/model/home_detail_data/home_restoran.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
    FlutterLocalNotificationsPlugin flutterPlugin,
  ) async {
    var initSettingAndroid = const AndroidInitializationSettings('app_icon');
    var initSettingIOS = const IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initSettings = InitializationSettings(
      android: initSettingAndroid,
      iOS: initSettingIOS,
    );

    await flutterPlugin.initialize(
      initSettings,
      onSelectNotification: (payload) async {
        selectNotificationSubject.add(payload ?? 'empty payload');
      },
    );
  }

  Future<void> showNotification(
    FlutterLocalNotificationsPlugin flutterPlugin,
    Restaurant restaurant,
  ) async {
    var _channelId = "1";
    var _channelName = "channel_01";
    var _channelDescription = "restaurant app channel";

    var androidChannel = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: DefaultStyleInformation(true, true),
    );

    var iosChannel = IOSNotificationDetails();

    var platformsChannel = NotificationDetails(
      android: androidChannel,
      iOS: iosChannel,
    );

    var titleNotification = "Go Nakam";
    var titleNews = restaurant.name;

    await flutterPlugin.show(
      0,
      titleNotification,
      titleNews,
      platformsChannel,
      payload: json.encode(restaurant.toJson()),
    );
  }
}
