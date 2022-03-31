import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restauran_app_revisi/componen/titled.dart';
import 'package:restauran_app_revisi/componen/empty.dart';
import 'package:restauran_app_revisi/componen/haveData.dart';
// import 'package:restauran_app_revisi/getData/pullHome.dart';
// import 'package:restauran_app_revisi/getData/pullSeacrh.dart';
import 'package:restauran_app_revisi/componen/ckeckingData.dart';
import 'package:restauran_app_revisi/provider/checkDataProvider.dart';

import 'package:restauran_app_revisi/screen/detail.dart';

class Home extends StatefulWidget {
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
