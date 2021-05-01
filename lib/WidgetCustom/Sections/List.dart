import 'package:cjp/Route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Lista extends StatefulWidget {
  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
        maxCrossAxisExtent: 400,
        mainAxisExtent: 350
      ),
      itemCount: 16,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(8),
          child: Card(
            color: Colors.grey[200],
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    color: Colors.blue,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text("Bairro:"),
                          subtitle: Text("Boissucanga"),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text("ocorrido"),
                    subtitle: Text("ponte caida"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
