import 'package:flutter/material.dart';

import '../Route.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF6F1CA),
      child: Center(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.cyanAccent,
            title: Column(
              children: [
                Text(
                  "CJP",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontStyle: FontStyle.italic),
                ),
                Text(
                  "Centro de Ajunda a Poculação",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                )
              ],
            ),
            centerTitle: true,
            elevation: 1,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.add_outlined),
              )
            ],
          ),
          body: Container(),
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
        ),
      ),
    );
  }
}
