import 'package:cjp/Route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: true,
    title: "CJP",
    initialRoute: "/",
    onGenerateRoute: RouteGererator.generateRoute,
  ));
}






