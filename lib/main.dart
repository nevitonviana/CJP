import 'package:cjp/Pages_View/Login.dart';
import 'package:cjp/Route.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Login(),
    initialRoute: "/",
    onGenerateRoute: RouteGererator.generateRoute,
  ));
}
