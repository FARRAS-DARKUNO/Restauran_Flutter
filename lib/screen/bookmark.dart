import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restauran_app_revisi/componen/empty.dart';
import 'package:restauran_app_revisi/provider/database_provider.dart';
import 'package:restauran_app_revisi/provider/detail_page_provider.dart';
import 'package:restauran_app_revisi/screen/detail.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  Widget build(BuildContext context) {
    var detail = Provider.of<DetailPageProvider>(context);
    return Consumer<DatabaseProvider>(
      builder: (context, value, child) {
        var restaurant = value.bookmarks;
        if (value.state == ResultStates.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (value.state == ResultStates.hasData) {
          return Scaffold(
            body: SafeArea(
                child: SingleChildScrollView(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: restaurant.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      detail.checking = restaurant[index].id;
                      detail.article = restaurant[index];

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailPages(data: detail.article)));
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
                                'https://restaurant-api.dicoding.dev/images/medium/${restaurant[index].pictureId}'),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  restaurant[index].name.toString(),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'lokasi : ' +
                                      restaurant[index].city.toString(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )),
          );
        } else if (value.state == ResultStates.error) {
          return Empty();
        } else if (value.state == ResultStates.noData) {
          return Empty();
        } else {
          return Empty();
        }
      },
    );
  }
}
