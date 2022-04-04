import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restauran_app_revisi/componen/haveData.dart';

import 'package:provider/provider.dart';
import 'package:restauran_app_revisi/componen/haveSeacrh.dart';
import 'package:restauran_app_revisi/provider/checkDataProvider.dart';

class Checking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var ui = Provider.of<CheckDataProvider>(context);

    if (ui.checking == '') {
      return Container(child: HaveData());
    } else {
      return Container(child: HaveSeach());
    }
  }
}
