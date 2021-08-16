import 'package:cjp/Pages_View/Detalhe_Da_Ocorencia.dart';
import 'package:cjp/Pages_View/Home.dart';
import 'package:cjp/Pages_View/Minhas_Ocorrencias.dart';
import 'package:cjp/Pages_View/Perfil.dart';
import 'package:cjp/Pages_View/Registro_Prefil.dart';
import 'package:cjp/Pages_View/Adicionar_Ocorrencia.dart';
import 'package:flutter/material.dart';

import 'Pages_View/Login.dart';

class RouteGererator {
  static const String rota_Home = "/home";
  static const String rota_Login = "/";
  static const String rota_Registro = "/registro";
  static const String rote_Adicionar_corencias = "/adicionar_ocorencias";
  static const String rote_Detalhe_Ocorencia = "/detalhe";
  static const String rote_minhas_ocorencias = "/minhas_ocorencias";
  static const String rote_Perfil = "/meu_perfil";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => Login());
        break;
      case "/registro":
        return MaterialPageRoute(builder: (_) => Registro_Prefil());
        break;
      case "/home":
        return MaterialPageRoute(builder: (_) => Home());
        break;
      case "/adicionar_ocorencias":
        return MaterialPageRoute(builder: (_) => Adicionar_Ocorrencia(ocorrencias: args,));
        break;
      case "/detalhe":
        return MaterialPageRoute(builder: (_) => Detalhe_Da_Ocorencia(ocorrencias: args));
        break;
        case "/minhas_ocorencias":
        return MaterialPageRoute(builder: (_) => Minha_Ocorrencias());
        break;
      case "/meu_perfil":
        return MaterialPageRoute(builder: (_) => Meu_Perfil());
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
