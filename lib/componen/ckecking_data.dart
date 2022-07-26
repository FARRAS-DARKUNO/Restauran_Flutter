import 'package:flutter/material.dart';
import 'package:restauran_app_revisi/componen/have_data.dart';
import 'package:provider/provider.dart';
import 'package:restauran_app_revisi/componen/have_seacrh.dart';
import 'package:restauran_app_revisi/provider/check_data_provider.dart';

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
