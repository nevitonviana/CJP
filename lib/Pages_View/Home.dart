import 'package:cjp/WidgetCustom/Sections/List.dart';
import 'package:cjp/WidgetCustom/AppBar/Desktop_AppBar.dart';
import 'package:cjp/WidgetCustom/AppBar/Mobile_AppBar.dart';
import 'package:flutter/material.dart';
import '../BreakPoints.dart';
import '../Route.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: Colors.grey,
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
              constraints: BoxConstraints(maxWidth: 1000),
              child: ListView(
                children: [Lista()],
              ),
            ),
          ),
          drawer: Drawer(
            elevation: 3,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  child: Text("Prefil"),
                  decoration: BoxDecoration(color: Color(0x4F111DD7)),
                ),
                ListTile(
                  leading: Icon(Icons.input),
                  title: Text('Bem-Vindo'),
                  onTap: () => {},
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Configurações'),
                  onTap: () => {Navigator.of(context).pop()},
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
