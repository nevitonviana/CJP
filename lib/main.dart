import 'package:cjp/Route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  /*FirebaseAuth auth = FirebaseAuth.instance;
  String email = "neviton@hotmail.com";
  String senha = "123456";
  auth
      .createUserWithEmailAndPassword(email: email, password: senha)
      .then((firebaseUser) {
    print("user: " + firebaseUser.user.toString());
  }).catchError((erro) {
    print("erro: " + erro.toString());
  });*/
  runApp(MaterialApp(
    theme: ThemeData(), //ou usar o temaPadrao
    title: "CJP",
    initialRoute: "/login",
    onGenerateRoute: RouteGererator.generateRoute,
  ));
}

final ThemeData temaPadrao = ThemeData();
