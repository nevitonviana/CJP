import 'package:cjp/WidgetCustom/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Ocorrencia extends StatefulWidget {
  @override
  _OcorrenciaState createState() => _OcorrenciaState();
}

class _OcorrenciaState extends State<Ocorrencia> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("ocorencias"),
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              child: Container(
                padding: EdgeInsets.only(right: 30, left: 30),
                height: mediaQuery.size.height * 0.7,
                width: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 50,
                    ),
                    CustomtextField(
                      hintText: "Bairro",
                    ),
                    CustomtextField(
                      hintText: "Rua",
                    ),
                    CustomtextField(
                      hintText: "Tipo",
                    ),
                    CustomtextField(
                      hintText: "Descrição",
                    ),
                    RaisedButton(
                      onPressed: ()=> Navigator.pop(context),
                      child: Text("Enviar"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
