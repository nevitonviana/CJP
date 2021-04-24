import 'package:flutter/material.dart';

class Detalhe_Da_Ocorencia extends StatefulWidget {
  @override
  _Detalhe_Da_OcorenciaState createState() => _Detalhe_Da_OcorenciaState();
}

class _Detalhe_Da_OcorenciaState extends State<Detalhe_Da_Ocorencia> {
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
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1000),
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Container(
                      color: Colors.purpleAccent,
                      child: Icon(
                        Icons.account_tree_outlined,
                        size: 50,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text("Cidade"),
                        subtitle: Text("São Sebastião"),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text("Bairro"),
                        subtitle: Text("Boiçucaga"),
                      ),
                    ),
                  ],
                ),
                ListTile(
                  title: Text("Descrição"),
                  subtitle: Text(
                      "Texte, atenta às mudanças, é uma empresa que se caracteriza por seu espírito inovador. Agilidade e busca pela melhoria contínua dos serviços prestados são ..."),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
