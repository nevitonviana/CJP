import 'package:flutter/material.dart';

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
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        maxCrossAxisExtent: 400,
      ),
      itemCount: 16,
      itemBuilder: (context, index) {
        return Container(
          child: Card(
            child: ListTile(
              title: Text("Sao Sebastiao"),
              subtitle: Text("Acendente de carro"),
            ),
          ),
        );
      },
    );
  }
}
