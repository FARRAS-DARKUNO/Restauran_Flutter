import 'package:http/http.dart';

import 'api.dart';
import 'dart:convert';

import '../model/home_detail_data/homedata.dart';

class HomeDetail {
  final Api? api = Api();

  Future<HomeData> getHomeDetailData() async {
    final url = 'https://restaurant-api.dicoding.dev/list';

    final response = await api!.get(url);
    var jsonRespnse = jsonDecode(response);

    final homeDetail = HomeData.fromJson(jsonRespnse);
    return homeDetail;
  }
}
