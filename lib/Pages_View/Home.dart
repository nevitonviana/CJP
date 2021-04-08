import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../Route.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
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
            padding: EdgeInsets.only(right: 100),
            child: GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, RouteGererator.rote_Ocorencias),
              child: Icon(
                Icons.add_outlined,
                size: 50,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
                height: mediaQuery.size.height * 0.7,
                width: 500,
                child: ListView(
                  children: [
                    for (var a = 20; a >= 0; a--)
                      Card(
                          child: ListTile(
                        title: Text(
                            "The for loop is an implementation of a definite loop"),
                      ))
                  ],
                )),
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
  }
}
