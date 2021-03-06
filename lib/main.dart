import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restauran_app_revisi/api/get_home_detail.dart';
import 'package:restauran_app_revisi/api/get_search_detail.dart';
import 'package:restauran_app_revisi/data/database_helper.dart';
import 'package:restauran_app_revisi/navigator/navigator.dart';
import 'package:restauran_app_revisi/provider/database_provider.dart';
import 'package:restauran_app_revisi/provider/list_provider.dart';
import 'package:restauran_app_revisi/provider/search_provider.dart';
import 'package:provider/provider.dart';
import 'package:restauran_app_revisi/provider/setting_provider.dart';
import 'package:restauran_app_revisi/utils/backround_service.dart';
import 'package:restauran_app_revisi/utils/notification_helper.dart';
import 'provider/check_data_provider.dart';
import 'provider/detail_page_provider.dart';
import 'provider/connnectivity_provider.dart';

final flutterPlugin = FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _notificationHelper = NotificationHelper();
  final _service = BackgroundService();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CheckDataProvider()),
        ChangeNotifierProvider(create: (_) => DetailPageProvider()),
        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
        ChangeNotifierProvider(
            create: (_) => RestaurantProvider(apiService: HomeDetail())),
        ChangeNotifierProvider(
            create: (_) => SearchProvider(apiService: RestauranSearch())),
        ChangeNotifierProvider(
            create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper())),
        ChangeNotifierProvider<SettingProvider>(
            create: (_) => SettingProvider()),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyStatefulWidget()),
    );
  }
}
