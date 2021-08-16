import 'dart:async';
import 'package:cjp/Firebase/Firebase_Instance.dart';
import 'package:cjp/Model/Ocorencias.dart';
import 'package:cjp/WidgetCustom/AppBar/Web_AppBar.dart';
import 'package:cjp/WidgetCustom/AppBar/Mobile_AppBar.dart';
import 'package:cjp/WidgetCustom/Drawer/DrawerCustum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../BreakPoints.dart';
import '../Route.dart';

class Minha_Ocorrencias extends StatefulWidget {
  @override
  _Minha_OcorrenciasState createState() => _Minha_OcorrenciasState();
}

class _Minha_OcorrenciasState extends State<Minha_Ocorrencias> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final _controller = StreamController<QuerySnapshot>.broadcast();

  Future<Stream<QuerySnapshot>> _FiltroDeDados() async {
    Query query = db
        .collection("ocorrencias")
        .where("idUsuario", isEqualTo: IdUsuario().id());
    Stream<QuerySnapshot> stream = query.snapshots();
    stream.listen((dados) {
      _controller.add(dados);
    });
  }

  _deletarOcorencia(idOcorrencia) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("tem certeza que deseja Apagar esta ocorrencia?"),
            elevation: 5,
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Não",
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  )),
              FlatButton(
                  onPressed: () {
                    db.collection("ocorrencias").doc(idOcorrencia).delete();
                    Navigator.pop(context);
                  },
                  child: Text("Sim",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                      )))
            ],
          );
        });
    //
  }

  @override
  void initState() {
    super.initState();
    _FiltroDeDados();
  }

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
                  Container(
                    height: 45,
                    margin: EdgeInsets.all(15),
                  ),
                  StreamBuilder(
                    stream: _controller.stream,
                    //add algum aqui
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Center(
                            child: Column(
                              children: [
                                Text("Carrengando Ocorrencias"),
                                CircularProgressIndicator(),
                              ],
                            ),
                          );
                        case ConnectionState.active:
                        case ConnectionState.done:
                          QuerySnapshot querySnapshot = snapshot.requireData;
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Erro ao carregar as ocorrencias"),
                            );
                          } else {
                            if (snapshot.hasData) {
                              return GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                        crossAxisSpacing: 3,
                                        mainAxisSpacing: 3,
                                        maxCrossAxisExtent: 400,
                                        mainAxisExtent: 350),
                                itemCount: querySnapshot.docs.length,
                                itemBuilder: (context, index) {
                                  List<DocumentSnapshot> ocorrencias =
                                      querySnapshot.docs.toList();
                                  DocumentSnapshot ocorrencia =
                                      ocorrencias[index];
                                  Ocorrencias ocorrenci =
                                      Ocorrencias.fromDocumentSnapshot(
                                          ocorrencia);
                                  return GestureDetector(
                                    onTap: () => Navigator.pushNamed(
                                      context,
                                      RouteGererator.rote_Adicionar_corencias,
                                      arguments: ocorrenci,
                                    ),
                                    child: Card(
                                      margin: EdgeInsets.all(8),
                                      elevation: 3,
                                      color: Colors.grey[200],
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              margin: EdgeInsets.all(10),
                                              child: SizedBox(
                                                width: 350,
                                                height: 250,
                                                child: Image.network(
                                                  ocorrencia["fotos"][0],
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: ListTile(
                                                    title: Text("Bairro:"),
                                                    subtitle: Text(
                                                      ocorrencia["bairro"],
                                                      style: TextStyle(
                                                          fontSize: 19,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: ListTile(
                                              title: Text("ocorrido"),
                                              subtitle: Text(
                                                ocorrencia["nomeOcorencia"],
                                                style: TextStyle(
                                                  fontSize: 19,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              trailing: GestureDetector(
                                                onTap: () {
                                                  _deletarOcorencia(
                                                      ocorrencia["id"]);
                                                },
                                                child: Icon(
                                                  Icons.delete_forever,
                                                  color: Colors.red,
                                                  size: 35,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return Center(
                                child: Text("Não ha nunhuma ocorencias"),
                              );
                            }
                          }
                          break;
                      }
                      return Container();
                    },
                  )
                ],
              ),
            ),
          ),
          drawer: DraerCustom(constraints.maxWidth),
        );
      },
    );
  }
}
