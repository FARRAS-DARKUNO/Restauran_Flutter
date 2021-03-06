import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restauran_app_revisi/componen/titled.dart';
import 'package:restauran_app_revisi/componen/ckecking_data.dart';
import 'package:restauran_app_revisi/provider/check_data_provider.dart';
import 'package:restauran_app_revisi/provider/search_provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String nameRestaurant = '';

  TextEditingController myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var ui = Provider.of<CheckDataProvider>(context);
    var qw = Provider.of<SearchProvider>(context);

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Titled(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: TextField(
                  //controller: myController,
                  onChanged: (String value) {
                    setState(() {
                      ui.checking = value;
                      qw.fetchAllRestaurantSearch(value);
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a search term',
                  ),
                ),
              ),
              Consumer<CheckDataProvider>(
                builder: (context, value, _) {
                  return Checking();
                },
              )
            ],
          ),
        ),
      ),
    ));
  }
}
