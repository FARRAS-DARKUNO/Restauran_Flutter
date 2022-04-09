import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restauran_app_revisi/api/get_restaurant_detail.dart';
import 'package:restauran_app_revisi/componen/no_internet.dart';
import 'package:restauran_app_revisi/provider/database_provider.dart';
import 'package:restauran_app_revisi/provider/detail_page_provider.dart';
import 'package:restauran_app_revisi/provider/detail_provider.dart';

class DetailPages extends StatefulWidget {
  const DetailPages({
    Key? key,
  }) : super(key: key);
  @override
  State<DetailPages> createState() => _DetailPagesState();
}

class _DetailPagesState extends State<DetailPages> {
  //bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    var detail = Provider.of<DetailPageProvider>(context);
    final url = "http://restaurant-api.dicoding.dev/detail/" + detail.checking;

    return Scaffold(
      body: ChangeNotifierProvider<RestaurantDetailProvider>(
        create: (_) => RestaurantDetailProvider(
            apiService: RestaurantDetail(), id: detail.checking),
        child: Consumer<RestaurantDetailProvider>(
          builder: (context, value, _) {
            if (value.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (value.state == ResultState.error) {
              return NoInternet();
            } else if (value.state == ResultState.hasData) {
              return Consumer<DatabaseProvider>(
                builder: (context, provider, child) {
                  return FutureBuilder<bool>(
                    future: provider.isBookmarked(detail.checking),
                    builder: (context, snapshot) {
                      var isBookmarked = snapshot.data ?? false;

                      // final Restaurant datas = Restaurant(
                      //     id: detail.checking,
                      //     name: value.result.name,
                      //     description: value.result.description,
                      //     city: value.result.city,
                      //     pictureId: value.result.pictureId,
                      //     menus: value.result.menus);

                      return Material(
                        child: SafeArea(
                          child: SingleChildScrollView(
                            child: Container(
                              color: Color.fromARGB(255, 203, 245, 247),
                              margin:
                                  EdgeInsets.only(right: 8, left: 8, bottom: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      Container(
                                        height: 265,
                                        child: Center(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            child: Image.network(
                                                'https://restaurant-api.dicoding.dev/images/medium/${value.result.pictureId}'),
                                          ),
                                        ),
                                      ),
                                      CircleAvatar(
                                        backgroundColor: Colors.grey,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.arrow_back,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            value.result.name,
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.location_on),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                value.result.city,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      InkWell(
                                        child: isBookmarked
                                            ? IconButton(
                                                icon: Icon(Icons.favorite),
                                                color: Colors.red,
                                                onPressed: () {
                                                  setState(() {
                                                    provider.removeBookmark(
                                                        detail.checking);
                                                    print('ini Remove');
                                                  });
                                                })
                                            : IconButton(
                                                icon: Icon(Icons.favorite),
                                                color: Colors.grey,
                                                onPressed: () {
                                                  setState(() {
                                                    provider.addBookmark(
                                                        detail.article);
                                                    print('Ini Add');
                                                  });
                                                }),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    value.result.description,
                                    textAlign: TextAlign.justify,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'MENU',
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'FOODS',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall,
                                            ),
                                            ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: value
                                                    .result.menus.foods.length,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () {},
                                                    child: Card(
                                                      child: Container(
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: Center(
                                                            child: Text(value
                                                                .result
                                                                .menus
                                                                .foods[index]
                                                                .name),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Drinks',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall,
                                            ),
                                            ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: value
                                                    .result.menus.drinks.length,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () {},
                                                    child: Card(
                                                      child: Container(
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: Center(
                                                            child: Text(value
                                                                .result
                                                                .menus
                                                                .drinks[index]
                                                                .name),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            } else {
              return const Text("");
            }
          },
        ),
      ),
    );
  }
}
