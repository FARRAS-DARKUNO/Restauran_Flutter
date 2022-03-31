import 'package:flutter/material.dart';
import 'package:restauran_app_revisi/api/get_home_detail.dart';
import 'package:restauran_app_revisi/api/api.dart';
import 'package:restauran_app_revisi/screen/home.dart';
import 'package:restauran_app_revisi/componen/haveData.dart';
import 'package:restauran_app_revisi/componen/no_internet.dart';
import 'package:provider/provider.dart';
import 'package:restauran_app_revisi/provider/connnectivity_provider.dart';

class PullHome extends StatefulWidget {
  @override
  State<PullHome> createState() => _PullHomeState();
}

class _PullHomeState extends State<PullHome> {
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  HomeDetail api = HomeDetail();

  @override
  Widget build(BuildContext context) {
    return pageUI();
  }

  Widget pageUI() {
    return Consumer<ConnectivityProvider>(builder: (context, modal, child) {
      if (modal.isOnline != null) {
        return modal.isOnline
            ? FutureBuilder(
                future: api.getHomeDetailData(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return HaveData(
                      snapshot.data.error,
                      snapshot.data.count,
                      snapshot.data.restaurants,
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
            : NoInternet();
      }
      return Container(
        child: Center(child: CircularProgressIndicator()),
      );
    });
  }
}
