import 'package:cjp/Pages_View/Home.dart';
import 'package:cjp/Pages_View/Registro_Prefil.dart';
import 'package:flutter/material.dart';

import 'Pages_View/Login.dart';

class RouteGererator {
  static const String rota_Home = "/home";
  static const String rota_Login = "/";
  static const String rota_Registro = "/registro";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => Login());
        break;
      case "/login":
        return MaterialPageRoute(builder: (_) => Login());
        break;
      case "/registro":
        return MaterialPageRoute(builder: (_) => Registro_Prefil());
        break;
      case "/home":
        return MaterialPageRoute(builder: (_) => Home());
        break;
      default:
        _erroRota();
    }
  }

  static Route<dynamic> _erroRota() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Error"),
          backgroundColor: Colors.grey,
        ),
        body: Center(
          child: Text("Tela não encontrada"),
        ),
        backgroundColor: Colors.red,
      );
    });
  }
}
