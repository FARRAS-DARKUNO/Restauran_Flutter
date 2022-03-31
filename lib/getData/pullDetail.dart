import 'package:flutter/material.dart';
import 'package:restauran_app_revisi/api/get_restaurant_detail.dart';
import 'package:provider/provider.dart';
import 'package:restauran_app_revisi/provider/detailPageProvider.dart';
import 'package:restauran_app_revisi/api/api.dart';
import 'package:restauran_app_revisi/screen/detail.dart';
import 'package:provider/provider.dart';
import 'package:restauran_app_revisi/provider/detailPageProvider.dart';

class DetailMenu extends StatefulWidget {
  @override
  State<DetailMenu> createState() => _DetailMenuState();
}

class _DetailMenuState extends State<DetailMenu> {
  /// bungkus provider
  RestaurantDetail api = RestaurantDetail();

  @override
  Widget build(BuildContext context) {
    var detail = Provider.of<DetailPageProvider>(context);
    return FutureBuilder(
      future: api.getRestaurantDetail(detail.checking),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return DetailPages(
              snapshot.data.id,
              snapshot.data.name,
              snapshot.data.description,
              snapshot.data.city,
              snapshot.data.pictureId,
              snapshot.data.menus);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
