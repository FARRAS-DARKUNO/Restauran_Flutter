import 'package:flutter/material.dart';
import 'package:restauran_app_revisi/api/get_search_detail.dart';
import 'package:restauran_app_revisi/componen/haveSeacrh.dart';
import 'package:restauran_app_revisi/componen/no_internet.dart';
import 'package:provider/provider.dart';
import 'package:restauran_app_revisi/provider/connnectivity_provider.dart';

class Search extends StatefulWidget {
  final String seacrhingfile;
  Search({required this.seacrhingfile});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  RestauranSearch api = RestauranSearch();
  @override
  Widget build(BuildContext context) {
    return pageUI();
  }

  Widget pageUI() {
    return Consumer<ConnectivityProvider>(builder: (context, modal, child) {
      if (modal.isOnline != null) {
        return modal.isOnline
            ? FutureBuilder(
                future: api.getSeacrh(widget.seacrhingfile),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return HaveSeach(
                      snapshot.data.error,
                      snapshot.data.founded,
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
