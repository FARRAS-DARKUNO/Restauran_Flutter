import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Titled extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      height: 40,
      child: Text(
        'Restauran App',
        style: TextStyle(
          fontSize: 26,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }
}
