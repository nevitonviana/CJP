import 'package:cjp/Route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Mobile_AppBar_Custom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white12,
      centerTitle: true,
      title: GestureDetector(
        onTap: ()=>Navigator.pushReplacementNamed(context, RouteGererator.rota_Home),
        child: Text(
          "CJP",
          style: TextStyle(
            fontSize: 25,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
