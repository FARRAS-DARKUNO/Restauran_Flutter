import 'package:flutter/material.dart';
import 'package:restauran_app_revisi/api/get_home_detail.dart';
import 'package:restauran_app_revisi/api/get_search_detail.dart';
import 'package:restauran_app_revisi/provider/list_provider.dart';
import 'package:restauran_app_revisi/provider/search_provider.dart';
import 'package:restauran_app_revisi/screen/home.dart';
import 'package:provider/provider.dart';
import 'provider/checkDataProvider.dart';
import 'provider/detailPageProvider.dart';
import 'provider/connnectivity_provider.dart';

void main() {
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
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Home()),
    );
  }
}
