import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restauran_app_revisi/componen/no_internet.dart';
import 'package:restauran_app_revisi/provider/list_provider.dart';
import 'package:restauran_app_revisi/screen/detail.dart';
import '../model/home_detail_data/homerestoran.dart';
import 'package:restauran_app_revisi/provider/detailPageProvider.dart';
import 'package:provider/provider.dart';

class HaveData extends StatefulWidget {
  const HaveData({Key? key}) : super(key: key);

  @override
  State<HaveData> createState() => _HaveDataState();
}

class _HaveDataState extends State<HaveData> {
  @override
  Widget build(BuildContext context) {
    var detail = Provider.of<DetailPageProvider>(context);

    return Consumer<RestaurantProvider>(builder: (context, value, _) {
      if (value.state == ResultState.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (value.state == ResultState.noData) {
        return Center(child: Text(value.message));
      } else if (value.state == ResultState.hasData) {
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: value.result.count,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                detail.checking = value.result.restaurants[index].id;

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DetailPages()));
              },
              child: Card(
                color: Color.fromARGB(255, 220, 237, 252),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10),
                      width: 100,
                      height: 100,
                      child: Image.network(
                          'https://restaurant-api.dicoding.dev/images/medium/${value.result.restaurants[index].pictureId}'),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            value.result.restaurants[index].name,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'lokasi : ' + value.result.restaurants[index].city,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      } else if (value.state == ResultState.error) {
        return NoInternet();
      } else {
        return const Text("");
      }
    });
  }
}
