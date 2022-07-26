import 'dart:isolate';
import 'dart:math';

import 'dart:ui';

import 'package:restauran_app_revisi/api/get_home_detail.dart';
import 'package:restauran_app_revisi/main.dart';
import 'package:restauran_app_revisi/utils/notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _service;
  static String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _service = this;
  }

  factory BackgroundService() => _service ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    final NotificationHelper _helper = NotificationHelper();

    var randomizer = Random().nextInt(20);
    var results = await HomeDetail().getHomeDetailData();
    var data = results.restaurants[randomizer];

    await _helper.showNotification(
      flutterPlugin,
      data,
    );

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
