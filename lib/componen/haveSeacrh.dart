import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/Searching/searching.dart';
import 'package:restauran_app_revisi/provider/detailPageProvider.dart';
import 'package:provider/provider.dart';
import 'package:restauran_app_revisi/getData/pullDetail.dart';

class HaveSeach extends StatefulWidget {
  final bool error;
  final int founded;
  final List<Searching> restaurants;

  const HaveSeach(this.error, this.founded, this.restaurants, {Key? key})
      : super(key: key);

  @override
  State<HaveSeach> createState() => _HaveSeachState();
}

class _HaveSeachState extends State<HaveSeach> {
  @override
  Widget build(BuildContext context) {
    var detail = Provider.of<DetailPageProvider>(context);

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: this.widget.restaurants.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            detail.checking = this.widget.restaurants[index].id;

            Navigator.push(
                context, MaterialPageRoute(builder: (context) => DetailMenu()));
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
                      'https://restaurant-api.dicoding.dev/images/medium/${this.widget.restaurants[index].pictureId}'),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        this.widget.restaurants[index].name,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'lokasi : ' + this.widget.restaurants[index].city,
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
  }
}
