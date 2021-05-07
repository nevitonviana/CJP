import 'package:cjp/BreakPoints.dart';
import 'package:cjp/Route.dart';
import 'package:cjp/WidgetCustom/AppBar/Mobile_AppBar.dart';
import 'package:cjp/WidgetCustom/AppBar/Web_AppBar.dart';
import 'package:cjp/WidgetCustom/Sections/List.dart';
import 'package:flutter/material.dart';

class Minhas_Ocorrencias extends StatefulWidget {
  const Minhas_Ocorrencias({Key key}) : super(key: key);

  @override
  _Minhas_OcorrenciasState createState() => _Minhas_OcorrenciasState();
}

class _Minhas_OcorrenciasState extends State<Minhas_Ocorrencias> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: constraints.maxWidth < mobile_breakPoint
              ? PreferredSize(
              preferredSize: Size(double.infinity, 56),
              child: Mobile_AppBar_Custom())
              : PreferredSize(
              child: Desktop_AppBar_Custom(),
              preferredSize: Size(double.infinity, 72)),
          body: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 900),
              child: ListView(
                children: [
                  Lista()
                ],
              ),
            ),
          ),
          drawer: Drawer(
            elevation: 3,
            child: ListView(
              children: [
                DrawerHeader(
                  child: Text("Prefil"),
                  decoration: BoxDecoration(color: Color(0x4F111DD7)),
                ),
                ListTile(
                  leading: Icon(Icons.input),
                  title: Text('Bem-Vindo'),
                  onTap: () => Navigator.pushNamed(
                      context, RouteGererator.rote_Ocorencias),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Configurações'),
                  onTap: () => {
                    Navigator.pushNamed(
                        context, RouteGererator.rote_Detalhe_Ocorencia)
                  },
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Logout'),
                  onTap: () => Navigator.pushReplacementNamed(
                      context, RouteGererator.rota_Login),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
