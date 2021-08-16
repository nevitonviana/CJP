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

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _bairroSelecionado;
  List<DropdownMenuItem<String>> _listaDeBairro = List();
  FirebaseFirestore db = FirebaseFirestore.instance;
  final _controller = StreamController<QuerySnapshot>.broadcast();

  _BuscoBairrosDoBDDropDown() async {
    _listaDeBairro = [];
    List _listaBairro = List();
    _listaBairro = await ListaDeBairro().Firebase();
    _listaDeBairro.add(DropdownMenuItem(
      child: Text(
        "Bairro",
        style: TextStyle(color: Colors.blue),
      ),
      value: null,
    ));
    for (var _bairro in _listaBairro) {
      if (_bairro != null) {
        _listaDeBairro.add(DropdownMenuItem(
          child: Text(_bairro),
          value: _bairro,
        ));
      }
    }
  }

  Future<Stream<QuerySnapshot>> _FiltroDeDados() async {
    bool admin = await getDoUsuario().Admin();
    Query query = db.collection("ocorrencias");
    if (admin) {
    } else {
      query = query.where("visivel", isEqualTo: true);
    }
    if (_bairroSelecionado != null) {
      query = query.where("bairro", isEqualTo: _bairroSelecionado);
    }

    Stream<QuerySnapshot> stream = query.snapshots();
    stream.listen((dados) {
      _controller.add(dados);
    });
  }

  @override
  void initState() {
    _BuscoBairrosDoBDDropDown();
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        DropdownButton(
                          items: _listaDeBairro,
                          value: _bairroSelecionado,
                          hint: Text("Bairro"),
                          onChanged: (value) {
                            setState(() {
                              _bairroSelecionado = value;
                            });
                            _FiltroDeDados();
                          },
                          iconSize: 30,
                          elevation: 6,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
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
                                      RouteGererator.rote_Detalhe_Ocorencia,
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
