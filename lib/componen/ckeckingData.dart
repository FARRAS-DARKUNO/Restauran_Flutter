import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restauran_app_revisi/getData/pullHome.dart';
import 'package:restauran_app_revisi/getData/pullSeacrh.dart';
import 'package:provider/provider.dart';
import 'package:restauran_app_revisi/provider/checkDataProvider.dart';

class Checking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var ui = Provider.of<CheckDataProvider>(context);

    if (ui.checking == '') {
      return Container(child: PullHome());
    } else {
      return Container(child: Search(seacrhingfile: ui.checking));
    }
  }
}
