import 'package:flutter/material.dart';

class Mobile_AppBar_Custom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.cyanAccent[100],
        centerTitle: true,
        title: Column(
          children: [
             Text("CJP"),
             Text("Centro De Ajuto Ha População"),
          ],
        ));
  }
}
