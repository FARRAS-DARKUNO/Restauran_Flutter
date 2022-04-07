import 'package:flutter/material.dart';
import 'package:restauran_app_revisi/componen/no_internet.dart';
import 'package:restauran_app_revisi/provider/search_provider.dart';
import 'package:restauran_app_revisi/screen/detail.dart';
import 'package:restauran_app_revisi/provider/detail_page_provider.dart';
import 'package:provider/provider.dart';

class HaveSeach extends StatefulWidget {
  const HaveSeach({Key? key}) : super(key: key);

  @override
  State<HaveSeach> createState() => _HaveSeachState();
}

class _HaveSeachState extends State<HaveSeach> {
  @override
  Widget build(BuildContext context) {
    var detail = Provider.of<DetailPageProvider>(context);

    return Consumer<SearchProvider>(
      builder: (context, value, _) {
        if (value.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (value.state == ResultState.noData) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.search_off,
                  color: Colors.grey,
                  size: 80,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  value.message,
                  style: const TextStyle(fontSize: 24, color: Colors.grey),
                ),
              ],
            ),
          );
        } else if (value.state == ResultState.hasData) {
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: value.result!.restaurants.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  detail.checking = value.result!.restaurants[index].id;
                  //detail.searching = value.result!.restaurants[index];
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailPages(
                              data: value.result!.restaurants[index])));
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
                            'https://restaurant-api.dicoding.dev/images/medium/${value.result!.restaurants[index].pictureId}'),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              value.result!.restaurants[index].name,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'lokasi : ' +
                                  value.result!.restaurants[index].city,
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
          return const Center(child: Text(''));
        }
      },
    );
  }
}
