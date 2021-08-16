import 'package:carousel_pro/carousel_pro.dart';
import 'package:cjp/BreakPoints.dart';
import 'package:cjp/Firebase/Firebase_Instance.dart';
import 'package:cjp/Model/Ocorencias.dart';
import 'package:cjp/WidgetCustom/AppBar/Mobile_AppBar.dart';
import 'package:cjp/WidgetCustom/AppBar/Web_AppBar.dart';
import 'package:cjp/WidgetCustom/TexteField/CustomTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Detalhe_Da_Ocorencia extends StatefulWidget {
  Ocorrencias ocorrencias;

  Detalhe_Da_Ocorencia({@required this.ocorrencias});

  @override
  _Detalhe_Da_OcorenciaState createState() => _Detalhe_Da_OcorenciaState();
}

class _Detalhe_Da_OcorenciaState extends State<Detalhe_Da_Ocorencia> {
  TextEditingController _controllerFeedback = TextEditingController();
  var admin = false;

  _verificarserEAdmin() async {
    var _admin = await getDoUsuario().Admin();
    setState(() {
      admin = _admin;
    });
  }

  List _getListaDeImagens() {
    List<String> listadeUrlDeimagens = widget.ocorrencias.fotos;
    return listadeUrlDeimagens.map((url) {
      return Container(
        height: 250,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: NetworkImage(url), fit: BoxFit.contain)),
      );
    }).toList();
  }

  _feedBack() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    widget.ocorrencias.feedback = _controllerFeedback.text;
    db
        .collection("ocorrencias")
        .doc(widget.ocorrencias.id)
        .set(widget.ocorrencias.toMap()).then((value){
          Navigator.pop(context);
    });
  }

  @override
  void initState() {
    _verificarserEAdmin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _verificarserEAdmin();
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: constraints.maxWidth < mobile_breakPoint
            ? PreferredSize(
                preferredSize: Size(double.infinity, 56),
                child: Mobile_AppBar_Custom())
            : PreferredSize(
                child: Desktop_AppBar_Custom(),
                preferredSize: Size(double.infinity, 72)),
        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1000),
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 75, 15, 50),
                color: Colors.grey[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 210,
                      child: Carousel(
                        dotColor: Colors.white,
                        images: _getListaDeImagens(),
                        boxFit: BoxFit.cover,
                        dotBgColor: Colors.white24,
                        dotIncreasedColor: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text("Ocorrido:"),
                            subtitle: Text(
                              widget.ocorrencias.nomeOcorencia,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text("Local:"),
                            subtitle: Text(
                              widget.ocorrencias.ruaAv,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text("Cidade:"),
                            subtitle: Text(
                              widget.ocorrencias.cidade,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text("Bairro:"),
                            subtitle: Text(
                              widget.ocorrencias.bairro,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      minVerticalPadding: 10,
                      title: Text("Descrição:"),
                      subtitle: Text(
                        widget.ocorrencias.descricao,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    ListTile(
                      title: Text("Resposta:"),
                      subtitle: Text(
                        widget.ocorrencias.feedback,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    admin
                        ? Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                              children: [
                                Text(
                                  "Deixa esta ocorrência",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      decoration: TextDecoration.underline),
                                ),
                                Text(
                                  " visilvel para os Usuarios",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      decoration: TextDecoration.underline),
                                ),
                                Center(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Não",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Switch(
                                          value: widget.ocorrencias.visivel,
                                          onChanged: (valor) {
                                            setState(() {
                                              widget.ocorrencias.visivel = valor;
                                            });
                                          }),
                                      Text(
                                        "Sim",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                CustomtextField(
                                  textEditingController: _controllerFeedback,
                                  labelText: "Resposta:",
                                  hintText: "Da um feedback aos Usuários ",
                                  maxLines: null,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: RaisedButton(
                                    color: Colors.blue[300],
                                    padding: EdgeInsets.all(20),
                                    elevation: 6,
                                      child: Text("Salvar"),
                                      onPressed: () => _feedBack()),
                                )
                              ],
                            ),
                        )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
